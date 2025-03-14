import { songs, swiperList } from '../model/MusicConstants'
import { songItemType } from '../model/playState'
import AVPlayerClass from '../utils/AVPlayerClass'

@Entry
@ComponentV2
struct Find {
  @Local AVPlayer: AVPlayerClass = AVPlayerClass.getInstance()

  @Builder
  SwiperComponent() {
    Row() {
      Swiper() {
        ForEach(swiperList, (item: string) => {
          Row() {
            Image(item)
              .width('100%')
          }
          .borderRadius(8)
          .clip(true)
        })
      }
      .margin(8)
      .autoPlay(true)

    }
    .width('100%')
    .padding(12)
  }

  build() {
    Column() {
      this.SwiperComponent()

      Row() {
        Text('猜你喜欢')
          .fontColor($r('app.color.font_color'))
      }
      .padding(24)
      .width('100%')

      Row() {
        List({ space: 12 }) {
          ForEach(songs, (item: songItemType, index: number) => {
            ListItem() {
              Row({ space: 12 }) {
                Row() {
                  Image(item.img)
                    .borderRadius(8)
                    .width(60)
                }

                Column({ space: 12 }) {
                  Text(item.name)
                    .fontColor($r('app.color.font_color'))
                  Row({ space: 4 }) {
                    Text('VIP')
                      .fontSize(10)
                      .padding({
                        left: 6,
                        right: 6,
                        top: 2,
                        bottom: 2
                      })
                      .border({
                        width: 1,
                        color: '#c0a267'
                      })
                      .borderRadius(10)
                      .fontColor('#c0a267')
                    Text(item.author)
                      .fontColor('#aaa9af')
                      .fontSize(12)
                  }
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Row() {
                  Image($r('app.media.ic_more'))
                    .fillColor('#aaa9af')
                    .width(24)
                }
              }
            }.onClick(() => {
              // 播放
              this.AVPlayer.listPlay(songs, index)
            })

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
        }.width('100%').height('100%')
        .padding({
          left: 24,
          right: 24
        })
      }
      .layoutWeight(1)
    }
    .backgroundColor($r('app.color.app_background_color'))
    .width('100%')
    .height('100%')
  }
}

export default Find