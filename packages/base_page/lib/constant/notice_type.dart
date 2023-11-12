/// 公告type的说明：  1：直播间公告 2：开场公告（一个语言只有一条） 3：循环公告 4：首页公告 5：推荐栏目跑马灯公告 6：游戏列表跑马灯公告 7:兑换钻石公告 8：充值中心
///
class NoticeType {
  //直播间公告
  static const int live = 1;

  //开场公告
  static const int liveWelcome = 2;

  //循环公告
  static const int marquee = 3;

  //首页公告
  static const int homeNotice = 4;

  // 推荐栏目跑马灯公告
  static const int recommendNotice = 5;

  // 游戏列表跑马灯公告
  static const int gameNotice = 6;

  // 兑换钻石公告
  static const int goldNotice = 7;

  // 充值中心
  static const int rechargeNotice = 7;
}
