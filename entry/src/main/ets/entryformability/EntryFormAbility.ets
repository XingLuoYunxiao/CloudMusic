import { formBindingData, FormExtensionAbility, formInfo } from '@kit.FormKit';
import { Want } from '@kit.AbilityKit';
import { FORM_ID_KEY } from '../utils/PreferencesManager';
import { SubscriberClass } from '../utils/SubscriberClass';
import { PublishEventType } from '../constants/EventConstants';
import { MMKV } from '@tencent/mmkv';


export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want: Want) {
    let appCtx = this.context.getApplicationContext();
    let mmkvRootDir = MMKV.initialize(appCtx);
    //PreferenceManager.loadPreference(this.context, PREFERENCES_NAME)
    // Called to return a FormBindingData object.
    const formData = '';
    // 1. 获取添加的卡片ID
    let formId:string = want.parameters![formInfo.FormParam.IDENTITY_KEY] as string;
    console.log('testTag', `onAddForm formId: ${formId}`);
    // 2. 存首选项(应用挂了）
    let mmkv = MMKV.defaultMMKV();
    mmkv.encodeString(FORM_ID_KEY, formId);
    //PreferenceManager.getInstance().setValue<string>(FORM_ID_KEY , formId);
    // 3. 推送给应用（应用活着的时候）
    SubscriberClass.publish(PublishEventType.CARD_PUBLISH, formId)
    return formBindingData.createFormBindingData(formData);

  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.

  }

  onFormEvent(formId: string, message: string) {
    // message是一个字符串对象
    // Called when a specified message event defined by the form provider is triggered.
    SubscriberClass.publish(PublishEventType.CARD_PUBLISH, JSON.parse(message).type)
  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
}