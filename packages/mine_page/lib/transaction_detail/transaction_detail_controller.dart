import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/app_date_utils.dart';
import 'package:get/get.dart';
import 'package:mine_page/transaction_detail/models/transaction_type_bean.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

import 'transaction_detail_provider.dart';
import 'widgets/transaction_filter.dart';

enum TransactionType {
  income,
  expenditure,
}

enum TransactionPageType {
  balance,
  coin,
  diamond,
}

class TransactionDetailController extends GetXBaseController
    with GetSingleTickerProviderStateMixin {
  static TransactionDetailController get to => Get.find();

  late RefreshController refreshController;

  TransactionPageType? _pageType;

  // 标题
  String get title {
    switch (_pageType) {
      case TransactionPageType.balance:
        return '余额明细';
      case TransactionPageType.coin:
        return '金币明细';
      case TransactionPageType.diamond:
        return '钻石明细';
      default:
        return '交易明细';
    }
  }

  // 处理从钱包进入的查询逻辑
  String get billType {
    switch (_pageType) {
      case TransactionPageType.balance:
        return '1';
      case TransactionPageType.coin:
        return '2';
      case TransactionPageType.diamond:
        return '3';
      default:
        return '';
    }
  }

  // 处理从钱包进入的金额显示逻辑
  String get billOutcomeValue {
    switch (_pageType) {
      case TransactionPageType.balance:
        return (transactionModel?.balanceOutcome ?? 0.0).toStringAsFixed(2);
      case TransactionPageType.coin:
        return (transactionModel?.goldOutcome ?? 0.0).toStringAsFixed(2);
      case TransactionPageType.diamond:
        return (transactionModel?.silverOutcome ?? 0.0).toStringAsFixed(0);
      default:
        return '';
    }
  }

  // 处理从钱包进入的金额显示逻辑
  String get billIncomeValue {
    switch (_pageType) {
      case TransactionPageType.balance:
        return (transactionModel?.balanceIncome ?? 0.0).toStringAsFixed(2);
      case TransactionPageType.coin:
        return (transactionModel?.goldIncome ?? 0.0).toStringAsFixed(2);
      case TransactionPageType.diamond:
        return (transactionModel?.silverIncome ?? 0.0).toStringAsFixed(0);
      default:
        return '';
    }
  }

  int pageSize = 10;
  int lastItemId = 0;
  bool _noMore = false;

  List<DetailList> transactionList = [];

  TransactionDetailController();

  GameTransactionModel? transactionModel;
  final List<TransactionTypeBean> _transactionTypes = [];
  final List<TransactionTypeBean> _selectedTransactionTypes = [];

  final Rx<DateTime?> selectedDate = DateTime.now().obs;

  String get _rangeMonth {
    if (selectedDate.value == null) return '';
    return AppDateUtils.apiYearDayFormat1(selectedDate.value!.toLocal());
  }

  String get selectedDateStr {
    if (selectedDate.value == null) return '';
    return AppDateUtils.apiYearDayFormat3(selectedDate.value!.toLocal());
  }

  onDateUpdate(DateTime? newDate) {
    selectedDate.value = newDate;
    onRefresh();
  }

  Future<void> openFilter() async {
    if (_transactionTypes.isEmpty) {
      final types = await TransactionDetailProvider.getTransactionTypeList();
      if (types.isNotEmpty && !isClosed) {
        _transactionTypes.addAll(types);
      }
    }
    Get.bottomSheet(
      TransactionFilter(
        selectedTransactionTypes: _selectedTransactionTypes,
        transactionTypes: _transactionTypes,
        onConfirm: (selectedTypes) {
          bool isSame = false;
          if (selectedTypes.length == _selectedTransactionTypes.length) {
            isSame = true;
            for (var bean in selectedTypes) {
              for (var oldBean in _selectedTransactionTypes) {
                if (bean.code != oldBean.code) {
                  isSame = false;
                  break;
                }
              }
            }
          }
          if (!isSame) {
            _selectedTransactionTypes.clear();
            _selectedTransactionTypes.addAll(selectedTypes);
          }
          // 刷新数据
          onRefresh();
        },
      ),
    );
  }

  void toInfo(DetailList info) {
    Get.toNamed(
      AppRoutes.transactionInfo,
      arguments: info,
    );
  }

  Future<void> _getData({bool isRefresh = false}) async {
    if (isRefresh) lastItemId = 0;
    String billType = this.billType;
    if (billType.isEmpty) {
      billType = '1,2,3';
    }

    TransactionDetailProvider.getBill(
      lastID: lastItemId,
      billTypes: billType,
      rangeMonth: _rangeMonth,
      transactionTypes: _selectedTransactionTypes
          .map(
            (e) => e.code,
          )
          .toList()
          .join(','),
    ).then((value) {
      if (value != null) {
        if (isRefresh) {
          transactionModel = value;
        }
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
    if (Get.arguments != null) {
      _pageType = Get.arguments as TransactionPageType?;
    }
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
