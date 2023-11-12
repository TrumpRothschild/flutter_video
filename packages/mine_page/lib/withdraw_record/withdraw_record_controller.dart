import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/app_date_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

import '../withdraw/widgets/delete_bank_card_alert.dart';
import 'withdraw_record_provider.dart';

class WithdrawRecordController extends GetXBaseController
    with GetSingleTickerProviderStateMixin {
  static WithdrawRecordController get to => Get.find();

  late RefreshController refreshController;

  int pageSize = 10;
  int lastItemId = 0;
  bool _noMore = false;

  List<DetailList> transactionList = [];

  WithdrawRecordController();

  final Rx<DateTime?> selectedDate = DateTime.now().obs;

  String get _rangeMonth {
    if (selectedDate.value == null) return '';
    return AppDateUtils.apiYearDayFormat1(selectedDate.value!.toLocal());
  }

  String get selectedDateStr {
    if (selectedDate.value == null) return '';
    return AppDateUtils.apiYearDayFormat3(selectedDate.value!.toLocal());
  }

  void onCancel(int? id) {
    Get.dialog(
      DeleteBankCardAlert(
        customTheme: currentCustomThemeData(),
        title: '是否确认取消订单？',
        onConfirm: () async {
          OLEasyLoading.showLoading('');
          WithdrawRecordProvider.cancelWithdraw(
            UserManagerCache.shared.info?.id,
            id!,
          ).then((value) => {onRefresh()}, onError: (err) => {}).whenComplete(
                () => OLEasyLoading.dismiss(),
              );
        },
      ),
    );
  }

  onDateUpdate(DateTime? newDate) {
    selectedDate.value = newDate;
    onRefresh();
  }

  void toInfo(DetailList info) {
    Get.toNamed(
      AppRoutes.transactionInfo,
      arguments: info,
      // {
      //   'pageType': TransactionInfoPageType.withdraw,
      //   'orderNo': info.orderNO,
      // },
    );
  }

  Future<void> _getData({bool isRefresh = false}) async {
    if (isRefresh) lastItemId = 0;

    WithdrawRecordProvider.getBill(
      lastID: lastItemId,
      billTypes: '2',
      transactionTypes: '3',
      rangeMonth: _rangeMonth,
    ).then((value) {
      if (value != null) {
        fetchList(value, isRefresh);
      }
    });
  }

  fetchList(GameTransactionModel model, bool isRefresh) {
    final items = (model.detailList?.isNotEmpty == true)
        ? model.detailList!
        : <DetailList>[];
    if (isRefresh) {
      transactionList.clear();
    }
    transactionList.addAll(items);
    if (items.isNotEmpty) {
      _noMore = lastItemId == items.last.id;
      lastItemId = items.last.id ?? 0;
    } else {
      _noMore = true;
    }
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
