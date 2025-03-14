import { common } from '@kit.AbilityKit';
import { setAutoColorMode, setDarkColorMode, setLightColorMode } from '../../services/ColorModeChangeFunctions';
import { PersistenceV2, promptAction } from '@kit.ArkUI';
import { COLOR_MODE_KEY, ENABLE_DARK_MODE_KEY, IS_FOLLOW_SYSTEM_SETTING_KEY } from '../../constants/EventConstants';
import { BooleanKey, NumberKey } from '../../model/Key';

@Preview
@ComponentV2
export default struct DarkModelSettingDialog {
  @Require
  @Param customDialogComponentId: number = -1
  @Local enableDarkMode: BooleanKey = PersistenceV2.connect(BooleanKey, ENABLE_DARK_MODE_KEY, () => new BooleanKey(false))!
  @Local isFollowSystemSetting:BooleanKey = PersistenceV2.connect(BooleanKey, IS_FOLLOW_SYSTEM_SETTING_KEY, () => new BooleanKey(true))!
  @Local currentColorMode: NumberKey = PersistenceV2.connect(NumberKey, COLOR_MODE_KEY, () => new NumberKey(0))!
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;


  build() {
    NavDestination() {
      Column() {
        Text($r('app.string.follow_system_settings_switch_mode'))
          .fontColor($r('app.color.sub_text_color'))
          .fontSize(14)
          .fontWeight(400)
          .lineHeight(20)
          .margin({ bottom: 16, top: 8 })
          .width('100%')
          .textAlign(TextAlign.Start)
        Row() {
          Text($r('app.string.follow_system_settings'))
            .fontColor($r('app.color.font_color'))
            .fontSize(16)
            .fontWeight(500)
            .lineHeight(22)
          Toggle({ type: ToggleType.Switch, isOn: this.isFollowSystemSetting?.key })
            .onChange((isOn: boolean) => {
              if (isOn) {
                this.isFollowSystemSetting!.key = true;
                this.enableDarkMode!.key = false;
                setAutoColorMode(this.context);
                this.currentColorMode.key = -1;
              } else {
                this.isFollowSystemSetting!.key = false;
                if (this.enableDarkMode.key) {
                  setDarkColorMode(this.context);
                  this.currentColorMode.key = 0;
                } else {  
                  setLightColorMode(this.context);
                  this.currentColorMode.key = 1;

                }
              }
            })
        }
        .width('100%')
        .height(56)
        .backgroundColor($r('app.color.item_box'))
        .margin({ bottom: 12 })
        .padding({ left: 12, right: 12 })
        .justifyContent(FlexAlign.SpaceBetween)
        .borderRadius(12)

        Row() {
          Text($r('app.string.dark_mode'))
            .fontColor($r('app.color.font_color'))
            .fontSize(16)
            .fontWeight(500)
            .lineHeight(22)
          Toggle({ type: ToggleType.Switch, isOn: this.enableDarkMode?.key })
            .onChange((isOn: boolean) => {
              this.enableDarkMode!.key = isOn;
              if (isOn) {
                this.isFollowSystemSetting!.key = false;
                setDarkColorMode(this.context);
                this.currentColorMode.key = 0;
                PersistenceV2.save(COLOR_MODE_KEY)
                console.log('updateState color2',JSON.stringify(this.currentColorMode.key))

              } else if (!this.isFollowSystemSetting.key) {
                setLightColorMode(this.context);
                this.currentColorMode.key = 1;
                PersistenceV2.save(COLOR_MODE_KEY)
                console.log('updateState color1',JSON.stringify(this.currentColorMode.key))
              }
            })
        }
        .width('100%')
        .height(56)
        .backgroundColor($r('app.color.item_box'))
        .padding({ left: 12, right: 12 })
        .justifyContent(FlexAlign.SpaceBetween)
        .borderRadius(12)
      }
      .padding({ left: 16, right: 16 })
    }
    .title(this.titleBuilder())
    .backgroundColor($r('app.color.app_background_color'))
  }
  @Builder
  titleBuilder(){
    Row(){
      Text('深色模式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .layoutWeight(1)
      Blank()
      Image($r('app.media.close'))
        .width(35)
        .height(35)
        .fillColor('#4d000000')
        .onClick(()=>{
          promptAction.closeCustomDialog(this.customDialogComponentId)
        })
    }
    .padding({top:20})
    .margin(10)
  }

}