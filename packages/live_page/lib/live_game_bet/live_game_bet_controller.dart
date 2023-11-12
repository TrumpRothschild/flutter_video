part of 'live_game_bet_page.dart';

class LiveGameBetController extends GetXBaseController {
  static LiveGameBetController get to => Get.find();

  String betNumber = '';
  int currentSec = 60;
  String currentSecStr = '';

  Timer? _timer;

  List<int> multiples = [1, 2, 5, 10, 20];
  int currentMultiple = 1;

  String get betTotal =>
      '${LiveGameController.to.selectedOddsList.length * LiveGameController.to.chip * currentMultiple}';

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
    model.studioNum = LiveController.of.studioNum;
    final betList = LiveGameController.to.selectedOddsList;
    model.ticketBetOddsReqList = betList
        .map((e) => TicketBetOddsReqList(
              amount: LiveGameController.to.chip * currentMultiple,
              bid: e.parentId,
              oid: [e.id ?? 0],
              pbid: 0,
              times: currentMultiple,
            ))
        .toList();
    model.ticketId = LiveGameController.to.ticketId;
    LiveGameProvider.bet(model).then((res) {
      if (res?.result ?? false) {
        OLEasyLoading.showToast('投注成功');
        Get.until((route) => route.settings.name == AppRoutes.live);
      }
    }).whenComplete(
      () => OLEasyLoading.dismiss(),
    );
  }

  @override
  void onInit() {
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

  void onDeleteItem(Odds item) {
    if (LiveGameController.to.selectedOddsList.length < 2) {
      OLEasyLoading.showToast('至少选择一条投注');
      return;
    }
    if (LiveGameController.to.selectedOddsList.contains(item)) {
      LiveGameController.to.selectedOddsList.remove(item);
      LiveGameController.to.update();
      update();
    }
  }
}
