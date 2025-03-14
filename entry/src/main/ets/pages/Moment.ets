import { momentList } from '../model/MusicConstants'
import AVPlayerClass from '../utils/AVPlayerClass'
import { PersistenceV2 } from '@kit.ArkUI'
import { NumberKey } from '../model/Key'
import { COLOR_MODE_KEY } from '../constants/EventConstants'
import { momentListType } from '../model/music'

@Entry
@ComponentV2
struct Moment {
  @Local AVPlayer: AVPlayerClass = AVPlayerClass.getInstance()
  @Local currentColorMode: NumberKey = PersistenceV2.connect(NumberKey, COLOR_MODE_KEY, () => new NumberKey(0))!


  build() {
    Column() {
      Row() {
        Text('互动广场')
          .fontColor($r('app.color.font_color'))
      }
      .padding(24)
      .width('100%')
      Row() {
        List({ space: 12 }) {
          ForEach(momentList, (item: momentListType) => {
            ListItem() {
              Row({ space: 12 }) {
                Row() {
                  Image(item.avatar)
                    .borderRadius(40)
                    .width(40)
                }

                Column({ space: 12 }) {
                  // 作者
                  Text(item.author)
                    .fontColor($r('app.color.font_color'))
                  // 内容
                  Text(item.content)
                    .fontColor(this.currentColorMode.key === 1 ? Color.Black :'#aaa9af')
                    .fontSize(12)
                  // 音乐卡片
                  Row() {
                    Image(item.song.img)
                      .width(60)
                      .aspectRatio(1)
                    Column({ space: 10 }) {
                      Text(item.song.name)
                        .fontColor('#f4f4f6')
                        .fontSize(12)
                      Text(item.song.author)
                        .fontColor('#a8a8ad')
                        .fontSize(10)
                    }
                    .layoutWeight(1)
                    .height(60)
                    .alignItems(HorizontalAlign.Start)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .padding(12)
                    Image($r("app.media.ic_single_play"))
                      .width(20)
                      .fillColor('#ececec')
                      .margin({ right: 12 })
                  }
                  .backgroundColor('#46474c')
                  .width('100%')
                  .borderRadius(8)
                  .clip(true)
                  .onClick(()=>{
                     // 播放
                    this.AVPlayer.singlePlay(item.song)
                  })

                  Row({ space: 20 }) {
                    Row() {
                      Image($r('app.media.ic_share'))
                        .width(20)
                        .fillColor('#c9c8cd')
                      Text('分享')
                        .fontColor(this.currentColorMode.key === 1 ? Color.Black :'#aaa9af')
                        .fontSize(12)
                        .margin({ left: 4 })
                    }

                    Row() {
                      Image($r('app.media.ic_comment_o'))
                        .width(20)
                        .fillColor(this.currentColorMode.key === 1 ? Color.Gray : '#c9c8cd')
                      Text(item.comment.toString())
                        .fontColor(this.currentColorMode.key === 1 ? Color.Gray :'#aaa9af')
                        .fontSize(12)
                        .margin({ left: 4 })
                    }

                    Row() {
                      Image($r('app.media.ic_like'))
                        .width(20)
                        .fillColor(this.currentColorMode.key === 1 ? Color.Red :'#c9c8cd' )
                      Text(item.like.toString())
                        .fontColor(this.currentColorMode.key === 1 ? Color.Gray :'#aaa9af')
                        .fontSize(12)
                        .margin({ left: 4 })
                    }
                  }
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
              }
              .alignItems(VerticalAlign.Top)
              .padding({
                top: 24,
                bottom: 24
              })
              .borderWidth({
                bottom: 1
              })
              .borderColor('#292931')
            }
          })
          ListItem() {
            Row() {
              Text('我是有底线的~')
                .fontColor(Color.Gray)
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .padding(16)
          }
        }
        .width('100%')
        .height('100%')
        .padding({ right: 32, left: 16})

      }
      .layoutWeight(1)
    }
    .backgroundColor($r('app.color.app_background_color'))
    .width('100%')
    .height('100%')
  }
}

export default Moment