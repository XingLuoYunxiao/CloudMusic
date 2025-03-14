import { favoriteListType, momentListType, recommendDailyType, recommendListType } from './music';
import { songItemType } from './playState';
import { TabClass } from './TabClass';

// TabBar数据
export const tabsData: TabClass[] = [
  {
    title: '推荐',
    name: 'recommend',
    icon: $r("app.media.ic_recommend")
  },
  {
    title: '发现',
    name: 'find',
    icon: $r("app.media.ic_find")
  },
  {
    title: 'music',
    name: 'home',
    icon: $r("app.media.ic_logo")
  },
  {
    title: '动态',
    name: 'moment',
    icon: $r("app.media.ic_moment")
  },
  {
    title: '我的',
    name: 'mine',
    icon: $r("app.media.ic_mine")
  }]

// 轮播图数据
export const swiperList: string[] = [
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner1.png",
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner2.png",
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner3.png",
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner4.png",
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner5.png"
]


// 每日推荐数据
export const dailyRecommend: recommendDailyType[] = [
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend1.png',
    title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
    type: '每日推荐',
    top: '#660000',
    bottom: '#382e2f'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend2.png',
    title: '从 [Nothing on Me] 开启无限漫游',
    type: '私人漫游',
    top: '#382e2f',
    bottom: '#a37862'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend3.png',
    title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
    type: '华语流行',
    top: '#a37862',
    bottom: '#174847'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend4.png',
    title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
    type: '私人雷达',
    top: '#174847',
    bottom: '#174847'
  }
]

// 推荐歌单数据
export const recommendList: recommendListType[] = [
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list1.jpg',
    title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
    count: '270.9万'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list2.jpg',
    title: 'Yasuo和更多好听的 | 华语私人雷达 | 回忆8090',
    count: '476.1万'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list3.jpg',
    title: 'Trap Remix丨当欧美热单遇上毒性低音',
    count: '186.3万'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list4.jpg',
    title: '满级人类进化之路必备BGM | 根本停不下来',
    count: '186.3万'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list5.jpg',
    title: '认真去聆听这个世界的每一分每一秒 (强烈推荐)',
    count: '362.8万'
  },


]

// 配置文件，用于存储基础 URL
interface GeneratedObjectLiteralInterface_1 {
  baseImageUrl: string;
  baseAudioUrl: string;
}

const config: GeneratedObjectLiteralInterface_1 = {
  baseImageUrl: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/',
  baseAudioUrl: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/'
};


export const songs: songItemType[] = [
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.jpg',
    name: '画',
    author: '赵磊',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.mp3',
    id: '0000',
    commentList: [
      '赵磊的嗓音太温柔了，像清风拂面，唱到心坎里了。',
      '歌词写的好美，意境悠远，仿佛置身于一幅山水画中。',
      '循环播放好几天了，越听越喜欢，安静又治愈。',
      '适合在午后阳光下静静聆听，感受生活的美好。',
      '简单却动听的旋律，耐人寻味，越听越有味道。',
      '这首歌真的像它的名字一样，是一幅声音的画作。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.jpg',
    name: 'Sweet Dreams',
    author: 'TPaul Sax / Eurythmics',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.mp3',
    id: '0001',
    commentList: [
      '经典老歌，前奏一响就感觉回到了80年代，满满的回忆！',
      '合成器的运用太棒了，迷幻又抓耳，非常有特色。',
      'Annie Lennox的嗓音太有辨识度了，空灵又充满力量。',
      '节奏感很强，忍不住跟着摇摆，非常适合跳舞！',
      '百听不厌的经典，每次听都有新的感觉。',
      '这首歌的MV也很有创意，视觉和听觉的双重享受。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.jpg',
    name: '奢香夫人',
    author: '凤凰传奇',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.m4a',
    id: '0002',
    commentList: [
      '凤凰传奇的歌就是这么大气磅礴，听着就想跳广场舞！',
      '民族风的歌曲就是好听，旋律朗朗上口，节奏感十足。',
      '奢香夫人的故事很感人，这首歌唱出了她的坚韧和伟大。',
      '广场舞神曲，老少皆宜，全民都在跳！',
      '每次听到这首歌都感觉心情舒畅，充满活力。',
      '凤凰传奇的歌就是有魔力，听了就停不下来！'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.jpg',
    name: '空心',
    author: '光泽',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.mp3',
    id: '0003',
    commentList: [
      '光泽的嗓音太有磁性了，唱这种苦情歌真的绝了，听得心都碎了。',
      '歌词写得太扎心了，句句戳中痛点，唱出了失恋后的空虚和寂寞。',
      '旋律很悲伤，越听越难过，但又忍不住一直听下去。',
      '深夜听这首歌，更容易emo，但也很容易找到共鸣。',
      '光泽的唱功真的强，情感表达太到位了，听哭了。',
      '这首歌唱出了很多人的心声，引起了大家的共鸣。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.jpg',
    name: '反转地球',
    author: '潘玮柏',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.mp3',
    id: '0004',
    commentList: [
      '潘玮柏的歌就是青春的回忆，这首反转地球当年真的太火了！',
      '动感的节奏，欢快的旋律，听着就想跟着一起跳舞！',
      '潘玮柏的rap还是这么有活力，充满能量！',
      '这首歌的MV也很有意思，反转的剧情让人印象深刻。',
      '每次听到这首歌都感觉心情很好，充满正能量。',
      '潘玮柏的经典舞曲，KTV必点！'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.jpg',
    name: 'No.9',
    author: 'T-ara',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.m4a',
    id: '0005',
    commentList: [
      'T-ara的经典舞曲，性感又动感，百听不厌！',
      '皇冠团的颜值和实力都在线，这首歌的舞蹈也很有魅力。',
      '旋律洗脑，节奏感强，听了就想跟着一起跳！',
      '当年循环播放的歌，满满的回忆！',
      'T-ara的歌真的很有中毒性，听了就停不下来。',
      '这首歌的舞台表演太精彩了，值得一看再看。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.jpg',
    name: '孤独',
    author: 'G.E.M.邓紫棋',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.m4a',
    id: '0006',
    commentList: [
      '邓紫棋的唱功真的太强了，高音太震撼了，鸡皮疙瘩都起来了！',
      '歌词写得好真实，唱出了都市人的孤独感，很有共鸣。',
      '旋律很抓人，副歌部分太好听了，忍不住单曲循环。',
      '深夜听这首歌，更容易感受到孤独，但也更容易被治愈。',
      '邓紫棋的情感表达太到位了，听得心都揪起来了。',
      '这首歌唱出了很多人的心声，引起了大家的共鸣和思考。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.jpg',
    name: 'Lose Control',
    author: 'Hedley',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.m4a',
    id: '0007',
    commentList: [
      'Hedley的歌真的很有活力，这首Lose Control节奏感超强！',
      '主唱的声音太有爆发力了，摇滚范儿十足！',
      '前奏一响就感觉热血沸腾，忍不住跟着一起嗨起来！',
      '很适合在运动的时候听，充满力量！',
      'Hedley的现场也很棒，气氛燃爆！',
      '这首歌的歌词也很积极向上，激励人心。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.jpg',
    name: '倩女幽魂',
    author: '张国荣',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.m4a',
    id: '0008',
    commentList: [
      '哥哥的经典之作，永远的哥哥，永远的宁采臣！',
      '歌声温柔深情，把宁采臣和聂小倩的爱情故事唱得凄美动人。',
      '旋律优美动听，充满中国古典韵味。',
      '每次听这首歌都感觉很感动，想起了电影里的场景。',
      '哥哥的嗓音太有魅力了，听了就让人沉醉其中。',
      '这首歌是经典中的经典，无可替代。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.jpg',
    name: '北京北京',
    author: '汪峰',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.m4a',
    id: '0019',
    commentList: [
      '汪峰的歌总是这么有力量，这首北京北京唱出了漂泊在外的无奈和梦想。',
      '歌词写得太真实了，句句戳中北漂的心，引起了无数人的共鸣。',
      '旋律激昂，充满激情，听着就让人热血沸腾。',
      '汪峰的摇滚嗓音太有感染力了，唱出了北京的繁华和孤独。',
      '每次听这首歌都感觉很感慨，想起了在北京奋斗的日子。',
      '这首歌是献给所有在北京奋斗的人们的赞歌。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.jpg',
    name: '苦笑',
    author: '汪苏泷',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.mp3',
    id: '0010',
    commentList: [
      '汪苏泷的歌总是这么青春伤感，这首苦笑唱出了暗恋的酸涩和无奈。',
      '歌词写得很细腻，描绘了暗恋者的心理活动，引起了很多人的共鸣。',
      '旋律清新动听，副歌部分很抓耳，容易单曲循环。',
      '汪苏泷的嗓音很温柔，唱这种情歌很合适，听着很舒服。',
      '每次听这首歌都感觉回到了青涩的校园时光，想起了暗恋的那个人。',
      '这首歌是青春的回忆，也是很多人暗恋的写照。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.jpg',
    name: '一生所爱',
    author: '卢冠廷 / 莫文蔚',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.m4a',
    id: '0011',
    commentList: [
      '经典中的经典，无法超越的一生所爱，每次听都泪目。',
      '卢冠廷的嗓音沧桑深情，莫文蔚的女声温柔婉转，男女对唱太好听了。',
      '歌词写得太经典了，充满了遗憾和无奈，但又让人感动。',
      '旋律悲伤动人，前奏一起就让人想起了大话西游的场景。',
      '每次听这首歌都感觉很伤感，想起了紫霞仙子和至尊宝的爱情。',
      '这首歌是爱情的绝唱，也是无数人心中的痛。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.jpg',
    name: '月半小夜曲',
    author: '李克勤',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.mp3',
    id: '0012',
    commentList: [
      '李克勤的经典粤语歌，粤语歌的魅力就在于此，韵味十足。',
      '歌词写得很有意境，描绘了月夜的孤独和思念之情。',
      '旋律优美动听，李克勤的唱腔温柔细腻，听着很舒服。',
      '适合在安静的夜晚聆听，感受月光的温柔和歌曲的意境。',
      '每次听这首歌都感觉很平静，心也静下来了。',
      '粤语歌的经典之作，值得细细品味。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.jpg',
    name: 'Rolling in the Deep',
    author: 'Adele',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.m4a',
    id: '0013',
    commentList: [
      'Adele的爆发力太强了，这首歌的高音真的震撼人心！',
      '歌词写得很有力量，唱出了失恋后的坚强和反击。',
      '旋律大气磅礴，副歌部分太好听了，忍不住跟着一起唱。',
      'Adele的嗓音太有磁性了，听了就让人沉醉其中。',
      '每次听这首歌都感觉充满了力量，可以面对一切困难。',
      'Adele的代表作之一，也是欧美乐坛的经典之作。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.jpg',
    name: '海阔天空',
    author: 'Beyond',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.m4a',
    id: '0014',
    commentList: [
      'Beyond的经典之作，永远的海阔天空，永远的家驹！',
      '歌词写得太励志了，充满了希望和梦想，激励了一代又一代人。',
      '旋律激昂澎湃，前奏一起就让人热血沸腾，充满力量。',
      '家驹的嗓音太有穿透力了，唱出了自由和梦想的渴望。',
      '每次听这首歌都感觉很感动，想起了家驹，也想起了自己的梦想。',
      '这首歌是Beyond的精神象征，也是香港乐坛的永恒经典。'
    ]
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.jpg',
    name: '直到世界的尽头',
    author: 'WANDS',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a',
    id: '0015',
    commentList: [
      '爷青回！灌篮高手永远的神！',
      '前奏一响，瞬间回到热血沸腾的青春！',
      '每次听到这首歌都感觉充满了力量，永不放弃！',
      '动漫神曲，无可替代的经典！',
      'WANDS的巅峰之作，现场版更是燃爆！',
      '这首歌激励了一代人，太经典了！'
    ]
  },
]

// 喜欢列表
export const favoriteList: favoriteListType = {
  name: "我喜欢的音乐",
  nickName: "星落云霄",
  avatar: $r('app.media.startIcon'),
  songs: songs
}

// 动态列表
export const momentList: momentListType[] = [
  {
    author: 'Feast-aws',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h0.jpg',
    content: '二十几岁的你，一无所有，也拥有一切！',
    comment: 604,
    like: 23382,
    song: songs[0]
  },
  {
    author: 'CeeYet',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h1.jpg',
    content: '画一个姑娘陪着我,再画一个姑娘陪着我',
    comment: 1237,
    like: 5482,
    song: songs[1]
  },
  {
    author: 'Z_HOUSC',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h2.jpg',
    content: '这个事还得从两个职业选手说起',
    comment: 8425,
    like: 4234,
    song: songs[2]
  },
  {
    author: '逆转大师',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h3.jpg',
    content: '听奢香夫人，做上岸女人！',
    comment: 7658,
    like: 11545,
    song: songs[3]
  },
  {
    author: 'Moriaty',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h4.jpg',
    content: '别一厢情愿的付出，他如果拒绝你了就别再纠缠了，别一次次满满热情得到的都是敷衍冷淡的回复，你不该这样的，你应该酷一点，别打扰真的是最好的选择。',
    comment: 543,
    like: 2234,
    song: songs[4]
  },
  {
    author: '丶你要去哪里',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h5.jpg',
    content: '当年会一段潘帅的RAP是很拉风的事情',
    comment: 14415,
    like: 36297,
    song: songs[5]
  },
  {
    author: '一个人的某泥',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h6.jpg',
    content: '抗韩二十年，死于朴智妍',
    comment: 1237,
    like: 5482,
    song: songs[6]
  },
  {
    author: '曾经那个少年1993',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h7.jpg',
    content: '一个人去游泳，像投河；倒过来，一个人去投河，像游泳，太孤独。 ———-陈小三',
    comment: 7628,
    like: 36448,
    song: songs[7]
  },
  {
    author: '柳崽崽阿',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h8.jpg',
    content: '哎呦，B站来的跟我一起摇💃',
    comment: 1237,
    like: 5482,
    song: songs[8]
  },
  {
    author: '李富贵他哥',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h9.jpg',
    content: '我弟弟老是偷我的裙子丝袜穿，我担心他在女装的道路上越走越远，这让我这个当哥哥的很是担心啊',
    comment: 7362,
    like: 11482,
    song: songs[9]
  },
  {
    author: '一檀溪一',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h10.jpg',
    content: '想起张雪峰说过的全世界最大的社区天通苑，住了400w人，光是地铁修了三站，去赶早上第一班天通苑的地铁，那才是真正的北京，真的是哭辽',
    comment: 6496,
    like: 8526,
    song: songs[10]
  },
  {
    author: '-_Dimple_',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h11.jpg',
    content: '今天为了赶地铁在电梯上摔了一跤，手磕破了，马上起来进了地铁结果发现一着急坐反了。某一刻觉得自己长大了，摔倒了不是先难受，想哭觉得丢脸，而是想着快点赶上地铁。大概成年人的无奈就是没时间让我难过一会儿吧。',
    comment: 1237,
    like: 5482,
    song: songs[11]
  },
  {
    author: 'h奔放小青年',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h12.jpg',
    content: '关于这部电影看到过一个评论：当年大学毕业以后我和女友各奔东西，曾经一个晚上，偶然又看了这部电影，当至尊宝拥吻紫霞的时候荡气回肠的歌声也让我潸然泪下。。。。。第二天我打起行囊踏上火车往她家赶，如今十年过去，我们已经有了一个可爱的女儿。 我想，这是对一部电影最好的肯定吧',
    comment: 1237,
    like: 5482,
    song: songs[12]
  },
  {
    author: '您的坑友已上线',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h13.jpg',
    content: '李克勤说他唱了三十多年的歌，当接下面具的时候还很紧张，还很担心自己能不能被大家认出来，然后当《红日》想起来的时候，自己都被感动了。前天看张信哲在央视的开讲啦，坦言面对"过气“一次能够接受，撒贝宁说的很好，这批歌迷也许不会通过刷微博来支持，但是他在这些人的心里比微博上更重要。',
    comment: 1237,
    like: 5482,
    song: songs[13]
  },
  {
    author: '一个人的某泥',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h14.jpg',
    content: '11年初三，无意中听到这首歌，推荐给同学，他们都说一般般。当我在家外放这首歌时，我奶奶对我说：“这什么歌，这么好听。',
    comment: 1237,
    like: 5482,
    song: songs[14]
  },
  {
    author: '一个人的某泥',
    avatar: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/h15.jpg',
    content: '文不黑周树人 武不黑李小龙 音不黑黄家驹 影不黑周星驰',
    comment: 1237,
    like: 5482,
    song: songs[15]
  }
]



