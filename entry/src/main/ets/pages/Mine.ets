import { songs } from '../model/MusicConstants'
import AVPlayerClass from '../utils/AVPlayerClass'
import { PersistenceV2, router } from '@kit.ArkUI'
import { COLOR_MODE_KEY, LOGIN_KEY } from '../constants/EventConstants'
import { LoginService } from '../services/LoginService'
import { SettingView } from '../components/MineView/SettingView'
import { BooleanKey, NumberKey } from '../model/Key'
import { PlayStateType, songItemType } from '../model/playState'
import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { PreferenceManager } from '../utils/PreferencesManager'
import { MMKV } from '@tencent/mmkv'

let mmkv = MMKV.defaultMMKV()

@Entry
@ComponentV2
struct Mine {
  columnList: number[] = [0, 1, 2, 3]
  @Require
  @Param playState: PlayStateType
  @Local isLogin: BooleanKey = PersistenceV2.connect(BooleanKey, LOGIN_KEY, () => new BooleanKey(false))!
  @Local currentColorMode: NumberKey = PersistenceV2.connect(NumberKey, COLOR_MODE_KEY, () => new NumberKey(0))!
  @Local showSettingModal: boolean = false
  @Local nickImage: ResourceStr = $r('app.media.logo')

  async aboutToAppear(): Promise<void> {
    if( mmkv.decodeString('Image_key')){
      this.nickImage = mmkv.decodeString('Image_key') as ResourceStr
    }
    /*await PreferenceManager.getInstance().getValue<ResourceStr>('Image_key').then( ( value) => {
      if( value){
        this.nickImage = value as string
      }
    })*/
  }

  build() {
    Column() {

      // 背景
      Row({ space: 10 }) {
        SongCard({ columnIndex: 0, playState: this.playState })
          .layoutWeight(1)
        SongCard({ columnIndex: 1, playState: this.playState })
          .layoutWeight(1)
        SongCard({ columnIndex: 2, playState: this.playState })
          .layoutWeight(1)
        SongCard({ columnIndex: 3, playState: this.playState })
          .layoutWeight(1)
      }
      .scale({
        x: 1.15,
        y: 1.15,
        centerX: '50%',
        centerY: '0'
      })
      .height('75%')
      .width('100%')
      .backgroundColor($r('app.color.app_background_color'))

      // 个人信息
      Column() {
        Row() {
          Image(this.isLogin.key ? this.nickImage : $r('app.media.logo'))
            .borderRadius(36)
        }
        .backgroundColor(Color.Black)
        .width(80)
        .aspectRatio(1)
        .borderRadius(80)
        .offset({ y: -40 })
        .onClick(() => {
          if (this.isLogin.key) {
            let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
            PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
            PhotoSelectOptions.maxSelectNumber = 1;
            let photoPicker = new photoAccessHelper.PhotoViewPicker();
            photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
              if (PhotoSelectResult.photoUris.length > 0) {
                this.nickImage = PhotoSelectResult.photoUris[0];
                //PreferenceManager.getInstance().setValue<ResourceStr>('Image_key', this.nickImage)
                mmkv.encodeString('Image_key', this.nickImage)
              }
              console.info('PhotoViewPicker.select成功, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult.photoUris[0]));
            }).catch((err: BusinessError) => {
              console.error(`PhotoViewPicker.select失败,err: ${err.code}, ${err.message}`);
            });
          } else {
            router.pushUrl({
              url: 'pages/LoginPage'
            })
          }
        })

        Row(){
          Image($r('app.media.ic_public_settings_white'))
            .width(24)
            .height(24)
            .margin({ right: 25 })
            .fillColor($r('app.color.font_color'))
            .onClick(() => {
              this.showSettingModal = true;
            })
            .bindSheet($$this.showSettingModal, this.settingModal(), {
              preferType: SheetType.CENTER,
              dragBar: false,
              maskColor: $r('sys.color.ohos_id_color_fourth'),
              backgroundColor: $r('sys.color.ohos_id_color_panel_bg'),
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .justifyContent(FlexAlign.End)
        .offset({y:-70})

        if (this.isLogin.key) {
          Column({ space: 12 }) {
            Row({ space: 8 }) {
              Text(this.isLogin.key ? LoginService.personName ?? $r('app.string.dearUser') : $r('app.string.login'))
                .fontColor($r('app.color.font_color'))
                .fontSize(20)
              Image($r('app.media.ic_vip'))
                .width(40)
            }
            .offset({ y: -15 })

            Row() {
              Image($r('app.media.ic_boy'))
                .width(14)
                .fillColor('#ff23496b')
                .margin({ right: 4 })
              Text('00后')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
              Text('双子座')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
              Text('北京')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
              Text('歌龄·18年')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
            }

            Row() {
              Text('1 关注')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
              Text('100万 粉丝')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
              Text('1.67亿 赞')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
            }
          }
        } else {
          Column() {
            Row() {
              Text(this.isLogin.key ? LoginService.personName ?? $r('app.string.dearUser') : $r('app.string.login'))
                .fontFamily('HarmonyHeiTi')
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.font_color'))
                .fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
                .height(24)
            }

            Row() {
              Text(this.isLogin.key ? $r('app.string.dear_user_good_morning') :
              $r('app.string.login_for_enjoy_service'))
                .fontFamily('HarmonyHeiTi')
                .fontWeight(FontWeight.Regular)
                .fontColor($r('app.color.font_color'))
                .fontSize($r('sys.float.ohos_id_text_size_body2'))
                .height(18)
            }
          }
          .onClick( () => {
            router.pushUrl({
              url: 'pages/LoginPage'
            })
          })
        }
      }
      .width('100%')
      .height('25%')
      .backgroundColor($r('app.color.app_background_color'))
    }
    .width('100%')
  }

  @Builder
  settingModal() {
    Column() {
      SettingView()
    }
    .width(480)
    .height(560)
  }
}

@ComponentV2
struct SongCard {
  @Param columnIndex: number = 0
  @Require
  @Param playState: PlayStateType
  @Local showList: songItemType[] = []
  @Local AVPlayer: AVPlayerClass = AVPlayerClass.getInstance()

  aboutToAppear() {
    this.showList = songs.map(item => {
      let song = new songItemType()
      song.img = item.img
      song.name = item.name
      song.author = item.author
      song.url = item.url
      song.id = item.id
      return song
    })
      .sort(() => Math.random() - 0.5)
  }

  build() {
    List({ space: 12 }) {
      ForEach(this.showList, (item: songItemType) => {
        ListItem() {
          Stack() {
            Image(item.img)
              .width('100%')
            // 播放中动图
            Row() {
              if(this.playState.isPlay){
                Image($r('app.media.ic_playing'))
                  .width('50%')
              }else{
                Image($r('app.media.ic_play'))
                  .width(30)
                  .height(30)
              }
            }
            .backgroundColor('#7a000000')
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .visibility(this.playState?.url === item.url && this.playState?.isPlay ? Visibility.Visible :
            Visibility.Hidden)
          }
          .width('100%')
          .aspectRatio(1)
          .borderRadius(8)
          .clip(true)
          .onClick(() => {
            // 播放
            this.playState.isPlay === true ? this.AVPlayer.pausePlay() : this.AVPlayer.singlePlay(item)
          })
        }
      })
    }
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

export default Mine