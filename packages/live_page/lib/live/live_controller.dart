part of 'live_page.dart';

class LiveController extends GetXBaseController {
  static LiveController get of => Get.find();

  late final TextEditingController editingController;
  late final ScrollController msgScrollController;

  /// 消息组件
  final RxList<String> msgCommon = <String>[].obs;

  /// 消息 key消息类型，value消息内容
  final RxMap<num, dynamic> message = <num, dynamic>{}.obs;

  /// 进入直播间消息
  final RxList<ImEnterRoomBean> msgEnterRoom = <ImEnterRoomBean>[].obs;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// 当前房间号
  String studioNum = "";

  /// 聊天消息
  final RxString imMessage = "".obs;

  /// 彩票消息
  final RxString ticketMessage = "".obs;

  /// 下注跟投消息
  final RxString betFollowMessage = "".obs;

  final Lock _lock = Lock();
  Timer? _timer;

  ///直播游戏倒计时
  final RxString ticketCountDown = "".obs;

  /// 直播详情
  Rx<LiveRoomDetail?> roomDetailData = LiveRoomDetail().obs;

  /// 直播间推荐列表
  RxList<HomeLiveBean> liveRecommendData = <HomeLiveBean>[].obs;

  /// 在线用户初始数据
  RxList<LiveOnlineListBean> onlineUserData = <LiveOnlineListBean>[].obs;

  /// 在线用户数
  RxNum onlineNum = RxNum(0);

  /// 关注主播状态
  final isFocusAnchor = false.obs;

  /// 主播uid
  RxInt remoteUid = 0.obs;

  String get gameName =>
      TicketUtils.getTicketNameById(roomDetailData.value?.gameId);

  /// 收费直播间计时器
  Timer? chargeTimer;

  /// 收费直播标识，是否试看/计费结束
  final isChargeEnd = false.obs;

  /// 收费直播已观看时长,单位秒
  int chargeLookTime = 0;

  ///  收费观看文本
  var chargeLookTxt = "".obs;

  /// 关注/取消关注用户
  Future<void> toggleFocus(
      {required bool focus, required num? uid, bool isAnchor = false}) async {
    if (focus) {
      // 取消关注
      LiveProvider.unfocusUser(focusUserId: uid ?? 0).then((value) {
        isFocusAnchor.value = false;
      });
    } else {
      //关注
      LiveProvider.focusUser(
        focusUserId: uid ?? 0,
      ).then((value) {
        isFocusAnchor.value = true;
      });
    }
  }

  /// 打开主播名片
  void _openAnchorCardDialog(
      LiveAnchorBean? anchorVo, AnchorCardBean anchorCardBean) {
    Get.dialog(
      AnchorCardDialogPage(anchorVo: anchorVo, anchorCardBean: anchorCardBean),
      barrierColor: Colors.transparent,
    );
  }

  /// 打开抽屉
  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  /// 打开用户信息弹框
  void _openUserInfoSheet(LiveUserDetailBean bean, bool isAnchor) {
    Get.bottomSheet(
      LiveUserInfo(bean, isAnchor: isAnchor),
      barrierColor: Colors.transparent,
    );
  }

  /// 打开举报弹框
  void _openLiveReportSheet(List<String> reason) {
    Get.bottomSheet(
      LiveReport(reason),
      barrierColor: Colors.transparent,
    );
  }

  /// 在线用户列表
  void _openTop50UserSheet(LiveTop50UserBean? bean) {
    Get.bottomSheet(
      OnlineUserList(bean),
      barrierColor: Colors.transparent,
    );
  }

  /// 打开收费弹框
  void openChargeDialog(String chargeType) {
    if (Get.isDialogOpen == true) {
      return;
    }
    Get.dialog(LiveChargeDialog(chargeType), barrierDismissible: false);
  }

  /// 活动中心弹框
  void _openLiveActionCenter(LiveActionListBean? bean) {
    Get.bottomSheet(
      LiveActionCenter(bean),
      barrierColor: Colors.transparent,
    );
  }

  void openShare() {
    Get.toNamed(AppRoutes.liveShare);
  }

  void showGifts() {
    Get.bottomSheet(
      const GiftListPage(),
      barrierColor: Colors.transparent,
    );
  }

  void exitRoom() {
    Get.dialog(
      const ExitRoomDialogPage(),
      barrierColor: Colors.transparent,
    );
  }

  void sendMsg() {
    final msg = editingController.text.trim();
    if (msg.isEmpty) return;
    //_messages.add(msg);
    editingController.clear();
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      msgScrollController.animateTo(
        msgScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }

  @override
  void onInit() async {
    editingController = TextEditingController();
    msgScrollController = ScrollController();
    // 房间号
    initData(Get.arguments);
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    editingController.dispose();
    msgScrollController.dispose();

    ///关闭收费直播计时器
    chargeTimer?.cancel();

    /// 离开im频道
    RTMUtils.leaveChannel(studioNum);

    /// 释放IM资源
    RTMUtils.releaseChannel(studioNum);

    /// 释放RTC资源
    RTCUtils.release();
    super.onClose();
  }

  /// 初始化数据
  void initData(String studioNum) {
    this.studioNum = studioNum;
    chargeLookTime = 0;

    ///关闭收费直播计时器
    chargeTimer?.cancel();
    getLiveRoomDetail(studioNum);
    getLiveRecommendList(studioNum);
  }

  List<GameTabModel?> gameTabs = [];

  void showGames() async {
    if (gameTabs.isEmpty) {
      OLEasyLoading.showLoading('');
      gameTabs = await LiveProvider.getGameCodeList().whenComplete(
        () => OLEasyLoading.dismiss(),
      );
    }
    Get.bottomSheet(
      LiveGameCenterPage(
        gameTabs: gameTabs,
      ),
      barrierColor: Colors.transparent,
    );
  }

  /// 通过房间号获取直播间详情,进入房间之前请求的接口
  getLiveRoomDetail(String studioNum) async {
    Map<String, dynamic> params = {"studioNum": studioNum};
    LiveProvider.getLiveRoomDetail(params).then((value) {
      roomDetailData.value = value;
      isFocusAnchor.value = value?.liveAnchorVO?.isFocus == true;
      if (value?.studioStatus == 0) {
        // 未开播
        Log.d("未开播【studioNum=$studioNum】");
        return;
      }
      // 收费直播间，并且试看结束
      isChargeEnd.value =
          value?.isCharge == true && (value?.isProductUsable ?? 0) == 0;

      if (isChargeEnd.value) {
        openChargeDialog(
            "${value?.productPrice ?? 0} ${getChargeTypeTxt(value?.chargeType ?? 0)}");
        return;
      }

      // 在线用户列表
      var tmpOnLineUsers = value?.onlineList ?? [];
      if (tmpOnLineUsers.isNotEmpty) {
        //倒叙排序
        tmpOnLineUsers.sort((a, b) {
          return (b.silver ?? 0).compareTo(a.silver ?? 0);
        });
        if (tmpOnLineUsers.length < 5) {
          onlineUserData.value = tmpOnLineUsers;
        } else {
          onlineUserData.value = tmpOnLineUsers.sublist(0, 5);
        }
      }
      // 在线用户数量
      onlineNum.value = value?.onlineNum ?? 0;

      if (value?.studioType == 1) {
        // 真直播，获取token
        _getRtcToken(studioNum);
      } else if (value?.studioType == 2) {
        // 伪直播
      } else {
        // 无人直播
      }

      /// 加入IM频道
      RTMUtils.joinChannel(
          channelId: studioNum,
          callback: (text) => {
                // Log.d("收到IM消息【$text】"),
                // 解密消息
                EncryptUtil.of().aesDecrypt(text).then((value) {
                  imMessage.value = value;
                  Log.d("IM解密后的消息【$value】");
                  ImMessageBody? msgBody = ImMsgUtils.of().convertToBody(text);
                  if (null == msgBody) {
                    Log.e("IM消息body为空");
                    return;
                  }
                  ImMsgUtils.of().handleImBody(msgBody);
                })
              });

      /// 加入彩票频道
      var lotteryId = value?.lotteryId ?? 0;
      if (lotteryId > 0) {
        var lotteryChannelId = "t_$lotteryId";
        RTMUtils.joinChannel(
            channelId: lotteryChannelId,
            callback: (text) {
              Log.d("收到彩票$lotteryChannelId消息【$text】");
              ImMessageBody? msgBody = ImMsgUtils.of().convertToBody(text);
              if (null == msgBody) {
                Log.e("彩票消息body为空");
                return;
              }
              final String content = msgBody.content ?? '';
              switch (msgBody.operatorType) {
                case ImConstant.operatorTicketLastResult:
                  ticketMessage.value = content;
                  GameTicketModel? model =
                      ImMsgUtils.of().convertTicket(ticketMessage.value);
                  startCountdown(model?.sec ?? 0);
                  try {
                    LiveGameController.to.updateInfo(ticketMessage.value);
                  } catch (e) {
                    Log.d(e.toString());
                  }
                  break;
                case ImConstant.operatorLotteryBet:
                  betFollowMessage.value = content;
                  break;
              }
            });
      }
    });
  }

  /// 获取推流和拉流的token
  _getRtcToken(String channelName) {
    Map<String, dynamic> params = {"channelName": channelName};
    LiveProvider.getRtcToken(params).then((value) {
      // 加入直播频道
      RTCUtils.joinChannel(
          token: value?.token ?? "",
          channelId: channelName,
          uid: UserManagerCache.shared.info?.id ?? 0,
          encryptionKey: value?.agoraKey ?? "",
          encryptionSalt: value?.agoraSalt ?? "",
          joinedCallback: (rUid) => remoteUid.value = rUid,
          offlineCallback: () => remoteUid.value = 0);
    });
  }

  /// 获取直播间用户/主播名片
  /// flag 用户或主播, 默认1 表示观众 2 表示主播, 如果是主播就应该同时传递直播间号: studioNum
  getUserDetailInfo(userId, {int flag = 2, String studioNum = ""}) async {
    Map<String, dynamic> params = {"brief": 1, "flag": flag, "userId": userId};
    if (flag == 2) {
      params["studioNum"] = studioNum;
    }
    OLEasyLoading.showLoading('');
    LiveProvider.getUserDetailInfo(params).then((value) {
      if (null != value) {
        var isAnchor = flag == 2;
        if (isAnchor) {
          isFocusAnchor.value = value.isFocus == true;
        }
        // 弹出用户信息弹框
        _openUserInfoSheet(value, isAnchor);
      } else {
        OLEasyLoading.showToast("用户信息为空！");
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  /// 查询直播间在线观众50个 直播间top50 列表
  getTop50UserList() {
    OLEasyLoading.showLoading('');
    LiveProvider.liveStudioTop50(studioNum: studioNum).then((value) {
      if (null != value) {
        // 弹出用户列表弹框
        _openTop50UserSheet(value);
      } else {
        OLEasyLoading.showToast("用户列表为空！");
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  /// 获取直播间推荐直播
  void getLiveRecommendList(String studioNum) {
    LiveProvider.getLiveRecommendList(
      studioNum: studioNum,
      pageNum: 1,
      pageSize: AppConstant.pageSize,
    ).then((value) {
      if (value.isNotEmpty) {
        liveRecommendData.value = value;
      }
    });
  }

  ///获取收费类型文本
  String getChargeTypeTxt(num chargeType) {
    return chargeType == 6 ? "钻/分钟" : "钻/场";
  }

  /// 处理试看倒计时
  void handleTrySeeTime(
      {required num time, bool trySee = false, required String chargeTypeTxt}) {
    var countDownTime = time;
    if (countDownTime <= 0) {
      isChargeEnd.value = true;
      openChargeDialog(chargeTypeTxt);
      return;
    }

    chargeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDownTime <= 0) {
        isChargeEnd.value = true;
        chargeTimer?.cancel();
        openChargeDialog(chargeTypeTxt);
        return;
      }
      countDownTime = countDownTime - 1;
      if (trySee) {
        chargeLookTxt.value = "预览倒计时${countDownTime}s秒";
      } else {
        ++chargeLookTime;
        chargeLookTxt.value = "已观看${_getLookMinute(chargeLookTime)}分钟";
      }
    });
  }

  /// 观看时长秒转分钟
  String _getLookMinute(num seconds) {
    num minute = 0;
    String result = "00";
    minute = seconds / 60;
    if (minute < 10) {
      result = "0$minute";
    } else {
      result = minute.toString();
    }
    return result;
  }

  /// 进入下一个直播间
  void toNextLive(String studioNum) {
    OLEasyLoading.showToast("进入下一个直播间");
  }

  ///获取直播间主播名片
  void getAnchorCard(LiveAnchorBean? anchorVo) async {
    OLEasyLoading.showLoading('');
    LiveProvider.getAnchorCard((anchorVo?.userId ?? 0).toInt()).then((value) {
      if (value != null) {
        _openAnchorCardDialog(anchorVo, value);
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  ///获取直播间举报原因
  void getLiveReportReason() async {
    OLEasyLoading.showLoading('');
    LiveProvider.getLiveReportReason().then((value) {
      if (value != null) {
        _openLiveReportSheet(value);
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }


  ///直播间活动信息列表
  void getRoomActList() async {
    OLEasyLoading.showLoading('');
    LiveProvider.getRoomActList().then((value) {
      if (value != null) {
        _openLiveActionCenter(value);
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  getVideoVisitUrl(String fileId) {
    CommonProvider.getVideoVisitUrl(fileId).then((value) {});
  }

  ///处理伪直播播放数据，计算直播开始位置
  getLiveStartPosition(
      num sysTime, num startTime, LiveVideoListBean? videoBean) {
    // 服务端时间-视频开始时间
    var tmpTime = sysTime - startTime;
    var total = videoBean?.duration ?? 0;
    var l = tmpTime % total;
    // 当前播放位置
    if (l > total) {
      return 0;
    }
    return l * 1000;
  }

  toGameBetBottom(num? ticketId) {
    if (ticketId == null) return;
    Get.bottomSheet(
      LiveGamePage(
        gameName: TicketUtils.getTicketNameById(ticketId),
        ticketId: ticketId.toInt(),
      ),
    );
  }

  void startCountdown(int countdownDuration) async {
    await _lock.synchronized(() async {
      int remainingSeconds = countdownDuration;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        await _lock.synchronized(() async {
          remainingSeconds--;
          if (remainingSeconds == 0) {
            _timer?.cancel();
          }
          ticketCountDown.value =
              TicketUtils.getCountDownTime(remainingSeconds);
        });
      });
    });
  }

  void onFollowed(String? followId) {
    if (followId?.isNotEmpty ?? false) {
      Get.bottomSheet(LiveGameFollowBetPage(followId: followId!));
    }
  }
}
