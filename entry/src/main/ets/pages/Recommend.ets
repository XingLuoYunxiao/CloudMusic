import { NumberKey } from '../model/Key'
import { dailyRecommend, recommendList, songs, swiperList } from '../model/MusicConstants'
import { PersistenceV2 } from '@kit.ArkUI'
import { COLOR_MODE_KEY } from '../constants/EventConstants'
import { recommendDailyType, recommendListType } from '../model/music'
import { songItemType } from '../model/playState'
import AVPlayerClass from '../utils/AVPlayerClass'

interface GeneratedObjectLiteralInterface_1 {
  color: string;
  radius: number;
  offsetX: number;
  offsetY: number;
}

@Entry
@ComponentV2
struct Recommend {
  @Local currentColorMode: NumberKey = PersistenceV2.connect(NumberKey, COLOR_MODE_KEY, () => new NumberKey(0))!
  @Local AVPlayer: AVPlayerClass = AVPlayerClass.getInstance()

  // 定义通用样式
  readonly cardShadow: GeneratedObjectLiteralInterface_1 = {
    color: '#1A000000',
    radius: 16,
    offsetX: 0,
    offsetY: 4,
  }

  readonly commonPadding = 16
  readonly sectionSpacing = 24

  @Builder
  SearchBar() {
    Row() {
      Row({ space: 8 }) {
        Image($r('app.media.ic_search'))
          .width(24)
          .height(24)
          .fillColor('#7a828e')

        Text('搜索音乐、歌手、播放列表')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentColorMode.key === 1 ? '#565555' : '#A0A0A0')
          .layoutWeight(1)

        Image($r('app.media.ic_code'))
          .width(24)
          .height(24)
          .fillColor('#7a828e')
      }
      .height(48)
      .width('100%')
      .padding({ left: 16, right: 16 })
      .borderRadius(24)
      .backgroundColor(this.currentColorMode.key === 1 ? '#F5F5F5' : '#2D2D2D')
      .shadow(this.cardShadow)
    }
    .padding(this.commonPadding)
  }

  @Builder
  FeaturedSwiper() {
    Column() {
      Swiper() {
        ForEach(swiperList, (item: string) => {
          Image(item)
            .width('100%')
            .height(180)
            .borderRadius(16)
            .objectFit(ImageFit.Cover)
        })
      }
      .height(180)
      .autoPlay(true)
      .interval(3000)
      .indicator(true)
      .indicatorStyle({
        color: '#FFFFFF',
        selectedColor: '#FF3478'
      })
    }
    .padding(this.commonPadding)
    .margin({ top: 8, bottom: 8 })
  }

  @Builder
  SectionHeader(title: string) {
    Row() {
      Text(title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.font_color'))

      Button('查看全部')
        .height(32)
        .fontSize(14)
        .fontColor('#FF3478')
        .backgroundColor(Color.Transparent)
        .stateEffect(false)
    }
    .width('100%')
    .padding({ left: this.commonPadding, right: this.commonPadding })
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: this.sectionSpacing, bottom: 12 })
  }

  @Builder
  DailyRecommendations() {
    Column() {
      this.SectionHeader('每日推荐')

      List({ space: 12 }) {
        ForEach(dailyRecommend, (item: recommendDailyType) => {
          ListItem() {
            Column() {
              Stack({ alignContent: Alignment.TopStart }) {
                Image(item.img)
                  .borderRadius(12)
                  .width('35%')
                  .objectFit(ImageFit.Fill)

                Text(item.type)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .padding(8)
                  .margin(8)
                  .borderRadius(16)
                  .backgroundColor(item.top)
              }

              Text(item.title)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.currentColorMode.key === 1 ? '#333333' : '#E9DFDF')
                .margin({ top: 8 })
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
          }
        })
      }
      .width('100%')
      .height(220)
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .padding({ right: this.commonPadding })
    }
  }

  @Builder
  PlaylistRecommendations() {
    Column() {
      this.SectionHeader('推荐歌单')

      Grid() {
        ForEach(recommendList, (item: recommendListType) => {
          GridItem() {
            Column() {
              Stack({ alignContent: Alignment.TopStart }) {
                Image(item.img)
                  .width('100%')
                  .aspectRatio(1)
                  .borderRadius(16)
                  .objectFit(ImageFit.Cover)

                Text(item.count)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .padding(6)
                  .margin(8)
                  .borderRadius(12)
                  .backgroundColor('#80000000')
              }

              Text(item.title)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.currentColorMode.key === 1 ? '#333333' : '#E9DFDF')
                .margin({ top: 8 })
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
          }
        })
      }
      .width('100%')
      .padding(this.commonPadding)
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(16)
      .columnsGap(12)
    }
  }

  @Builder
  SongListRecommendations() {
    Grid() {
      ForEach(songs, (item: songItemType, index: number) => {
        GridItem() {
          Row() {
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
        .width('50%')

      })

    }
    .layoutDirection(GridDirection.Row)
    .rowsTemplate("1fr 1fr 1fr")
    //.width("100%")
    .scrollBar(BarState.Off)
    .height('25%')
    .padding({ left: 30, right: 30, top: 20, bottom: 20})
  }

  build() {
    Scroll() {
      Column() {
        this.SearchBar()
        //this.FeaturedSwiper()
        this.DailyRecommendations()
        this.SongListRecommendations()
        this.PlaylistRecommendations()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .backgroundColor($r('app.color.app_background_color'))
  }
}

export default Recommend