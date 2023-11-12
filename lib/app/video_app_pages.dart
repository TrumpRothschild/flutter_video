import 'package:base/app_routes.dart';
import 'package:base_page/area_code/area_code_binding.dart';
import 'package:base_page/area_code/area_code_page.dart';
import 'package:base_page/gesture_pwd/gesture_pwd_page.dart';
import 'package:base_page/gesture_pwd/update_ges_pwd/update_ges_pwd_page.dart';
import 'package:base_page/login/login_binding.dart';
import 'package:base_page/login/login_page.dart';
import 'package:base_page/online_service/online_service_binding.dart';
import 'package:base_page/online_service/online_service_page.dart';
import 'package:base_page/register/register_binding.dart';
import 'package:base_page/register/register_page.dart';
import 'package:base_page/splash/splash_binding.dart';
import 'package:base_page/splash/splash_page.dart';
import 'package:flutter_uni_client/main/video_main_page.dart';
import 'package:game_page/game_home/game_home_binding.dart';
import 'package:game_page/game_home/game_home_page.dart';
import 'package:game_page/game_record/game_record_binding.dart';
import 'package:game_page/game_record/game_record_page.dart';
import 'package:game_page/game_transaction/game_transaction_binding.dart';
import 'package:game_page/game_transaction/game_transaction_page.dart';
import 'package:game_page/game_web/game_web_binding.dart';
import 'package:game_page/game_web/game_web_page.dart';
import 'package:get/get.dart';
import 'package:mine_page/activity_center/activity_center_binding.dart';
import 'package:mine_page/activity_center/activity_center_page.dart';
import 'package:mine_page/activity_center/web/activity_center_web_binding.dart';
import 'package:mine_page/activity_center/web/activity_center_web.dart';
import 'package:mine_page/bind_bank/bind_bank_page.dart';
import 'package:mine_page/customer_service/customer_service_binding.dart';
import 'package:mine_page/customer_service/customer_service_page.dart';
import 'package:mine_page/fan_group/fan_group_binding.dart';
import 'package:mine_page/fan_group/fan_group_page.dart';
import 'package:mine_page/mine_fans/mine_fans_binding.dart';
import 'package:mine_page/mine_fans/mine_fans_page.dart';
import 'package:mine_page/mine_focus/mine_focus_binding.dart';
import 'package:mine_page/mine_focus/mine_focus_page.dart';
import 'package:mine_page/mine_game_record/mine_game_record_binding.dart';
import 'package:mine_page/mine_game_record/mine_game_record_page.dart';
import 'package:mine_page/mine_home_page/edit_information/edit_information_binding.dart';
import 'package:mine_page/mine_home_page/edit_information/edit_information_page.dart';
import 'package:mine_page/mine_home_page/edit_information/nick_name/nick_name_binding.dart';
import 'package:mine_page/mine_home_page/edit_information/nick_name/nick_name_page.dart';
import 'package:mine_page/mine_home_page/edit_information/sign/sign_binding.dart';
import 'package:mine_page/mine_home_page/edit_information/sign/sign_page.dart';
import 'package:mine_page/mine_home_page/mine_home_page_binding.dart';
import 'package:mine_page/mine_home_page/mine_home_page_page.dart';
import 'package:mine_page/mine_msg/email_msg_list/email_msg_detail/email_msg_detail_page.dart';
import 'package:mine_page/mine_msg/email_msg_list/email_msg_list_page.dart';
import 'package:mine_page/mine_msg/mine_msg_page.dart';
import 'package:mine_page/mine_msg/sys_msg_list/sys_msg_list/sys_msg_list_page.dart';
import 'package:mine_page/mine_wallet/game_transfer/game_transfer_page.dart';
import 'package:mine_page/mine_wallet/mine_wallet_page.dart';
import 'package:mine_page/mine_wallet/transfer_result/transfer_result_page.dart';
import 'package:mine_page/my_grade/my_grade_binding.dart';
import 'package:mine_page/my_grade/my_grade_page.dart';
import 'package:mine_page/set_up/account_safety/account_safety_page.dart';
import 'package:mine_page/set_up/change_password/change_password_binding.dart';
import 'package:mine_page/set_up/change_password/change_password_page.dart';
import 'package:mine_page/set_up/phone_bind/phone_bind_binding.dart';
import 'package:mine_page/set_up/phone_bind/phone_bind_page.dart';
import 'package:mine_page/set_up/set_up_binding.dart';
import 'package:mine_page/set_up/set_up_page.dart';
import 'package:mine_page/sys_msg/sys_msg_binding.dart';
import 'package:mine_page/sys_msg/sys_msg_detail/sys_msg_detail_binding.dart';
import 'package:mine_page/sys_msg/sys_msg_detail/sys_msg_detail_page.dart';
import 'package:mine_page/sys_msg/sys_msg_page.dart';
import 'package:mine_page/transaction_detail/transaction_detail_binding.dart';
import 'package:mine_page/transaction_detail/transaction_detail_page.dart';
import 'package:mine_page/transaction_info/transaction_info_page.dart';
import 'package:mine_page/withdraw/withdraw_page.dart';
import 'package:mine_page/withdraw_record/withdraw_record_binding.dart';
import 'package:mine_page/withdraw_record/withdraw_record_page.dart';
import 'package:mine_page/withdraw_result/withdraw_result_page.dart';
import 'package:video_page/feedback/feedback_binding.dart';
import 'package:video_page/feedback/feedback_page.dart';
import 'package:video_page/follow/follow_binding.dart';
import 'package:video_page/follow/follow_page.dart';
import 'package:video_page/invite_friends/invite_friends_binding.dart';
import 'package:video_page/invite_friends/invite_friends_page.dart';
import 'package:video_page/member_center/member_center_binding.dart';
import 'package:video_page/member_center/member_center_page.dart';
import 'package:video_page/mine/mine_binding.dart';
import 'package:video_page/mine/mine_page.dart';
import 'package:video_page/my_like/my_like_binding.dart';
import 'package:video_page/my_like/my_like_page.dart';
import 'package:video_page/my_request/my_request_binding.dart';
import 'package:video_page/my_request/my_request_page.dart';
import 'package:video_page/offline_cache/offline_cache_binding.dart';
import 'package:video_page/offline_cache/offline_cache_page.dart';
import 'package:video_page/personalized_channel/personalized_channel_binding.dart';
import 'package:video_page/personalized_channel/personalized_channel_page.dart';
import 'package:video_page/problem_details/problem_details_binding.dart';
import 'package:video_page/problem_details/problem_details_page.dart';
import 'package:video_page/purchased_movies/purchased_movies_binding.dart';
import 'package:video_page/purchased_movies/purchased_movies_page.dart';
import 'package:video_page/recommend/recommend_binding.dart';
import 'package:video_page/recommend/recommend_page.dart';
import 'package:video_page/record/record_binding.dart';
import 'package:video_page/record/record_page.dart';
import 'package:video_page/screen/screen_binding.dart';
import 'package:video_page/screen/screen_page.dart';
import 'package:video_page/search_result/search_result_binding.dart';
import 'package:video_page/search_result/search_result_page.dart';
import 'package:video_page/search_type/search_type_binding.dart';
import 'package:video_page/search_type/search_type_page.dart';
import 'package:video_page/slicing/slicing_binding.dart';
import 'package:video_page/slicing/slicing_page.dart';
import 'package:video_page/video_detail/video_detail_binding.dart';
import 'package:video_page/video_detail/video_detail_page.dart';
import 'package:video_page/video_home/video_home_binding.dart';
import 'package:wallet_page/exchange_coins/exchange_coins_binding.dart';
import 'package:wallet_page/exchange_coins/exchange_coins_page.dart';
import 'package:wallet_page/wallet_root/wallet_root_binding.dart';
import 'package:wallet_page/wallet_root/wallet_root_page.dart';
import 'package:base_page/no_network/no_network_page.dart';
import 'package:base_page/no_network/no_network_binding.dart';

/// 视频路由管理
class VideoAppPages {
  static final routes = [
    /// 充值金币
    GetPage(
        name: AppRoutes.exchangeCoins,
        page: () => ExchangeCoinsPage(),
        binding: ExchangeCoinsBinding()),

    /// 在线客服
    GetPage(
        name: AppRoutes.onlineService,
        page: () => const OnlineServicePage(),
        binding: OnlineServiceBinding()),

    /// 充值中心
    GetPage(
        name: AppRoutes.walletRoot,
        page: () => WalletRootPage(),
        binding: WalletRootBinding()),

    /// 视频主页
    GetPage(
        name: AppRoutes.videoMain,
        page: () => const VideoMainPage(),
        bindings: [
          VideoHomeBinding(),
          GameHomeBinding(),
          WalletRootBinding(),
          MineBinding()
        ]),

    /// 启动页
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashPage(),
        binding: SplashBinding()),

    /// 游戏
    GetPage(
        name: AppRoutes.game,
        page: () => const GameHomePage(),
        binding: GameHomeBinding()),

    /// 游戏记录
    GetPage(
        name: AppRoutes.gameRecord,
        page: () => const GameRecordPage(),
        binding: GameRecordBinding()),

    GetPage(
        name: AppRoutes.gameTransaction,
        page: () => const GameTransactionPage(),
        binding: GameTransactionBinding()),

    GetPage(
        name: AppRoutes.transactionDetail,
        page: () => const TransactionDetailPage(),
        binding: TransactionDetailBinding()),
    GetPage(
        name: AppRoutes.transactionInfo,
        page: () => const TransactionInfoPage(),
        binding: TransactionInfoBinding()),

    GetPage(
        name: AppRoutes.gameWeb,
        page: () => const GameWebPage(),
        binding: GameWebBinding()),

    ///登陆
    GetPage(
        name: AppRoutes.loginPage,
        page: () => const LoginPage(),
        binding: LoginBinding()),

    ///选择区号
    GetPage(
        name: AppRoutes.areaCode,
        page: () => AreaCodePage(),
        binding: AreaCodeBinding()),

    ///注册/忘记密码/忘记支付密码
    GetPage(
        name: AppRoutes.register,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),

    ///活动中心
    GetPage(
        name: AppRoutes.activityCenter,
        page: () => ActivityCenterPage(),
        binding: ActivityCenterBinding()),

    ///活动详情
    GetPage(
        name: AppRoutes.activityCenterWeb,
        page: () => ActivityCenterWeb(),
        binding: ActivityCenterWebBinding()),

    ///客服中心
    GetPage(
        name: AppRoutes.customerService,
        page: () => CustomerServicePage(),
        binding: CustomerServiceBinding()),

    ///粉丝交流中心
    GetPage(
        name: AppRoutes.fanGroup,
        page: () => FanGroupPage(),
        binding: FanGroupBinding()),

    ///个人中心
    GetPage(
        name: AppRoutes.mineHome,
        page: () => MineHomePage(),
        binding: MineHomeBinding()),

    ///我的粉丝
    GetPage(
        name: AppRoutes.mineFans,
        page: () => MineFansPage(),
        binding: MineFansBinding()),

    ///我的关注
    GetPage(
        name: AppRoutes.mineFocus,
        page: () => MineFocusPage(),
        binding: MineFocusBinding()),

    ///我的游戏记录
    GetPage(
        name: AppRoutes.mineGameRecord,
        page: () => MineGameRecordPage(),
        binding: MineGameRecordBinding()),

    ///我的等级
    GetPage(
        name: AppRoutes.myGrade,
        page: () => MyGradePage(),
        binding: MyGradeBinding()),

    ///我的设置
    GetPage(
        name: AppRoutes.setUp,
        page: () => SetUpPage(),
        binding: SetUpBinding()),

    ///视频个人主页
    GetPage(
        name: AppRoutes.mine,
        page: () => const MinePage(),
        binding: MineBinding()),

    ///修改个人信息
    GetPage(
        name: AppRoutes.editInformation,
        page: () => EditInformationPage(),
        binding: EditInformationBinding()),

    ///修改昵称
    GetPage(
        name: AppRoutes.nickName,
        page: () => NickNamePage(),
        binding: NickNameBinding()),

    ///修改签名
    GetPage(
        name: AppRoutes.sign, page: () => SignPage(), binding: SignBinding()),

    ///修改密码
    GetPage(
        name: AppRoutes.changePassword,
        page: () => ChangePasswordPage(),
        binding: ChangePasswordBinding()),

    ///手势密码认证
    GetPage(
        name: AppRoutes.gesturePwdAuth,
        page: () => const GesturePwdPage(),
        binding: GesturePwdBinding()),

    ///手势密码修改
    GetPage(
        name: AppRoutes.gesturePwdUpdate,
        page: () => const UpdateGesPwdPage(),
        binding: UpdateGesPwdBinding()),

    ///绑定手机号
    GetPage(
        name: AppRoutes.phoneBind,
        page: () => PhoneBindPage(),
        binding: PhoneBindBinding()),

    ///安全中心
    GetPage(
        name: AppRoutes.accountSafety,
        page: () => const AccountSafetyPage(),
        binding: AccountSafetyBinding()),

    ///我的消息列表
    GetPage(
        name: AppRoutes.mineMsg,
        page: () => const MineMsgPage(),
        binding: MineMsgBinding()),

    ///我的钱包 root
    GetPage(
        name: AppRoutes.mineWallet,
        page: () => const MineWalletPage(),
        binding: MineWalletBinding()),

    GetPage(
        name: AppRoutes.withdrawRecord,
        page: () => const WithdrawRecordPage(),
        binding: WithdrawRecordBinding()),
    GetPage(
        name: AppRoutes.withdrawResult,
        page: () => const WithdrawResultPage(),
        binding: WithdrawResultBinding()),

    ///我的钱包-转入游戏
    GetPage(
        name: AppRoutes.gameTransferIn,
        page: () => const GameTransferPage(),
        binding: GameTransferInBinding()),

    ///提现
    GetPage(
        name: AppRoutes.withdraw,
        page: () => const WithdrawPage(),
        binding: WithdrawBinding()),

    GetPage(
        name: AppRoutes.bindBank,
        page: () => const BindBankPage(),
        binding: BindBankBinding()),

    ///我的钱包-游戏转出转入结果
    GetPage(
        name: AppRoutes.gameTransferResult,
        page: () => const TransferResultPage(),
        binding: TransferResultBinding()),

    ///系统消息列表
    GetPage(
        name: AppRoutes.sysMsg,
        page: () => SysMsgPage(),
        binding: SysMsgBinding()),

    ///系统消息详情
    GetPage(
        name: AppRoutes.sysMsgDetail,
        page: () => SysMsgDetailPage(),
        binding: SysMsgDetailBinding()),

    ///系统消息列表
    GetPage(
        name: AppRoutes.sysMsgList,
        page: () => const SysMsgListPage(),
        binding: SysMsgListBinding()),

    ///邮件消息列表
    GetPage(
        name: AppRoutes.emailMsgList,
        page: () => const EmailMsgListPage(),
        binding: EmailMsgListBinding()),

    ///邮件消息详情
    GetPage(
        name: AppRoutes.emailMsgDetail,
        page: () => const EmailMsgDetailPage(),
        binding: EmailMsgDetailBinding()),

    /// 今日推荐
    GetPage(
        name: AppRoutes.recommendPage,
        page: () =>  const RecommendPage(),
        binding: RecommendBinding()),

    /// 搜索类型
    GetPage(
        name: AppRoutes.searchTypePage,
        page: () => SearchTypePage(),
        binding: SearchTypeBinding()),

    /// 搜索结果
    GetPage(
        name: AppRoutes.searchResultPage,
        page: () => const SearchResultPage(),
        binding: SearchResultBinding()),

    /// 视频详情
    GetPage(
        name: AppRoutes.videoDetailPage,
        page: () => const VideoDetailPage(),
        binding: VideoDetailBinding()),

    /// 意见反馈
    GetPage(
        name: AppRoutes.feedback,
        page: () => const FeedBackPage(),
        binding: FeedBackBinding()),

    /// 关注
    GetPage(
        name: AppRoutes.follow,
        page: () => const FollowPage(),
        binding: FollowBinding()),

    /// 会员中心
    GetPage(
        name: AppRoutes.memberCenter,
        page: () => const MemberCenterPage(),
        binding: MemberCenterBinding()),

    /// 我的
    GetPage(
        name: AppRoutes.mine,
        page: () => const MinePage(),
        binding: MineBinding()),

    /// 我的喜欢
    GetPage(
        name: AppRoutes.myLike,
        page: () => const MyLikePage(),
        binding: MyLikeBinding()),

    /// 我的求片
    GetPage(
        name: AppRoutes.myRequest,
        page: () => const MyRequestPage(),
        binding: MyRequestBinding()),
  // final downloadListUtils = ref.watch(downloadListProvider);
  // final downloadList = downloadListUtils.downloadList;
    /// 离线缓存
    GetPage(
        name: AppRoutes.offlineCache,
        page: () => const OfflineCachePage(),
        binding: OfflineCacheBinding()),

    /// 个性化频道
    GetPage(
        name: AppRoutes.personalizedChannel,
        page: () => const PersonalizedChannelPage(),
        binding: PersonalizedChannelBinding()),

    /// 问题详情
    GetPage(
        name: AppRoutes.problemDetails,
        page: () => const ProblemDetailsPage(),
        binding: ProblemDetailsBinding()),

    /// 邀请好友
    GetPage(
        name: AppRoutes.inviteFriends,
        page: () => const InviteFriendsPage(),
        binding: InviteFriendsBinding()),

    /// 购买视频
    GetPage(
        name: AppRoutes.purchasedMovies,
        page: () => const PurchasedMoviesPage(),
        binding: PurchasedMoviesBinding()),

    /// 观看记录
    GetPage(
        name: AppRoutes.record,
        page: () => const RecordPage(),
        binding: RecordBinding()),

    /// 筛选
    GetPage(
        name: AppRoutes.screen,
        page: () => const ScreenPage(),
        binding: ScreenBinding()),

    /// 求片
    GetPage(
        name: AppRoutes.slicing,
        page: () => const SlicingPage(),
        binding: SlicingBinding()),

    /// 无网络
    GetPage(
        name: AppRoutes.noNetworks,
        page: () => const NoNetworkPage(),
        binding: NoNetworkBinding()),
  ];
}
