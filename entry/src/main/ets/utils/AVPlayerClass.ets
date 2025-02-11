import { media } from '@kit.MediaKit';
import { commonEventManager } from '@kit.BasicServicesKit';
import { PublishEventType, SONG_KEY } from '../constants/EventConstants';
import { PersistenceV2, router } from '@kit.ArkUI';
import { FORM_ID_KEY, PLAY_KEY, PreferenceManager } from './PreferencesManager';
import { formBindingData, formProvider } from '@kit.FormKit';
import { SubscriberClass } from './SubscriberClass';
import { Http2BufferClass } from './Http2Buffer';
import { AvSessionManager } from './AvSessionManager';
import backgroundTaskManager from '@ohos.resourceschedule.backgroundTaskManager';
import { wantAgent } from '@kit.AbilityKit';
import { PlayStateType, songItemType } from '../model';

let subscriber: commonEventManager.CommonEventSubscriber;

@ObservedV2
export default class AVPlayerClass {
  private static instance: AVPlayerClass = new AVPlayerClass();
  private preferencesInstance: PreferenceManager = PreferenceManager.getInstance();
  // 1.创建一个播放器
  player: null | media.AVPlayer = null;
  // 节流阀标识
  timer = -1;
  currentSong: PlayStateType = PersistenceV2.connect(PlayStateType, SONG_KEY, () => new PlayStateType())!; // 初始化为默认的 PlayStateType 实例

  static getInstance() {
    if (!AVPlayerClass.instance) {
      AVPlayerClass.instance = new AVPlayerClass();
    }
    return AVPlayerClass.instance;
  }

  // 2.初始化
  async init() {
    // 监听卡片创建的事件
    SubscriberClass.subscribe(PublishEventType.CARD_PUBLISH, subscriber as commonEventManager.CommonEventSubscriber, (event) => {
      switch (event) {
        case 'next':
          this.next();
          break;
        case 'prev':
          this.previous();
          break;
        default:
        // event是卡片ID
          PreferenceManager.getInstance().setValue<string>(FORM_ID_KEY, event);
      }
    });
    this.player = await media.createAVPlayer();
    // 读取首选项的状态，并且更新（防止应用强杀导致的状态不一致）
    let playState: PlayStateType | null = await this.preferencesInstance.getValue<PlayStateType>(PLAY_KEY)
    //let playState: PlayStateType = PersistenceV2.connect(PlayStateType,SONG_KEY, () => new PlayStateType())!
    //console.log('updateState av',playState.time, playState.url, playState.playList.length, playState.playIndex)
    if (playState !== null) {
      /*playState.isPlay = false;
      this.currentSong.img = playState.img;
      this.currentSong.name = playState.name;
      this.currentSong.author = playState.author;
      this.currentSong.url = playState.url;
      this.currentSong.playList = playState.playList;
      this.currentSong.playIndex = playState.playIndex;
      this.currentSong.duration = playState.duration;
      this.currentSong.isPlay = playState.isPlay;
      this.currentSong.playMode = playState.playMode;
      this.currentSong.time = playState.time;*/
      this.currentSong = playState;
      // 回写首选项
      this.preferencesInstance.setValue<PlayStateType>(PLAY_KEY, playState);
    }

    // 监听播放器的状态
    this.player.on('stateChange', (state) => {
      console.log(`stateChange: ${state}`);
      switch (state) {
        case 'initialized':
          this.player?.prepare();
          break;
        case 'prepared':
          this.player?.seek(this.currentSong.time);
          break;
        case 'completed':
          if (this.currentSong.playMode === 'random' && this.currentSong.playList.length > 1) {
            let index = 0;
            // 随机播放, 非自身
            do {
              index = Math.floor(Math.random() * this.currentSong.playList.length);
            } while (index === this.currentSong.playIndex);
            this.currentSong.playIndex = index;
          } else if (this.currentSong.playMode === 'auto') {
            this.currentSong.playIndex++;
            this.currentSong.playIndex = (this.currentSong.playIndex + this.currentSong.playList.length) % this.currentSong.playList.length;
          }
          this.singlePlay(this.currentSong.playList[this.currentSong.playIndex]);
          break;
      }
    });
    // 监听歌曲时长
    this.player.on('durationUpdate', (duration) => {
      this.currentSong.duration = duration;
      AvSessionManager.setAvMetaData(this.currentSong.playList[this.currentSong.playIndex]);
    });
    // 监听播放时长
    this.player.on('timeUpdate', (time) => {
      if (time !== 0 && this.currentSong.time !== time) {
        this.currentSong.time = time;
        // 更新页面状态、首选项
        this.updateState();
        AvSessionManager.setAvPlayBackState(); // 设置状态
      }
    });

    // 监听设置播放时长
    this.player.on('seekDone', () => {
      this.player?.play();
      this.currentSong.isPlay = true;
    });
  }

  // 单曲播放
  async singlePlay(song: songItemType) {
    this.startBackgroundTask();
    this.currentSong.img = song.img
    this.currentSong.name = song.name
    this.currentSong.author = song.author
    this.currentSong.url = song.url
    if(this.currentSong.playList === undefined){
      this.currentSong.playList = [];
    }
    const isList = this.currentSong.playList.some((item) => item.id === song.id);
    // 判断是否在播放列表中
    if (isList) {
      if (song.url === this.player?.url) {
        // 当前是否正在播放
        if (this.currentSong.isPlay) {
          // 重新播放
          this.player.url = song.url;
          await this.changePlay();
        } else {
          // 继续播放(设置播放器到指定时间)
          this.player?.seek(this.currentSong.time);
        }
      } else {
        // 断点续播
        if (this.player?.url === "") {
          // 将状态机置为准备状态，才能使用seek
          this.player.url = song.url;
        } else {
          // 切换播放, 设置歌曲索引
          const index = this.currentSong.playList.findIndex((item) => item.id === song.id);
          this.currentSong.playIndex = index;
          await this.changePlay();
        }
      }
    } else {
      // 如果不在播放列表中，
      // 加到播放列表，播放
      if (this.player !== null) {
        this.currentSong.playList.unshift(song);
        this.currentSong.playIndex = 0;
        await this.changePlay();
      }
    }
    //PersistenceV2.save(SONG_KEY)
    AvSessionManager.setAvPlayBackState(); // 设置状态
  }

  // 切换歌曲
  async changePlay() {
    // 将播放状态置为闲置
    await this.player?.reset();
    this.currentSong.time = 0;
    this.currentSong.duration = 0;
    if (this.player !== null) {
      this.player.url = this.currentSong.playList[this.currentSong.playIndex].url;
    }
  }

  // 暂停歌曲
  async pausePlay() {
    this.currentSong.isPlay = false;
    await this.player!.pause();
    AvSessionManager.setAvPlayBackState(); // 设置状态
  }

  // 切换播放模式
  changePlayMode(mode: 'auto' | 'repeat' | 'random') {
    this.currentSong.playMode = mode;
    // 更新页面状态
    this.updateState();
  }

  // 上一首
  previous() {
    // 判断有没有歌
    if (this.currentSong.playList.length === 0) return;
    if (this.currentSong.playMode === 'random' && this.currentSong.playList.length > 1) {
      let index = 0;
      // 随机播放, 非自身
      do {
        index = Math.floor(Math.random() * this.currentSong.playList.length);
      } while (index === this.currentSong.playIndex);
      this.currentSong.playIndex = index;
    } else {
      this.currentSong.playIndex--;
      // 有可能变为负数
      this.currentSong.playIndex = (this.currentSong.playIndex + this.currentSong.playList.length) % this.currentSong.playList.length;
    }
    this.singlePlay(this.currentSong.playList[this.currentSong.playIndex]);
  }

  // 下一首
  next() {
    // 判断有没有歌
    if (this.currentSong.playList.length === 0) return;
    if (this.currentSong.playMode === 'random' && this.currentSong.playList.length > 1) {
      let index = 0;
      // 随机播放, 非自身
      do {
        index = Math.floor(Math.random() * this.currentSong.playList.length);
      } while (index === this.currentSong.playIndex);
      this.currentSong.playIndex = index;
    } else {
      this.currentSong.playIndex++;
      // 有可能变为负数
      this.currentSong.playIndex = (this.currentSong.playIndex + this.currentSong.playList.length) % this.currentSong.playList.length;
    }
    this.singlePlay(this.currentSong.playList[this.currentSong.playIndex]);
  }

  // 删除列表歌曲
  async remove(index: number) {
    // 当前是否正在播放这首歌
    if (this.currentSong.playIndex === index) {
      // 删完还有歌吗？
      if (this.currentSong.playList.length > 1) {
        this.currentSong.playList.splice(index, 1);
        // 切换歌曲前，要计算出切换的索引
        this.currentSong.playIndex = (this.currentSong.playIndex + this.currentSong.playList.length) % this.currentSong.playList.length;
        this.singlePlay(this.currentSong.playList[this.currentSong.playIndex]);
      } else {
        // 删完了
        await this.player?.reset();
        this.currentSong.playList = [];
        this.currentSong.time = 0;
        this.currentSong.duration = 0;
        this.currentSong.isPlay = false;
        // 推送到首选项（要不然，播放列表删除完之后，重新冷启动应用，会出现列表不为空的现象）
        PersistenceV2.save(SONG_KEY)
        await this.preferencesInstance.setValue<PlayStateType>(PLAY_KEY, this.currentSong);
        router.back();
      }
    } else {
      // 删除播放前面的
      if (this.currentSong.playIndex > index) {
        this.currentSong.playIndex--;
      }
      this.currentSong.playList.splice(index, 1);
    }
  }

  //列表播放
  async listPlay(list: songItemType[], index: number) {
    this.currentSong.playList = list
    this.currentSong.playIndex = index
    this.singlePlay(this.currentSong.playList[this.currentSong.playIndex])
  }

  // 开启后台长时间任务
  async startBackgroundTask() {
    //会话对象只要存在就不用开启
    if( AvSessionManager.session.sessionId){
      return
    }
    try {
      let wantAgentInfo: wantAgent.WantAgentInfo = {
        wants: [
          {
            bundleName: 'com.example.heimacloudmusic',
            abilityName: 'EntryAbility'
          }
        ],
        actionType: wantAgent.OperationType.START_ABILITY,
        requestCode:0,
        actionFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
      }
      const want = await wantAgent.getWantAgent(wantAgentInfo)
      //申请长时任务
      await backgroundTaskManager.startBackgroundRunning(getContext(), backgroundTaskManager.BackgroundMode.AUDIO_PLAYBACK, want)
    }catch (e){
      AlertDialog.show({message: e.message})
    }
  }

  private async updateState() {
    if(this.timer === -1){
      console.log(`logdate:` , `update`);
      // 更新首选项
      this.currentSong.img = this.currentSong.playList[this.currentSong.playIndex].img
      this.currentSong.name = this.currentSong.playList[this.currentSong.playIndex].name
      this.currentSong.author = this.currentSong.playList[this.currentSong.playIndex].author
      this.currentSong.url = this.currentSong.playList[this.currentSong.playIndex].url

      this.preferencesInstance.setValue<PlayStateType>(PLAY_KEY, this.currentSong)
      // 更新到卡片
      const id = await this.preferencesInstance.getValue<string>(FORM_ID_KEY)
      console.log("testTag appForm" + id)
      Http2BufferClass.get(this.currentSong.img, getContext(), (res) => {
        console.log("testTag appForm" + JSON.stringify(res))
        formProvider.updateForm(id, formBindingData.createFormBindingData({
          playState: this.currentSong,
          fileName: res.fileName,
          //必须要传的
          formImages:res.formImages
        }))

      })
      // 锁上
      this.timer = setTimeout(() => {
        this.timer = -1;
      }, 1000)
    }
    //输出currentSong的JSON序列化
    console.log('updateState test',JSON.stringify(this.currentSong))
  }

}