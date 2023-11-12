class ImConstant {
  /// ==========消息chatType==========
  //单聊
  static const int chatTypeOnly = 1;

  //群聊
  static const int chatTypeMore = 2;

  //系统消息
  static const int chatTypeSystem = 3;

  //@功能
  static const int chatTypeTips = 4;

  //心跳
  static const int chatTypeHeartbeat = 5;

  /// ==========消息operatorType==========
  //入场公告
  static const int operatorInNotice = -1;

  //聊天
  static const int operatorChat = 0;

  //进入房间
  static const int operatorInRoom = 1;

  //踢人
  static const int operatorKick = 2;

  //禁言
  static const int operatorEstoppel = 3;

  //关注
  static const int operatorFollow = 4;

  //取消关注
  static const int operatorCancelFollow = 5;

  //送礼
  static const int operatorGift = 6;

  //弹幕
  static const int operatorDanmu = 7;

  //下播
  static const int operatorDown = 8;

  //设为管理
  static const int operatorManager = 9;

  //取消管理
  static const int operatorCancelManager = 10;

  //礼物连击结束
  static const int operatorGiftComboEnd = 11;

  //送礼自己显示
  static const int operatorGiftMe = 12;

  //彩票上次开奖
  static const int operatorTicketLastResult = 18;

  //彩票下注
  static const int operatorLotteryBet = 20;

  //彩票中奖
  static const int operatorLotteryWin = 21;

  //  中奖公告 - 飘窗
  static const int operatorWinNotice = 22;

  //直播间用户列表
  static const int operatorUserList = 23;

  //热度
  static const int operatorHot = 24;

  //开奖推送
  static const int operatorLotteryPush = 25;

  //最新用户等级
  static const int operatorLatestGrade = 26;

  //直播切换收费免费
  static const int operatorSwitchPay = 28;

  //后端管理系统推送消息
  static const int operatorServerNotice = 99;
}
