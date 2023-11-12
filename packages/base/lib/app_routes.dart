/// 路由常量统一管理
abstract class AppRoutes {
  /// 启动页/广告页
  static const splash = '/';

  ///兑换金币/钻石
  static const exchangeCoins = '/ExchangeCoins';

  ///在线客服
  static const onlineService = '/onlineService';

  /// 主页
  static const mainPage = '/main_page';

  /// 首页
  static const home = '/home';

  /// 首页搜索
  static const homeSearch = '/search';

  /// 视频主页
  static const videoMain = '/video';

  /// 游戏
  static const game = '/game';
  static const gameRecord = '/gameRecord';
  static const gameTransaction = '/gameTransaction';
  static const gameWeb = '/gameWeb';

  static const transactionDetail = '/transactionDetail';
  static const transactionInfo = '/transactionInfo';

  static const notFound = "/not";

  static const loginPage = '/loginPage'; // 登陆页
  /// 更多视频页面
  static const recommendPage = '/recommendPage';

  /// 今日推荐
  static const searchTypePage = '/searchTypePage';

  /// 搜索类型
  static const searchResultPage = '/searchResultPage';

  /// 视频详情
  static const videoDetailPage = '/videoDetailPage';

  /// 视频详情
  static const feedback = '/feedback';

  /// 意见反馈
  static const follow = '/follow';

  /// 关注
  static const memberCenter = '/memberCenter';

  /// 会员中心
  static const mine = '/mine';

  /// 我的
  static const myLike = '/myLike';

  /// 我的喜欢
  static const myRequest = '/myRequest';

  /// 我的求片
  static const offlineCache = '/offlineCache';

  /// 离线缓存
  static const personalizedChannel = '/personalizedChannel';

  /// 个性化频道
  static const problemDetails = '/problemDetails';

  /// 问题详情
  static const purchasedMovies = '/purchasedMovies';

  /// 邀请好友
  static const inviteFriends = '/inviteFriends';

  /// 无网络
  static const noNetworks = '/noNetworks';

  /// 购买视频
  static const record = '/record';

  /// 观看记录
  static const screen = '/screen';

  /// 筛选
  static const slicing = '/slicing';

  /// 求片
  static const areaCode = '/areaCode'; // 选择区号
  static const register = '/register'; // 注册
  /// 修改密码
  static const changePassword = '/changePassword'; // 修改密码

  static const gesturePwdAuth = '/gesturePwdAuth'; // 手势密码
  static const gesturePwdUpdate = '/gesturePwdUpdate'; // 修改手势密码

  static const sysMsgDetail = '/sysMsgDetail'; // 系统消息详情
  static const sysMsg = '/sysMsg'; //系统消息
  static const mineMsg = '/mineMsg'; //我的消息
  static const mineWallet = '/mineWallet'; //我的钱包
  static const withdraw = '/withdraw'; //提现
  static const bindBank = '/bindBank'; //提现
  static const gameTransferIn = '/gameTransferIn'; //我的钱包-转入游戏
  static const gameTransferResult = '/gameTransferResult'; //我的钱包-游戏转出转入结果
  static const emailMsgList = '/emailMsgList'; // 邮件消息列表
  static const emailMsgDetail = '/emailMsgDetail'; // 邮件消息列表
  static const sysMsgList = '/sysMsgList'; // 系统消息列表
  static const accountSafety = '/accountSafety'; // 账号安全中心
  static const phoneBind = '/phoneBind'; // 绑定手机号
  static const withdrawRecord = '/withdrawRecord'; // 绑定手机号
  static const withdrawResult = '/withdrawResult'; // 绑定手机号
  static const sign = '/sign'; // 签名
  static const nickName = '/nickName'; // 昵称
  static const editInformation = '/editInformation'; // 修改个人信息
  static const mineHome = '/mineHome'; // 个人主页
  static const setUp = '/setUp'; // 设置
  static const myGrade = '/myGrade'; // 我的等级
  static const mineGameRecord = '/mineGameRecord'; // 我的游戏记录
  static const mineFocus = '/mineFocus'; // 我的关注
  static const mineFans = '/mineFans'; // 我的粉丝
  static const fanGroup = '/fanGroup'; // 粉丝交流群
  static const customerService = '/customerService'; // 客服中心
  static const activityCenter = '/activityCenter'; // 活动中心
  static const activityCenterWeb = '/activityCenter/web'; // 活动web页面

  static const live = '/live'; // 直播
  static const rankingTab = '/rankingTab'; // 排行榜
  static const liveShare = '/liveShare'; // 分享
  static const liveEnd = '/liveEnd'; // 直播已结束

  static const walletRoot = '/walletRoot'; // 充值

  /// 下面试测试专用
  static const homeTest = '/home_test'; // 首页
  static const discoverPage = '/discover';
  static const refreshListPage = '/refreshListPage';
  static const draggableDemoPage = '/draggableDemoPage';

  //  测试视频播放
  static const videoTestPage = "/videoTestPage";
}
