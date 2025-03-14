import { AlertDialog, PersistenceV2 } from '@kit.ArkUI'
import { LOGIN_KEY } from '../../constants/EventConstants'
import { BooleanKey } from '../../model/Key'
import { LoginService } from '../../services/LoginService'

@ComponentV2
export struct  SignOutCard{
  @Local isLogin: BooleanKey = PersistenceV2.connect(BooleanKey, LOGIN_KEY, () => new BooleanKey(false))!
  dialogControllerConfirm: CustomDialogController = new CustomDialogController({
    builder: AlertDialog({
      primaryTitle: '确认登出吗？',
      primaryButton: {
        value: '取消',
        action: () => {
        },
      },
      secondaryButton: {
        value: '确认',
        role: ButtonRole.ERROR,
        action: () => {
          this.isLogin.key = false
          LoginService.logout()
          console.info('Callback when the second button is clicked')
        }
      },
    }),
  })

  build() {
    Column() {
      Row() {
        Text('退出登录')
          .fontFamily("HarmonyHeiTi")
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('sys.color.ohos_id_color_text_primary'))
          .lineHeight(22)
          .layoutWeight(1)
          .padding({left:10})
          .onClick(() => {
            this.dialogControllerConfirm.open()

          })

      }
      .height(56)
      .width('100%')
      .borderRadius(16)
      .padding({
        top: 12,
        left: 8,
        bottom: 12,
        right: 8
      })
      .margin(10)

    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .width('100%')
    .borderRadius(16)
    .margin(10)
  }
}