import commonEventManager from '@ohos.commonEventManager';
import { PublishEventType } from '../constants/EventConstants';

export class SubscriberClass {
  static publishCount: number = 0

  static publish(eventType: PublishEventType, data: string){
    commonEventManager.publish( eventType, {data}, (err) => {
      // 多发几次，失败继续发送
      if( err){
        if( SubscriberClass.publishCount < 3){
          SubscriberClass.publish( eventType, data)
          SubscriberClass.publishCount++
        }else{
          SubscriberClass.publishCount = 1
        }
      }else {
        SubscriberClass.publishCount = 1
      }
    })
  }

  static subscribe(eventType: PublishEventType, subscriber:commonEventManager.CommonEventSubscriber, callback: (event:string) => void){
    // 1. 创建订阅者
    commonEventManager.createSubscriber({events: [eventType]}, (err, data) => {
      if( err){
        return console.error(`createSubscriber failed, err: ${JSON.stringify(err)}`);
      }
      // 2. data是订阅者
      subscriber = data
      if( subscriber){
        // 3. 订阅事件
        commonEventManager.subscribe(subscriber, (err, data) => {
          if (err) {
            return console.error(`subscribe failed, err: ${JSON.stringify(err)}`);
          }
          if( data.data !== undefined){
            callback(data.data)
          }
        })
      }
    })
  }
}