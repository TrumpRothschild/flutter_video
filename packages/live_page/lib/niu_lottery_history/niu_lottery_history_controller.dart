part of 'niu_lottery_history_page.dart';

class NiuLotteryHistoryController extends GetXBaseController {
  late RefreshController refreshController;

  int pageNum = 1;
  bool _noMore = false;

  List<GameTicketModel?> lotteryList = [];

  Future<void> _getData({bool isRefresh = false}) async {
    if (isRefresh) pageNum = 1;
    LiveGameProvider.getLotteryList(1, pageNum: pageNum).then((list) {
      fetchList(list);
    });
  }

  fetchList(List<GameTicketModel?>? list, {bool isRefresh = true}) {
    final items = list ?? [];
    if (isRefresh) {
      lotteryList.clear();
    }
    if (items.isNotEmpty) {
      _noMore = items.length < 20;
    } else {
      _noMore = true;
    }
    lotteryList.addAll(items);
    update();
  }

  void onRefresh() {
    _getData(isRefresh: true).then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController.refreshFailed();
    });
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
