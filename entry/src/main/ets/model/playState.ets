// 传输数据的结构
import { Type } from '@kit.ArkUI';


@ObservedV2
export class songItemType {
  @Trace img: string = ''
  @Trace name: string = ''
  @Trace author: string = ''
  @Trace url: string = ''
  @Trace id: string = ''
  @Trace commentList: string[] = []

}

@ObservedV2
export class PlayStateType {
  @Trace img: string = "" // 音乐封面
  @Trace name: string = "" // 音乐名称
  @Trace author: string = "" // 作者
  @Trace url: string = "" // 当前播放连接
  @Trace playIndex: number =  0 // 当前在播放列表中的播放索引
  @Trace time: number = 0 // 播放时间
  @Trace duration: number = 0 // 音乐的播放时长
  @Trace isPlay: boolean = false // 是否正在播放
  @Trace playMode: string = "auto" // 播放模式
  @Type(songItemType)
  @Trace playList: songItemType[] = []; // 当前的播放列表
  //cacheImg?: string // 缓存图片地址

  constructor() {
    this.img = "";
    this.name = "";
    this.author = "";
    this.url = "";
    this.playIndex = 0;
    this.time = 0;
    this.duration = 0;
    this.isPlay = false;
    this.playMode = 'auto';
    this.playList = [];
  }


}

