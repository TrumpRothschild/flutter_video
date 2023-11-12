import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

import 'game_transaction_provider.dart';

enum TransactionType {
  income,
  expenditure,
}

class GameTransactionController extends GetXBaseController
    with GetSingleTickerProviderStateMixin {
  static GameTransactionController get to => Get.find();

  late TabController tabController;
  List<String> tabs = ['充值记录', '提现记录'];

  int get tabIndex => tabController.index;

  List<TransactionListController> transactionControllers = [
    TransactionListController(type: TransactionType.income),
    TransactionListController(type: TransactionType.expenditure),
  ];

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: tabs.length);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

class TransactionListController extends GetXBaseController
    with GetSingleTickerProviderStateMixin {
  final TransactionType type;

  late RefreshController refreshController;

  int pageSize = 10;
  int lastItemId = 0;
  bool _noMore = false;

  List<DetailList> transactionList = [];

  TransactionListController({required this.type});

  toTransactionInfo(DetailList item) {
    Get.toNamed(
      AppRoutes.transactionInfo,
      arguments: item,
    );
  }

  Future<void> _getData({bool isRefresh = false}) async {
    if (isRefresh) lastItemId = 0;
    GameTransactionProvider.getBill(
            lastID: lastItemId,
            transactionTypes: type == TransactionType.income ? '1' : '3',
            billTypes: type == TransactionType.income ? '' : '')
        .then(
      (value) => {
        if (value != null) fetchList(value, isRefresh),
      },
    );
  }

  fetchList(GameTransactionModel model, bool isRefresh) {
    final items = model.detailList ?? [];
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

  void onCancel(int? id) {
    OLEasyLoading.showLoading('');
    GameTransactionProvider.cancelWithdraw(
      UserManagerCache.shared.info?.id,
      id!,
    ).then((value) => {onRefresh()}, onError: (err) => {}).whenComplete(
          () => OLEasyLoading.dismiss(),
        );
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
