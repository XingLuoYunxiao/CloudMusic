import AVPlayerClass from '../utils/AVPlayerClass'
import { PersistenceV2 } from '@kit.ArkUI'
import { SONG_KEY } from '../constants/EventConstants'
import { PlayStateType } from '../model/playState'

@ComponentV2
struct PlayerNav {
  @Local playState: PlayStateType = PersistenceV2.connect(PlayStateType, SONG_KEY, () => new PlayStateType())!
  @Local AVPlayer: AVPlayerClass = AVPlayerClass.getInstance()


  build() {
    Row() {
      Row({ space: 10 }) {
        Image(this.playState.img)
          .width(40)
          .aspectRatio(1)
        Column() {
          Text(this.playState.name)
            .fontColor('#fff')
          Text(this.playState.author)
            .fontSize(12)
            .fontColor('#ccc')
        }.alignItems(HorizontalAlign.Start)
      }.height('100%')
      .alignItems(VerticalAlign.Center)

      Row({ space: 16 }) {
        Image($r("app.media.ic_prev"))
          .width(20)
          .aspectRatio(1)
          .fillColor('#4cafc6')
          .onClick(() => {
            // 上一首
            this.AVPlayer.previous()
          })

        Image(this.playState.isPlay ? $r('app.media.ic_paused') : $r('app.media.ic_play'))
          .fillColor('#4cafc6')
          .width(20)
          .onClick(() => {
            // 暂停 播放
            if(this.playState.isPlay){
              this.AVPlayer.pausePlay()
            }else{
              this.AVPlayer.singlePlay(this.playState.playList[this.playState.playIndex])
            }
          })

        Image($r('app.media.ic_next'))
          .width(20)
          .aspectRatio(1)
          .fillColor('#4cafc6')
          .onClick(() => {
            // 下一首
            this.AVPlayer.next()
          })

      }.height('100%')
    }
    .width('100%')
    .height(60)
    .backgroundColor('#ff1c1c21')
    .justifyContent(FlexAlign.SpaceBetween)

  }
}

export default PlayerNav