part of 'live_game_page.dart';

class LiveGameController extends GetXBaseController
    with GetTickerProviderStateMixin {
  final String gameName;

  final int ticketId;

  LiveGameController(this.gameName, this.ticketId);

  static LiveGameController get to => Get.find();

  TabController? tabController;
  List<String> tabs = [];

  GameTicketModel? lastInfo;

  List<NiuNiuDetailModel?> detailModelList = [];

  int _currentSec = 60;
  String currentSecStr = '';

  final Lock _lock = Lock();
  Timer? _timer;

  void startCountdown(int countdownDuration) async {
    print('xxx countdownDuration : $countdownDuration');
    await _lock.synchronized(() async {
      int remainingSeconds = countdownDuration;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        await _lock.synchronized(() async {
          remainingSeconds--;
          if (remainingSeconds == 0) {
            _timer?.cancel();
          }
          _currentSec = remainingSeconds;
          currentSecStr = TicketUtils.getCountDownTime(remainingSeconds);
          update(['countDown']);
        });
      });
    });
  }

  bool isShowLottery = false;
  List<GameTicketModel?> expandedList = [];

  List<Odds> selectedOddsList = [];

  int chip = 5;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future getRecentInfo() async {
    lastInfo = await LiveGameProvider.getRecentInfo(ticketId);
    startCountdown(lastInfo?.sec ?? 0);
  }

  Future getDetailInfo() async {
    detailModelList = await LiveGameProvider.getDetailInfo(1, ticketId);
    tabs = detailModelList.map((e) => e?.bet ?? '').toList();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  Future toExplain() async {
    OLEasyLoading.showLoading('');
    LiveGameProvider.getExplain(ticketId).then((model) {
      if (model?.content?.isNotEmpty ?? false) {
        Get.bottomSheet(BottomExplainPage(
          explain: model!.content!,
        ));
      }
    }).whenComplete(
      () => OLEasyLoading.dismiss(),
    );
  }

  getData() async {
    await Future.wait(
      [getRecentInfo(), getDetailInfo()],
    ).whenComplete(() {
      update();
    });
  }

  @override
  void onClose() {
    tabController?.dispose();
    _timer?.cancel();
    super.onClose();
  }

  Future getLotteryList() async {
    OLEasyLoading.showLoading('');
    LiveGameProvider.getLotteryList(ticketId).then((list) {
      expandedList = list;
      update();
    }).whenComplete(
      () => OLEasyLoading.dismiss(),
    );
  }

  void toggleLottery() {
    isShowLottery = !isShowLottery;
    update();
    if (isShowLottery) getLotteryList();
  }

  Future getBetList() async {
    OLEasyLoading.showLoading('');
    LiveGameProvider.getBetList(ticketId: ticketId).then((list) {
      expandedList = list.map((e) => e?.toNiuNiuModel()).toList();
      update();
    }).whenComplete(
      () => OLEasyLoading.dismiss(),
    );
  }

  void toBetRecord() {
    Get.bottomSheet(GameBetHistoryPage(ticketId: ticketId));
  }

  void toMoreRecord() {
    Get.bottomSheet(const NiuLotteryHistoryPage());
  }

  void onBet() {
    if (lastInfo == null) return;
    if (selectedOddsList.isEmpty) return;
    final controller = Get.put(LiveGameBetController());
    controller.betNumber = '${lastInfo!.kjNo ?? ''}';
    controller.currentSec = _currentSec;
    controller.startCountdown();
    Get.bottomSheet(const LiveGameBetPage());
  }

  onSelectOdds(Odds odds) {
    if (selectedOddsList.contains(odds)) {
      selectedOddsList.remove(odds);
    } else {
      selectedOddsList.insert(0, odds);
    }
    update();
  }

  void changeChip() async {
    chip = await Get.bottomSheet<int?>(
          BottomChipPage(
            chip: chip,
            customTheme: currentCustomThemeData(),
          ),
        ) ??
        5;
    update();
  }

  void updateInfo(String infoContent) {
    lastInfo = ImMsgUtils.of().convertTicket(infoContent);
    startCountdown(lastInfo?.sec ?? 0);
  }
}
