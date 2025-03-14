import { avSession } from '@kit.AVSessionKit';
import { songItemType } from '../model/playState';
import AVPlayerClass from './AVPlayerClass';

export class AvSessionManager{
  static session: avSession.AVSession //媒体会话对象
  static controller: avSession.AVSessionController
  static async init(context: Context){
    //拿到会话对象
    AvSessionManager.session = await avSession.createAVSession(context, "bgPlay", "audio")
    AvSessionManager.controller = await AvSessionManager.session.getController()
    AvSessionManager.registerEvent()
  }

  // 设置媒体元数据（封面信息）
  static async setAvMetaData(song : songItemType){
    await AvSessionManager.session.setAVMetadata({
      assetId: song.id,
      title: song.name,
      author: song.author,
      artist: song.author,
      album: song.name,
      duration: AVPlayerClass.getInstance().currentSong.duration,
      mediaImage: song.img
    })
  }

  // 设置媒体播放状态
  static async setAvPlayBackState(){
    AvSessionManager.session.setAVPlaybackState({
      state: AVPlayerClass.getInstance().currentSong.isPlay ? avSession.PlaybackState.PLAYBACK_STATE_PLAY : avSession.PlaybackState.PLAYBACK_STATE_PAUSE,
      position: {
        elapsedTime: AVPlayerClass.getInstance().currentSong.time,
        updateTime: new Date().getTime()
      },
      speed: 1,
      duration: AVPlayerClass.getInstance().currentSong.duration
    })
  }

  // 注册会话对象传递过来的
  static async registerEvent(){
    AvSessionManager.session.on('play', () => {
      AVPlayerClass.getInstance().singlePlay(AVPlayerClass.getInstance().currentSong.playList[AVPlayerClass.getInstance().currentSong.playIndex])
    })
    AvSessionManager.session.on('pause', () => {
      AVPlayerClass.getInstance().pausePlay()
    })
    AvSessionManager.session.on('playNext', () => {
      AVPlayerClass.getInstance().next()
    })
    AvSessionManager.session.on('playPrevious', () => {
      AVPlayerClass.getInstance().previous()
    })
    AvSessionManager.session.on('seek', (time) => {
      AVPlayerClass.getInstance().player?.seek(time)
    })
    await AvSessionManager.session.activate()

  }


}