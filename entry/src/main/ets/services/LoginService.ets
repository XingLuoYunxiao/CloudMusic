import auth, { SignInResult, VerifyCodeAction } from '@hw-agconnect/auth';
import { hilog } from '@kit.PerformanceAnalysisKit';

export class LoginService {
  static personName:string= '星落云霄'
  static personPhoto:string=''
  static phoneNumber:string=''
  static personUid:string=''
  static defaultPhoto:string="https://tse3-mm.cn.bing.net/th/id/OIP-C.VMyV_ymHWH14JQ3RPoezwgHaFj?rs=1&pid=ImgDetMain"


  static async goLogin(code:string,phoneNumber:string): Promise<SignInResult>{
    const user= await auth.signIn({
      credentialInfo: {
        kind: 'phone',
        phoneNumber: phoneNumber,
        countryCode: '86',
        verifyCode: code
      }
    })
    return user;
  }

  static async Login(code:string,phoneNumber:string):Promise<boolean>{
    return new Promise(async (resolve, reject) => {
      await LoginService.goLogin(code,phoneNumber).then(async (user)=>{
        //登录成功
        LoginService.personUid=user.getUser().getUid()
        LoginService.phoneNumber = user.getUser().getPhone().slice(4)
        //第一次登录.自动根据手机号码设置.即只要注册登录过就拥有用户名
        if (user.getUser().getDisplayName() === undefined) {
          const name = LoginService.phoneNumber.slice(0, 3) + '****' + LoginService.phoneNumber.slice(7)
          user.getUser()
            .updateProfile({
              displayName: name,
              photoUrl: "https://tse3-mm.cn.bing.net/th/id/OIP-C.VMyV_ymHWH14JQ3RPoezwgHaFj?rs=1&pid=ImgDetMain"
            })
            .then(() => {
              console.log('初次修改昵称头像成功')
            })
            .catch((e: Error) => {
              hilog.error(0, '初次修改信息失败', JSON.stringify(e));
            })
          LoginService.personName = name
          LoginService.personPhoto = LoginService.defaultPhoto
          resolve(true)
        }else{
          resolve(true)
        }
      }).catch((error: Error) => {
        //登录失败
        console.log('登录失败', JSON.stringify(error))
        reject(false)
      })
    })
  }

  //申请验证码
  static async getVerifyCode(phoneNumber:string){
    auth.requestVerifyCode({
      action: VerifyCodeAction.REGISTER_LOGIN,
      lang: 'zh_CN',
      sendInterval: 60,
      verifyCodeType: {
        phoneNumber: phoneNumber,
        countryCode: "86",
        kind: "phone",
      }
    }).then(verifyCodeResult => {
      // 验证码申请成功
      console.log("验证码申请成功");

    }).catch((error: Error) => {
      // 验证码申请失败
      console.log("验证码申请失败");
    })
  }

  //登出账号
  static async logout(){
    auth.signOut().then(()=>{
      console.log("登出成功")
    }).catch((error: Error) => {
      console.log("登出失败");
    })
  }

}