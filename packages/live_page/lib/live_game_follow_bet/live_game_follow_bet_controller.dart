part of 'live_game_follow_bet_page.dart';

class LiveGameFollowBetController extends GetXBaseController {
  final String followId;

  LiveGameFollowBetController(this.followId);

  static LiveGameFollowBetController get to => Get.find();

  FollowBetInfoModel? infoModel;

  String get betNumber => '${infoModel?.kjNo ?? ''}';

  List<TomList> betList = [];

  Timer? _timer;
  int currentSec = 60;
  String currentSecStr = '';

  List<int> multiples = [1, 2, 5, 10];
  int currentMultiple = 1;

  String get betTotal => betList.isNotEmpty
      ? '${betList.map((e) => e.amount ?? 0).reduce((a, b) => a + b) * currentMultiple}'
      : '0';

  onSelectMultiple(int multiple) {
    currentMultiple = multiple;
    update();
  }

  void startCountdown() {
    const countdownDuration = Duration(seconds: 1);
    var remainingSeconds = currentSec;

    _timer?.cancel();
    _timer = Timer.periodic(countdownDuration, (timer) {
      remainingSeconds--;
      if (remainingSeconds == 0) {
        _timer?.cancel();
      }
      currentSecStr = TicketUtils.getCountDownTime(remainingSeconds);
      update();
    });
  }

  Future onBet() async {
    OLEasyLoading.showLoading('');
    NiuPostBetModel model = NiuPostBetModel();
    model.studioNum = infoModel?.studioNum;
    model.ticketBetOddsReqList = betList
        .map((e) => TicketBetOddsReqList(
              amount: e.amount,
              bid: e.bid,
              oid: e.oid,
              pbid: e.pbid,
              times: currentMultiple,
            ))
        .toList();
    model.ticketId = infoModel?.ticketId;
    LiveGameProvider.bet(model).then((res) {
      if (res?.result ?? false) {
        OLEasyLoading.showToast('投注成功');
        Get.until((route) => route.settings.name == AppRoutes.live);
      }
    }).whenComplete(
      () => OLEasyLoading.dismiss(),
    );
  }

  void _getData() async {
    OLEasyLoading.showLoading('');
    LiveGameProvider.followBetInfo(followId: followId).then((result) {
      infoModel = result;
      betList.clear();
      betList.addAll(result?.tomList ?? []);
      update();
    }).whenComplete(
      () => OLEasyLoading.dismiss(),
    );
  }

  @override
  void onInit() {
    _getData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void onDeleteItem(TomList item) {
    if (betList.length < 2) {
      OLEasyLoading.showToast('必须保留至少一个投注，无法全部移除');
      return;
    }
    if (betList.contains(item)) {
      betList.remove(item);
      update();
    }
  }
}
