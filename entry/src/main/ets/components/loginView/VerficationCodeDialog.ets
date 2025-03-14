import { PersistenceV2, promptAction, router } from '@kit.ArkUI'
import { LOGIN_KEY } from '../../constants/EventConstants'
import { BooleanKey } from '../../model/Key'
import { LoginService } from '../../services/LoginService'

@Preview
@CustomDialog
export default struct VerificationCodeDialog {
  controller: CustomDialogController
  @State verificationCode: string = ''
  @State phoneNumber: string = ''
  isLogin: BooleanKey = PersistenceV2.connect(BooleanKey, LOGIN_KEY, () => new BooleanKey(false))!

  @State countdown: number = 60
  @State focusIndex: number = 0
  private timerInterval: number = -1



  aboutToDisappear() {
    if (this.timerInterval !== -1) {
      clearInterval(this.timerInterval);
    }
  }

  //获取验证码
  startCountdown() {
    this.countdown = 59;
    LoginService.getVerifyCode(this.phoneNumber)
    this.timerInterval = setInterval(() => {
      this.countdown--;
      if (this.countdown === 0) {
        clearInterval(this.timerInterval);
        this.countdown = 60;
      }
    }, 1000);
  }

  @Builder
  VerificationInput() {
    Row() {
      ForEach([0, 1, 2, 3, 4, 5], (_:string, index) => {
        Column() {
          Text(this.verificationCode[index] ?? '')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.ohos_id_color_text_primary'))
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.focusIndex === index ? '#F5F5F5' : Color.White)
            .border({
              width: this.focusIndex === index ? 2 : 1,
              color: this.focusIndex === index ? $r('app.color.activity_color') : Color.Gray,
              style: BorderStyle.Solid
            })
            .borderRadius(8)
            .animation({
              duration: 200,
              curve: Curve.EaseInOut
            })
        }
        .margin({ right: index === 5 ? 0 : 12 })
      })

      TextInput({ text: this.verificationCode })
        .width(0)
        .height(0)
        .maxLength(6)
        //.visibility(Visibility.Hidden)
        .type(InputType.Number)
        .onChange((value: string) => {
          if (value.length <= 6) {
            this.verificationCode = value;
            this.focusIndex = value.length;

            if (value.length === 6) {
              this.verifyCode(value);
            }
          }
        })
        .onFocus(() => {
          this.focusIndex = this.verificationCode.length;
        })
    }
    //点击弹出软键盘
    .key('key1')
    .onClick(() => {
      focusControl.requestFocus('key1');
    })
    .margin({ bottom: 32 })
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  verifyCode(code: string) {
    LoginService.goLogin(code, this.phoneNumber).then((judge) => {
      if(judge){
        this.isLogin.key = true;
        this.controller.close()
        promptAction.showToast({
          message: '登录成功',
          duration: 2000,
        });
        router.back()
      }else {
        promptAction.showToast({
          message: '验证码错误，请重试',
          duration: 2000,
        });
        this.verificationCode = '';
        this.focusIndex = 0;
      }
    })
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('验证码')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)

        Image($r('app.media.ic_close'))
          .width(24)
          .height(24)
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 24 })

      // Phone number display
      Text(`点击发送验证码到 ${this.phoneNumber}`)
        .fontSize(16)
        .fontColor($r('sys.color.ohos_id_color_text_secondary'))
        .margin({ bottom: 32 })

      // Verification code input boxes
      this.VerificationInput()

      // Get verification code button
      Button({ type: ButtonType.Capsule }) {
        Row() {
          if (this.countdown < 60) {
            LoadingProgress()
              .width(16)
              .height(16)
              .margin({ right: 8 })
              .color(Color.White)
          }
          Text(this.countdown === 60 ? '获取验证码' : `${this.countdown}s后重新获取`)
            .fontColor(Color.White)
            .fontSize(16)
        }
      }
      .enabled(this.countdown === 60)
      .width('100%')
      .height(40)
      .backgroundColor(this.countdown === 60 ? $r('app.color.activity_color') : '#ffe99e9e')
      .onClick(() => {
        this.startCountdown()
      })
    }
    .width('100%')
    .padding(24)
    .backgroundColor($r('app.color.app_background_color'))
    .borderRadius({ topLeft: 16, topRight: 16 })
  }
}