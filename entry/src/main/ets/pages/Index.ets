import { PlayStateType, TabClass } from '../model'
import { PLAY_KEY, PreferenceManager } from '../utils/PreferencesManager'
import { SONG_KEY } from '../constants/EventConstants'
import { tabsData } from '../model/MusicConstants'
import Find from './Find'
import Moment from './Moment'
import Mine from './Mine'
import SongList from './SongList'
import PlayerNav from '../components/playerNav'
import { PersistenceV2, router } from '@kit.ArkUI'
import Recommend from './Recommend'


@Entry
@ComponentV2
struct HomeIndex {
  @Local currentName: string = 'recommend'
  @Local opacityNum: number = 1
  @Local playState: PlayStateType = PersistenceV2.connect(PlayStateType, SONG_KEY, () => new PlayStateType())!
  //private preferencesInstance: PreferenceManager = PreferenceManager.getInstance()


  async aboutToAppear(): Promise<void> {
    /*emitter.on({ eventId: EmitEventType.UPDATE_STATE}, data => {
      console.log('updateState',JSON.stringify(data.data?.playState))
      if(data.data && data.data?.playState){
        this.playState = data.data?.playState
      }
    })*/
    //输出播放状态
    this.playState = PersistenceV2.connect(PlayStateType, SONG_KEY, () => new PlayStateType())!
    console.log('updateState index',this.playState.time, " and ", this.playState.playList.length, this.playState.playIndex)
/*
    this.preferencesInstance.getValue<PlayStateType>(PLAY_KEY).then((data) => {
      if( data && data.playList.length > 0){
        this.playState.img = (data as PlayStateType).img
        this.playState.name = (data as PlayStateType).name
        this.playState.author = (data as PlayStateType).author
        this.playState.isPlay = (data as PlayStateType).isPlay
        this.playState.playList = (data as PlayStateType).playList
        this.playState.playIndex = (data as PlayStateType).playIndex
        this.playState.url = (data as PlayStateType).url
        this.playState.playMode = (data as PlayStateType).playMode
        this.playState.time = (data as PlayStateType).time
        this.playState.duration = (data as PlayStateType).duration
      }
      this.isLoad = true
    })
*/
  }

  // tabBar组件
  @Builder
  getTabBar(item: TabClass) {
    Column() {
      Row() {
        Image(item.icon)
          .fillColor(item.name === this.currentName ? Color.White : $r('app.color.primary_dark'))
          .width(item.name === this.currentName ? 18 : 22)
          .aspectRatio(1)
      }
      .width(22)
      .aspectRatio(1)
      .borderRadius(22)
      .backgroundColor(item.name === this.currentName ? $r('app.color.primary_light') : Color.Transparent)
      .justifyContent(FlexAlign.Center)

      Text(item.title)
        .fontSize(12)
        .fontWeight(400)
        .margin({ top: 5 })
        .fontColor(item.name === this.currentName ? $r('app.color.primary_light') : $r('app.color.primary_dark'))
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  aboutToDisappear(): void {
    PersistenceV2.save(SONG_KEY)
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        Tabs({ barPosition: BarPosition.End }) {
          ForEach(tabsData, (item: TabClass) => {
            TabContent() {
              if (item.name === 'recommend') {
                Recommend()
              } else if (item.name === 'find') {
                Find()
              } else if (item.name === 'moment') {
                Moment()
              } else if (item.name === 'mine') {
                Mine({ playState: this.playState })
              } else {
                SongList()
              }
            }
            .tabBar(this.getTabBar(item))
            .backgroundColor('#3c3f41')
          })
        }
        .barHeight(60)
        .onChange(index => {
          this.currentName = tabsData[index].name
        })

        // 背景播放
        PlayerNav()
          .translate({ y: -60 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Play'
            })
          })
          .visibility(this.playState.playList.length > 0 && this.currentName !== 'mine' ? Visibility.Visible : Visibility.Hidden)

      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#3c3f41')
    .opacity(this.opacityNum)
    .padding({
      top: AppStorage.get("topHeight") as LengthMetrics,
      bottom: AppStorage.get("bottomHeight") as LengthMetrics
    })
  }
}
