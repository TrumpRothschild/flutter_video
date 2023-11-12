/// @date 2023/02/01  10:38
/// @author bert
/// @des 所有的接口常量统一管理类

class Apis {
  /// 全局配置
  static const String publicConfig = "/api/sys/v1/getPublicConfig";

  /// 启动广告页面
  static const String getSlide = "/api/index/app/v1/getSlide";

  /// 获取接口版本信息 用于缓存
  static const String verApi = "/api/sys/v1/ver";

  /// 轮播图广告位查询，根据code
  static const String getBannerList = "/api/index/app/v1/getAdvByCode";

  /// 公告接口
  static const String getAdvNotice = "/api/advNotice/app/v1/getByType";

  /// 获取IM的token
  static const String getRtmToken = "/api/im/app/v1/getImToken";

  /// 获取视频访问地址
  static const String getVideoVisitUrl = "/upload/v1/getVideoVisitUrl";

  /// 游客注册登录
  static const String visitorLogin = "/api/login/app/v1/visitorLogin";

  ///普通会员手机注册或登录
  static const String userRegisterAndLogin =
      "/api/login/app/v1/registerAndLogin";

  /// 判断游客已绑定手机号，不能走游客登录
  static const String visitorCheck = "/api/login/app/v1/visitor/check";

  /// 获取图片验证码
  static const String sendSms = "/api/sms/v1/sendSms";

  /// 获取短信验证码
  static const String randCode = "/api/sys/v1/randCode";

  ///获取所有地区列表
  static const String queryAllCountry = "/api/sys/queryAllCountry";

  ///获取用户基本信息
  static const String getUserInfo = "/api/userCenter/app/v1/getUserInfo";

  static const String getOnlineService =
      "/api/onlineservice/app/v2/getOnlineService";

  ///普通会员找回密码接口
  static const String findPassword = "/api/login/app/v1/findPassword";

  ///游客绑定手机号
  static const String userBindPhone = "/api/login/app/v1/visitor/bindPhone";

  ///普通会员退出登录
  static const String userLogout = "/api/login/app/v1/logout";

  /// 首页tab接口
  static const String getColumn = "/api/index/app/v1/getColumn";

  /// 根据栏目code查询直播房间列表(除了推荐和关注栏目外)
  static const String getLiveByColumnCode =
      "/api/index/app/v1/getLiveByColumnCode";

  /// 首页推荐列表顶部游戏
  static const String getTopGameList =
      "/api/index/app/v1/queryIndexTopGameList";

  /// 首页推荐列+直播列表
  static const String getLiveList = "/api/index/v1/getLiveList";

  /// 关注的直播房间列表
  static const String getLiveFocusList = "/api/index/app/v1/getLiveFocusList";

  /// 关注页推荐的直播房间列表,不包含已经关注的房间
  static const String getLiveFocusRecommendList =
      "/api/index/app/v1/getLiveFocusRecommendList";

  /// 首页热门视频+星秀
  static const String getSearchVideo = "/api/index/app/v1/searchVideo";

  /// 热门视频 获取10个视频(随机)
  static const String getHotVideoList = "/api/index/app/v1/getVideoList";

  /// 定位当前国家省
  static const String getCountryProvince =
      "/api/liveStudioRegion/app/v1/countryProvince";

  /// 获取国家省信息
  static const String getCountryProvinceList =
      "/api/liveStudioRegion/app/v1/listSysCountryProvince";

  /// 获取最近浏览
  static const String getBrowseHistory = "/api/index/app/v1/browseHistory";

  /// 获取直播搜索
  static const String getLiveSearch = "/api/index/app/v1/search";

  /// 游戏data接口
  static const String getGameData = "/api/game/app/v1/list";

  /// 获取直播间用户/主播名片
  static const String getUserDetailInfo = "/api/user/app/v1/getUserDetailInfo";

  /// 直播间主播名片进度
  static const String getAnchorCard = "/api/live/app/v1/getAnchorCard";

  /// 直播间推荐直播列表
  static const String getLiveRecommendList =
      "/api/live/app/v1/getLiveRecommendList";

  /// 直播间贡献榜
  static const String getContributionList =
      "/anchor/live/app/v1/getContributionList";

  /// 平台主播排行榜
  static const String getAnchorList = "/api/ranking/app/v1/anchor";

  /// 平台土豪排行榜
  static const String getToffList = "/api/ranking/app/v1/user";

  /// 查询直播间在线观众50个 直播间top50 列表
  static const String liveStudioTop50 = "/api/room/app/v1/liveStudioTop50";

  /// 通过房间号获取直播间详情,进入房间之前请求的接口
  static const String getLiveRoomDetail = "/api/live/app/v1/getRoomDetail";

  /// 获取推流和拉流的token
  static const String getRtcToken = "/api/im/app/v1/getFlowToken";

  /// 直播礼物列表
  static const String giftList = "/api/room/app/v1/giftList";

  /// 礼物打赏接口
  static const String giftGiving = "/api/room/app/v1/giftGiving";

  /// 直播间活动信息列表
  static const String getRoomActList = "/api/live/app/v1/getRoomActList";

  ///获取用户钱包信息-接口
  static const String getUserWallet = "/api/user/app/v1/getUserWallet";

  ///兑换金币列表
  static const String getGoldOptions = "/pay/pay/app/v1/getGoldOptions";

  ///余额兑换金币
  static const String exchangeGold = "/api/silverBean/app/V1/exchangeGold";

  ///兑换钻石列表
  static const String getSilverBeanOptions =
      "/pay/pay/app/v1/getSilverBeanOptions";

  ///余额兑换钻石
  static const String exchangeSilver = "/api/silverBean/app/V1/exchangeSilver";

  ///支付方式
  static const String getPayData = "/pay/pay/app/v1/getPayData";

  ///支付方式
  static const String getPayDataV2 = "/pay/pay/app/v2/getPayData";

  ///充值
  static const String recharge = "/pay/pay/app/v1/recharge";

  ///充值
  static const String rechargeV2 = "/pay/pay/app/v2/recharge";

  ///游戏记录
  static const String getGameRecordList =
      "/api/userCenter/app/v1/getGameRecordList";

  ///充提记录
  static const String getBill = "/pay/transaction/app/v1/getBill";

  ///取消充提操作
  static const String cancelWithdraw = "/pay/pay/app/v1/cancelWithdraw";

  ///取消充提操作
  static const String withdrawResult =
      "/pay/pay/app/v1/getWithdrawDetailsByOrderNo";

  ///游戏登陆
  static const String gameLogin = "/api/game/app/v1/login";

  static const String getRecentInfo = "/api/ticket_kj/app/v1/recent_info";
  static const String getInfo = "/api/ticket_bet/app/v1/info";
  static const String getExplain = "/api/ticket_help/app/v1/info";
  static const String getLotteryList = "/api/ticket_kj/app/v1/list";
  static const String getBetList = "/api/ticket_tz/app/v1/list";
  static const String niuNiuBet = "/api/ticket_bet/app/v1/bet";
  static const String getGameTypeList = "/api/ticket/app/v1/list";
  static const String statistics = "/api/ticket_tz/app/v1/statistics";
  static const String getGameCodeList = "/api/ticket/app/v1/getGameCodeList";
  static const String getLiveGameList = "/api/ticket/app/v1/getLiveGameList";
  static const String followBetInfo = "/api/ticket_bet/app/v1/followBetInfo";

  /// 交易类型
  static const String transactionTypeList =
      "/pay/transaction/app/v1/transactionTypeList";

  /// 关注主播
  static const String focusUser = "/anchor/user/app/v1/focusUser";

  /// 取关主播
  static const String unfocusUser = "/anchor/user/app/v1/cancelUser";

  /// 视频收藏(喜欢)
  // static const String videoCollect = "/video/video/app/v1/collect";
  static const String videoCollect = "/video/video/app/v2/collect";

  /// 视频详情
  static const String videoDetail = "/video/video/app/v1/detail";

  /// 视频筛选
  static const String videoList = "/video/video/app/v1/list";

  /// 详情页视频推荐
  static const String videoRecommend = "/video/video/app/v1/recommend";

  /// 视频观看(直接返回m3u8响应流文件)
  static const String videoWatch = "/video/video/app/v1/watch";

  /// 视频观看增加记录
  static const String recordWatch = "/video/video/app/v1/recordWatch";

  /// 视频搜索
  static const String videoSearch = "/video/video/app/v1/search";

  /// 视频搜索标签
  static const String videoDynamics = "/video/videoSetting/app/v1/dynamics";

  /// 热门视频
  static const String videoHotSearch = "/video/videoTag/app/v1/hotSearch";

  /// 取消视频收藏(喜欢)
  static const String videoUnCollect = "/video/video/app/v1/unCollect";

  /// 删除观看视频
  static const String deleteVideoWatchRecord =
      "/video/videoWatchRecord/app/v1/delete";

  /// 视频分类
  static const String videoCategoryList = "/video/videoCategory/app/v1/list";

  /// 视频分类组(自定义频道)
  static const String videoCategoryListGroup =
      "/video/videoCategory/app/v1/listGroup";

  /// 意见反馈
  static const String videoFeedback = "/video/videoFeedback/app/v1";

  /// 我收藏/喜欢的视频列表
  static const String videoCollectList = "/video/videoCollect/app/v1/list";

  /// 视频标签组(视频搜索用)
  static const String videoTagGroupList = "/video/videoTagGroup/app/v1/list";

  /// 首页面板及面板内容查询
  static const String videoIndexPanel = "/video/videoIndexPanel/app/v3/list";

  /// 评论列表
  static const String videoComment = "/video/videoComment/app/v1/list";

  /// 评论
  static const String comment = "/video/videoComment/app/v1/comment";

  /// 删除评论
  static const String deleteComment = "/video/videoComment/app/v1/delete";

  /// 删除评论
  static const String videoCommentReplyDelete =
      "/video/videoCommentReply/app/v1/delete";

  /// 回复列表
  static const String videoCommentReplyList =
      "/video/videoCommentReply/app/v1/list";

  /// 回复评论
  static const String replyComment =
      "/video/videoCommentReply/app/v1/replyComment";

  /// 点赞
  static const String videoCommentLike = "/video/videoComment/app/v1/like";

  /// 点赞
  static const String videoCommentReplyLike =
      "/video/videoCommentReply/app/v1/like";

  /// 举报
  static const String videoCommentReport = "/video/videoComment/app/v1/report";

  /// 举报
  static const String videoCommentReplyReport =
      "/video/videoCommentReply/app/v1/report";

  /// 上传图片
  static const String uploadPicture = "/upload/v1/uploadPicture";

  /// 视频详情页面板查询
  static const String detailPanel = "/video/videoPanel/app/v1/detailPanel";

  /// 统计信息(观看次数、下载次数)
  static const String videoWatchRecordStatistics =
      "/video/videoWatchRecord/app/v1/statistics";

  /// 当天观看次数
  static const String videoWatchRecordTodayCount =
      "/video/videoWatchRecord/app/v1/todayCount";

  /// 我的视频观看记录
  static const String videoWatchRecord = "/video/videoWatchRecord/app/v1/list";

  /// 视频下载
  static const String download = "/video/video/app/v1/download";

  /// 视频标签组(视频搜索用)
  static const String videoTag = "/video/videoTag/app/v1/list";

  /// 视频标签组(视频搜索用)
  static const String videofilterList = "/video/videoTag/app/v1/filterList";

  /// 最新系统消息和邮件消息
  static const String getLatestNews = "/api/mem/message/app/v1/getLatestNews";
  static const String getUnReadMsgNum =
      "/api/mem/message/app/v1/getUnReadMsgNum";

  /// 标记消息已读
  static const String readMessage = "/api/mem/message/app/v1/read";

  /// 一键已读
  static const String readAllMessage = "/api/mem/message/app/v1/readAll";

  /// 一键清空
  static const String emptyMessage = "/api/mem/message/app/v1/emptyMessage";

  /// 消息列表
  static const String messageList = "/api/mem/message/app/v1/list";

  /// 获取用户是否存在密码状态信息
  static const String getUserPasswordStatus =
      "/api/userCenter/app/v1/getUserPasswordStatus";

  /// 设置/更新账户/支付密码
  static const String resetPassword = "/api/login/app/v1/resetPassword";

  /// 设置/支付密码
  static const String setPassword = "/api/userCenter/app/v1/setPayPassword";

  /// 设置/支付密码
  static const String setPayPasswordByMessage =
      "/api/userCenter/app/v1/setPayPasswordByMessage";

  static const String deleteBank = "/api/memBank/app/V1/delete";
  static const String withdraw = "/pay/pay/app/v1/withdraw";

  /// 粉丝列表
  static const String getFansList = "/api/focus/app/v1/fansList";

  /// 关注列表
  static const String getFocusList = "/api/focus/app/v1/focusList";

  /// app 版本
  static const String queryAppVersion = "/api/sys/queryAppVersion";

  /// 用户钱包列表
  static const String getUserWalletList =
      "/api/userCenter/app/v1/getUserWalletList";

  static const String bankList = "/api/memBank/app/V1/list";

  static const String getBankList = "/api/memBank/app/V1/getBankList";

  static const String addBank = "/api/memBank/app/V1/add";

  /// 用户钱包游戏列表
  static const String getUserGameWalletList = "/api/game/app/v1/queryWallet";

  /// 一键回收游戏钱包余额
  static const String oneKeyRecovery = "/api/userCenter/app/v1/oneKeyRecovery";

  /// 转入转出
  static const String userWalletChange =
      "/api/userCenter/app/v1/userWalletChange";

  /// 游戏余额
  static const String queryGameBalance = "/api/game/app/v1/queryBalance";

  /// 登录用户当前等级
  static const String getUserLevelInfo =
      "/api/userCenter/app/v1/getUserLevelInfo";

  /// 活动列表
  static const String getActivityList =
      "/api/userCenter/app/v1/getActivityList";

  /// 编辑用户昵称
  static const String updateNickName = "/api/userCenter/app/v1/updateNickName";

  /// 编辑用户签名
  static const String updateSignature =
      "/api/userCenter/app/v1/updateSignature";

  /// 编辑用户头像
  static const String updateUserAvatar =
      "/api/userCenter/app/v1/updateUserAvatar";

  /// 编辑用户信息
  /// avatar
  /// birthday
  /// hometown
  /// maritalStatus
  /// occupationCode
  /// sex
  static const String updateUserInfo = "/api/userCenter/app/v1/updateUserInfo";

  /// 职业信息
  static const String getUserOccupationList =
      "/api/userCenter/app/v1/getUserOccupationList";

  /// 转入游戏
  static const String depositToGameWallet = "/api/game/app/v1/deposit";

  /// 游戏转出
  static const String withdrawGameCoin = "/api/game/app/v1/withdraw";

  /// 分享邀请码
  static const String getShareData = "/api/userCenter/v1/getShareData";
}
