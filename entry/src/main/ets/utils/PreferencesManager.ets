import { preferences } from '@kit.ArkData';

export const PREFERENCES_NAME: string = 'CLOUD_MUSIC_PREFERENCE';
export const PLAY_KEY = 'PlayKey1';
export const FORM_ID_KEY = 'FormIdKey1';

export class PreferenceManager {
  private preferences?: preferences.Preferences;
  private static instance: PreferenceManager;


  public static getInstance(): PreferenceManager {
    if (!PreferenceManager.instance) {
      PreferenceManager.instance = new PreferenceManager();
    }
    return PreferenceManager.instance;
  }

  static async loadPreference(context: Context , name: string){
    try{
      PreferenceManager.getInstance().preferences = await preferences.getPreferences(context, name)
      console.log('testTag', `加载Preferences[${name}]成功`)
    } catch (e) {
      console.log('testTag', `加载Preferences[${name}]失败`, JSON.stringify(e))
    }
  }
  async setValue<T>(key: string, value: T): Promise<void> {
    if (this.preferences) {
      this.preferences.put(key, JSON.stringify(value)).then(() => {
        this.saveUserData();
      })
    }
  }

  async getValue<T>(key: string): Promise<T | null> {
    if (this.preferences) {
      return this.preferences.get(key, '').then((res: preferences.ValueType) => {
        let value: T | null = null;
        if (res) {
          value = JSON.parse(res as string) as T;
        }
        return value;
      });
    }else{
      return null
    }
  }

  async hasValue(key: string): Promise<boolean> {
    if (this.preferences) {
      return this.preferences.has(key);
    } else {
      return false;
    }
  }

  async deleteValue(key: string): Promise<void> {
    if (this.preferences) {
      this.preferences.delete(key).then(() => {
        this.saveUserData();
      });
    }

  }

  saveUserData() {
    this.preferences?.flush();
  }
}