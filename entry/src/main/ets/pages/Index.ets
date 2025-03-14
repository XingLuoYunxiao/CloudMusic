import { TabClass } from '../model/TabClass'
import { SONG_KEY } from '../constants/EventConstants'
import { tabsData } from '../model/MusicConstants'
import Find from './Find'
import Moment from './Moment'
import Mine from './Mine'
import SongList from './SongList'
import PlayerNav from '../components/playerNav'
import { PersistenceV2, router } from '@kit.ArkUI'
import Recommend from './Recommend'
import { PlayStateType } from '../model/playState'
import AVPlayerClass from '../utils/AVPlayerClass'
import { AvSessionManager } from '../utils/AvSessionManager'
import { common } from '@kit.AbilityKit'


@Entry
@ComponentV2
struct HomeIndex {
  @Local currentName: string = 'recommend'
  @Local opacityNum: number = 1
  @Local playState: PlayStateType = PersistenceV2.connect(PlayStateType, SONG_KEY, () => new PlayStateType())!
  @Local currentIndex: number = 0
  //private preferencesInstance: PreferenceManager = PreferenceManager.getInstance()
  private context: common.UIAbilityContext | undefined = AppStorage.get('context');


  async aboutToAppear(): Promise<void> {

    /*emitter.on({ eventId: EmitEventType.UPDATE_STATE}, data => {
      console.log('updateState',JSON.stringify(data.data?.playState))
      if(data.data && data.data?.playState){
        this.playState = data.data?.playState
      }
    })*/
  }

  aboutToDisappear(): void {
    if( AvSessionManager.session.sessionId && this.context){
      AVPlayerClass.getInstance().stopContinuousTask( this.context)
    }
    /*this.playState.isPlay = false;
    PersistenceV2.save(SONG_KEY)*/
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



  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        Tabs({ barPosition: BarPosition.End,index: this.currentIndex}) {
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
          this.currentIndex = index
          this.currentName = tabsData[this.currentIndex].name
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
    .backgroundColor($r('app.color.app_background_color'))
    .opacity(this.opacityNum)
    .padding({
      top: AppStorage.get("topHeight") as LengthMetrics,
      bottom: AppStorage.get("bottomHeight") as LengthMetrics
    })
  }
}
