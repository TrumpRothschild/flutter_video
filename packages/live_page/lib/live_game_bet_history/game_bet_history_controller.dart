part of 'game_bet_history_page.dart';

class GameBetHistoryController extends GetXBaseController {
  int ticketId;

  GameBetHistoryController(this.ticketId);

  static GameBetHistoryController get to => Get.find();

  late RefreshController refreshController;

  List<GameBetModel?> betList = [];
  int pageNum = 1;
  int pageSize = 20;
  bool _noMore = false;

  int gameTypeIndex = 0;
  List<GameTypeModel?> gameTypes = [];

  String get currentGameType => gameTypeIndex > gameTypes.length - 1
      ? ''
      : gameTypes[gameTypeIndex]?.name ?? '';

  String? zjStatus;
  int statusIndex = 0;
  List<String> statusList = ['全部状态', '待开奖', '已中奖', '未中奖'];

  String get currentStatus => statusList[statusIndex];

  String? tzDate;

  GameStatistics? statistics;

  Future<void> setGameFilter() async {
    if (gameTypes.isEmpty) {
      final types = await LiveGameProvider.getGameTypeList();
      if (types.isNotEmpty) {
        gameTypes.addAll(types);
      }
    }
    int? index = await Get.bottomSheet<int?>(
      GameFilter(
        customTheme: currentCustomThemeData(),
        types: gameTypes,
        selectedIndex: gameTypeIndex,
      ),
    );
    if (index != null && index != gameTypeIndex) {
      gameTypeIndex = index;
      ticketId = gameTypes[index]?.id ?? 1;
      onRefresh();
    }
  }

  void setDateFilter(DateTime selectedDate) {
    tzDate = AppDateUtils.apiDayFormat(selectedDate);
    onRefresh();
  }

  Future<void> setStatusFilter() async {
    int? index = await Get.bottomSheet<int?>(
      StatusFilter(
        customTheme: currentCustomThemeData(),
        types: statusList,
        selectedIndex: statusIndex,
      ),
    );
    if (index != null && index != statusIndex) {
      statusIndex = index;
      if (statusIndex != 0) {
        zjStatus = '${index - 1}';
      }
      onRefresh();
    }
  }

  Future<void> getGameFilter() async {
    final types = await LiveGameProvider.getGameTypeList();
    if (types.isNotEmpty) {
      gameTypes.addAll(types);
      gameTypeIndex = gameTypes.indexWhere((element) => element?.id == ticketId);
      update();
    }
  }

  Future<void> _getData({bool isRefresh = false}) async {
    if (isRefresh) pageNum = 1;
    LiveGameProvider.getBetList(
      pageNum: pageNum,
      pageSize: pageSize,
      ticketId: ticketId,
      zjStatus: zjStatus,
      tzDate: tzDate,
    ).then((items) {
      if (isRefresh) {
        betList.clear();
      }
      if (items.isNotEmpty) {
        _noMore = items.length < 20;
      } else {
        _noMore = true;
      }
      betList.addAll(items);
      pageNum++;
      update();
    });
  }

  Future<void> _getStatistics() async {
    LiveGameProvider.getStatistics(
      ticketId: ticketId,
      zjStatus: zjStatus,
      tzDate: tzDate,
    ).then((value) {
      statistics = value;
      update();
    });
  }

  void onRefresh() {
    _getData(isRefresh: true).then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController.refreshFailed();
    });
    _getStatistics();
  }

  void onLoading() {
    if (!_noMore) {
      _getData().then((_) {
        refreshController.loadComplete();
      }).catchError((_) {
        refreshController.loadFailed();
      });
    } else {
      refreshController.loadNoData();
    }
  }

  @override
  void onInit() {
    refreshController = RefreshController();
    getGameFilter();
    super.onInit();
  }

  @override
  void onReady() {
    onRefresh();
    super.onReady();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
