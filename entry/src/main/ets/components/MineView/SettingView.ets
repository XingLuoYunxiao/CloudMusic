import DarkModelSettingDialog from './DarkModelSettingDialog'
import { SignOutCard } from './SignOutCard'
import { promptAction } from '@kit.ArkUI'

@ComponentV2
export struct SettingView {
  build() {
    Column(){
      Row(){
        Text("设置")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Start)
      }
      .justifyContent(FlexAlign.Start)
      .padding({
        top: 20,
        left: 20,
        bottom: 20,
        right: 20
      })
      Column() {
        DarkModeSettingCard()
        SignOutCard()
      }
    }
    .margin(10)
  }
}

@ComponentV2
struct DarkModeSettingCard {
  @Local customDialogComponentId: number = -1

  @Builder
  DarkModelDialog(){
    DarkModelSettingDialog({customDialogComponentId: this.customDialogComponentId})
  }


  build() {
    Column() {
      Row() {
        Text('深色模式')
          .fontFamily("HarmonyHeiTi")
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('sys.color.ohos_id_color_text_primary'))
          .lineHeight(22)
          .layoutWeight(1)
          .padding({left:10})
        Text('主题颜色')
          .fontFamily('HarmonyHeiTi')
          .fontSize(14)
          .fontWeight(400)
          .lineHeight(18)
          .fontColor($r('sys.color.ohos_id_color_text_secondary'))
        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontColor([$r('sys.color.ohos_id_color_text_tertiary')])
          .fontSize(24)
      }
      .height(56)
      //.backgroundColor( $r('app.color.setting_selected_bg') :$r('app.color.clear_color'))
      .width('100%')
      .borderRadius(16)
      .padding({
        top: 12,
        left: 8,
        bottom: 12,
        right: 8
      })
      .margin(10)
      .onClick( ()=>{
        promptAction.openCustomDialog({
          builder: () => this.DarkModelDialog(),
          width:480,
          height:560,
        }).then((dialogId: number) => {
          this.customDialogComponentId = dialogId
        })
      })

    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .width('100%')
    .borderRadius(16)
    .margin(10)

  }
}

