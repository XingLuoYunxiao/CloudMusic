import { PersistenceV2, window } from '@kit.ArkUI'
import AVPlayerClass from '../utils/AVPlayerClass'
import { AvSessionManager } from '../utils/AvSessionManager'
import { common } from '@kit.AbilityKit'
import { NumberKey } from '../model/Key'
import { COLOR_MODE_KEY, SONG_KEY } from '../constants/EventConstants'
import { PlayStateType } from '../model/playState'

@Entry
@ComponentV2
struct Advertisement {
  @Local time: number = 5
  timer: number = -1
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  @Local playState: PlayStateType = PersistenceV2.connect(PlayStateType, SONG_KEY, () => new PlayStateType())!


  aboutToAppear() {
    let currentColorMode:NumberKey = PersistenceV2.connect(NumberKey, COLOR_MODE_KEY, () => new NumberKey(-1))!
    this.context.getApplicationContext().setColorMode(currentColorMode.key);
    AVPlayerClass.getInstance().init()
    AvSessionManager.init(this.context).then( () => {
      this.playState.isPlay = false;
    })

    // 必须重置才能改动画的内容
    this.timer = setInterval(() => {
      if (this.time <= 0) {
        clearInterval(this.timer)
        window.findWindow("ad_win").destroyWindow()
        return
      }
      this.time -= 1
    }, 1000)
  }

  aboutToDisappear() {
    clearInterval(this.timer)
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Button(`跳过${this.time}`)
        .onClick(() => {
          window.findWindow("ad_win").destroyWindow()
        })
        .margin(12)
        .backgroundColor('#ccc')
        .fontColor('#fff')
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.ad'))
    .backgroundImageSize({
      width: '100%',
      height: '100%'
    })
    .padding({
      top: AppStorage.get("topHeight") as LengthMetrics,
      bottom: AppStorage.get("bottomHeight") as LengthMetrics
    })
  }
}