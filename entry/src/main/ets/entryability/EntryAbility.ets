import { AbilityConstant, Configuration, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { PersistenceV2, window } from '@kit.ArkUI';
import { COLOR_MODE_KEY } from '../constants/EventConstants';
import auth from '@hw-agconnect/auth';
import { PreferenceManager, PREFERENCES_NAME } from '../utils/PreferencesManager';
import { buffer } from '@kit.ArkTS';
import { NumberKey } from '../model/Key';
import { MMKV } from '@tencent/mmkv';

const DOMAIN = 0x0000;

// 接受序列化失败的回调
PersistenceV2.notifyOnError((key: string, reason: string, msg: string) => {
  console.error(`error key: ${key}, reason: ${reason}, message: ${msg}`);
});


export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
    let appCtx = this.context.getApplicationContext();
    let mmkvRootDir = MMKV.initialize(appCtx);
    console.info('mmkv rootDir: ', mmkvRootDir);
    //登录注册初始化
    AppStorage.setOrCreate('context', this.context)
    let file = this.context.resourceManager.getRawFileContentSync('agconnect-services.json');
    let json: string = buffer.from(file.buffer).toString();
    auth.init(this.context, json);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
    await PreferenceManager.loadPreference(this.context, PREFERENCES_NAME )

  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage){
    // Main window is created, set main page for this ability
    const win = await windowStage.getMainWindow()
    win.setWindowLayoutFullScreen(true)
    AppStorage.setOrCreate("topHeight", px2vp(win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      .topRect.height))
    AppStorage.setOrCreate("bottomHeight", px2vp(win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
      .bottomRect.height))
    const childWin = await windowStage.createSubWindow("ad_win") // 创建广告子窗口
    await childWin.showWindow()
    await childWin.setUIContent("pages/Start")
    windowStage.loadContent("pages/Index")
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    let currentColorMode:NumberKey = PersistenceV2.connect(NumberKey, COLOR_MODE_KEY, () => new NumberKey(0))!
    if( currentColorMode.key !== newConfig.colorMode){
      currentColorMode.key = newConfig.colorMode as number
    }
  }
}