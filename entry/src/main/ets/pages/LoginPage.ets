import { hilog } from '@kit.PerformanceAnalysisKit';
import VerificationCodeDialog from '../components/loginView/VerficationCodeDialog';

const logTag: string = 'OtherLoginPage';
const domainId: number = 0x0000;

@Entry
@ComponentV2
struct LoginPage {
  @Local isSelected: boolean = false;
  @Local allowClick: boolean = false;
  @Local phoneNumber: string = '';
  private backPage: string = '';
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: VerificationCodeDialog({
      phoneNumber: this.phoneNumber
    }),
    width:600,
    height:266,
    autoCancel: true,
    alignment: DialogAlignment.Center,
  })




  aboutToAppear() {
    hilog.info(domainId, logTag, 'OtherLoginPage aboutToAppear');
    hilog.info(domainId, logTag, `OtherLoginPage backPage: ${this.backPage}`);
  }


  @Builder
  Star() {
    Row() {
      Image($r('app.media.ic_collected'))
        .fillColor($r('sys.color.ohos_id_color_tertiary'))
        .width(20)
        .height(20)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width(36)
    .height(36)
    .borderRadius(20)
    .backgroundColor($r('sys.color.ohos_fa_list_card_bg'))
  }

  build() {
    Scroll() {
      Column() {
        // Back button.
        Row() {
          Button({ type: ButtonType.Normal }) {
            Image($r('app.media.hwid_next_ic_appback'))
              .backgroundColor(Color.Transparent)
              .borderRadius(20)
              .width(40)
              .height(40)
              .draggable(false)
              .autoResize(false)
              .focusable(true)
              .fillColor($r('sys.color.ohos_id_color_titlebar_icon'))
              .matchTextDirection(true)
          }
          .alignSelf(ItemAlign.Start)
          .backgroundColor($r('sys.color.ohos_id_color_button_normal'))
          .borderRadius(20)
          .width(40)
          .height(40)
          .id('otherLoginAppBackButton')
          .onClick(() => {

          })
        }
        .height(56)
        .padding({ top: 8, bottom: 8 })
        .width('100%')
        .margin({
          top:  36,
          left:  0,
        })
        .zIndex(2024);

        Flex({ direction:  FlexDirection.Column, alignItems: ItemAlign.Center }) {
          Column() {
            // App icon.
            Row() {
              Image($r('app.media.logo'))
                .width(96)
                .height(96)
                .draggable(false)
                .copyOption(CopyOptions.None)
                .borderRadius(20)
                .onComplete(() => {
                  hilog.info(domainId, logTag, 'Succeeded in loading appIcon.');
                })
                .onError(() => {
                  hilog.error(domainId, logTag, 'Failed to load appIcon.');
                })
            }
            .height('100%');

            // 手机号输入框.
            Row() {
              Column() {
                Stack({ alignContent: Alignment.End }) {
                  // Mobile number input box.
                  TextInput({
                    placeholder: $r('app.string.phone'),
                  })
                    .id('inp_hwid_bind_phone')
                    .type(InputType.PhoneNumber)
                    .enterKeyType(EnterKeyType.Next)
                    .enableKeyboardOnFocus(true)
                    .defaultFocus(true)
                    .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
                    .placeholderColor($r('sys.color.ohos_id_color_text_hint'))
                    .placeholderFont({ size: $r('sys.float.ohos_id_text_size_body1') })
                    .fontSize($r('sys.float.ohos_id_text_size_body1'))
                    .maxLength(24)
                    .constraintSize({ minHeight: 56 })
                    .padding({
                      left: 82
                    }
                    )
                    .borderRadius($r('sys.float.ohos_id_corner_radius_notification'))
                    .borderColor($r('sys.color.ohos_id_color_warning'))
                    .inputFilter('^[0-9*]{0,11}$')
                    .onChange((value: string) => {
                      this.phoneNumber = value;
                      this.allowClick = (this.phoneNumber.length === 11 ? true : false);
                    })

                  // Prefix.
                  Row() {
                    Text('+' + 86)
                      .fontColor($r('sys.color.ohos_id_color_text_primary'))
                      .fontSize($r('sys.float.ohos_id_text_size_body1'))
                      .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
                      .margin({
                        left: 12,
                        right: $r('sys.float.ohos_id_elements_margin_horizontal_m')
                      })
                      .id('text_hwid_bind_phone_area_code')
                      .direction(Direction.Ltr)
                    // Drop-down arrow.
                    Image($r('app.media.hwid_ic_public_spinner'))
                      .width(12)
                      .margin({
                        right: 12
                      })
                    // Divider.
                    Divider()
                      .vertical(true)
                      .height(22)
                      .color($r('sys.color.ohos_id_color_list_separator'))
                  }.width('100%')
                  .enabled(false)
                  .constraintSize({
                    minHeight: 56
                  })

                }.width('100%')
              }.width('100%')
            }
            .id('row_hwid_bind_phone')
            .padding({
              top: 8,
              bottom: 8
            })
            .width('100%')
            .height(72)
            .constraintSize({
              maxWidth: 448
            })
            .margin({
              top:  -36
            })
          }
          .width('100%')
          .height('40%')
          .justifyContent( FlexAlign.SpaceBetween)

          Column() {
            Column() {
              // 下一步.
              Column() {
                Button({ type: ButtonType.Capsule, stateEffect: true }) {
                  Text($r('app.string.next_step'))
                    .fontColor(Color.White)
                    .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
                    .fontWeight(FontWeight.Medium)
                    .fontSize(16)
                    .focusable(true)
                    .focusOnTouch(true)
                    .id('loginPanel_huawei_id_login_btn_text')
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .padding({ left: 4, right: 4 })
                    .textAlign(TextAlign.Center)
                }
                .enabled(this.allowClick)
                .focusable(true)
                .focusOnTouch(true)
                .backgroundColor($r('app.color.activity_color'))
                .constraintSize({ minHeight: 40 })
                .width('100%')
                .id('prepareLoginPageButton')
                .onClick(() => {
                  //验证码输入窗
                  this.dialogController?.open()
                })
              }
              .height(40)
              .width('100%')
              .constraintSize({ maxWidth: 448 })

              // 密码登录
              Column() {
                LoginButton($r('app.string.pwd_login'), $r('sys.color.ohos_id_color_button_normal'),
                  $r('sys.color.ohos_id_color_text_primary'))
              }.margin({ top: 16 });

              Text($r('app.string.other_login_models'))
                .fontSize($r('sys.float.ohos_id_text_size_body3'))
                .fontColor($r('sys.color.ohos_id_color_text_tertiary'))
                .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
                .fontWeight(FontWeight.Regular)
                .textAlign(TextAlign.Center)
                .constraintSize({ maxWidth: '100%' })
                .textAlign(TextAlign.Center)
                .margin({
                  top: 24,
                  bottom: 12
                })

              Row() {
                this.Star()
                this.Star()
                this.Star()
                this.Star()
                this.Star()
              }.alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.SpaceBetween)
              .width(324)
              .padding({
                left: 16,
                right: 16
              })
            }
            .margin({
              top: 68,
            })

          }
          .height('60%')
          .width('100%')
          .margin({
            left: 0,
          })
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .height('100%')
        .margin({ top:  -92 });
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .constraintSize({ minHeight: '100%' })
      .padding({
        left: 16,
        right: 16
      })
    }
    .backgroundColor($r('app.color.app_background_color'))
    .width('100%')
    .height('100%')
  }

}

@Builder
function LoginButton(text: Resource, bgColor: ResourceColor, fontsColor: ResourceColor, allowClick?: boolean) {
  Button({ type: ButtonType.Capsule, stateEffect: true }) {
    Text(text)
      .fontColor(fontsColor)
      .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
      .fontWeight(FontWeight.Medium)
      .fontSize(16)
      .focusable(true)
      .focusOnTouch(true)
      .id('loginPanel_huawei_id_login_btn_text')
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .textAlign(TextAlign.Center)
      .maxLines(1)
      .padding({ left: 4, right: 4 })
  }
  .enabled(allowClick ?? true)
  .focusable(true)
  .focusOnTouch(true)
  .backgroundColor(bgColor)
  .constraintSize({ minHeight: 40, maxWidth: 448 })
  .width('100%')
}
