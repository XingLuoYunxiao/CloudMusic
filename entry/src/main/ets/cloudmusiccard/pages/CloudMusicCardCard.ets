const localStorage = new LocalStorage()

@Entry(localStorage)
@Component
struct CloudMusicCard{
  @State
  randomColor: string = 'rgb(0,0,0)'

  @Watch('changeAnimate')
  @LocalStorageProp('playState') playState: PlayStateType = new PlayStateType()
  @LocalStorageProp('songName') songName: string = ""
  //展示图片的地址（用图片名称展示）
  @LocalStorageProp('fileName') fileName: string = ""

  changeAnimate() {
    console.log("testTag ", this.fileName,JSON.stringify(this.playState))
    this.randomColor = 'rgb(' + Math.floor(Math.random() * 256) + ',' + Math.floor(Math.random() * 256) + ',' + Math.floor(Math.random() * 256) + ')'
  }


  build() {
    Row() {
      Stack() {
        Image('memory://' + this.fileName)
          .width('100%')
          .height('100%')
          .blur(300)

        Column() {
          Row() {
            Row() {
              Image('memory://' + this.fileName)
                .width('60%')
                .borderRadius(400)
            }
            .shadow({
              radius: 30,
              color: this.randomColor
            })
            .animation({
              duration: 1000,
              onFinish: () => {
                //暂停或强杀应用，清除闪光
                this.randomColor = 'rgb(0,0,0)'
              }
            })
            .backgroundImage($r('app.media.ic_cd'))
            .backgroundImageSize(ImageSize.Cover)
            .justifyContent(FlexAlign.Center)
            .width('90%')
            .margin(10)
            .borderRadius(400)
            .aspectRatio(1)
            .scale({
              x:1.2,
              y:1.2,
              centerX:'50%',
              centerY:'50%'
            })
            .translate({
              y:10
            })
          }
          .width('100%')
          .height('80%')
          .justifyContent(FlexAlign.Center)
          .onClick( () => {
            postCardAction(this,{
              'action' : 'router',
              'abilityName' : 'EntryAbility'
            })
          })


          Row() {
            // 上一首
            Image($r('app.media.ic_prev'))
              .fillColor(Color.White)
              .width(30)
              .onClick(() => {
                //无法导入AVPlayerClass
                //通知应用切换
                //没有办法在页面使用发布类，但是ability可以发布
                postCardAction(this, {
                  'action': 'message',
                  'params':{
                    type:'prev'
                  }
                })
              })
            Text(this.songName)
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(Color.White)

            // 下一首
            Image($r('app.media.ic_next'))
              .fillColor(Color.White)
              .width(30)
              .onClick(() => {
                postCardAction(this, {
                  'action': 'message',
                  'params':{
                    type:'next'
                  }
                })
              })
          }
          .width('100%')
          .height('20%')
          .padding({ left: 10, right: 10 })
          .justifyContent(FlexAlign.SpaceBetween)

        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ec5c87')
  }
}


// 传输数据的结构
export interface  songItemType {
  img: string
  name: string
  author: string
  url: string
  id:string
}

export class PlayStateType {
  img: string = "" // 音乐封面
  name: string = "" // 音乐名称
  author: string = "" // 作者
  url: string = "" // 当前播放连接
  playIndex: number =  0 // 当前在播放列表中的播放索引
  time: number = 0 // 播放时间
  duration: number = 0 // 音乐的播放时长
  isPlay: boolean = false // 是否正在播放
  playMode: 'auto' | 'repeat' | 'random' = "auto" // 播放模式
  playList: songItemType[] = [] // 当前的播放列表
  cacheImg?: string // 缓存图片地址
}

export const defaultPlayState: PlayStateType = {
  img: "",
  name: "",
  author: "",
  url: "",
  playIndex: 0,
  time: 0,
  duration: 0,
  isPlay: false,
  playMode: "auto",
  playList: [],
  cacheImg: ""
}

