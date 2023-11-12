import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/widgets/ol_grid_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_other_controller.dart';
import '../widget/home_widget.dart';
import '../widget/live_item_widget.dart';

/// 首页热门、游戏、附近、星秀、体育
class HomeOtherPage extends GetBaseView<HomeOtherController> {
  /// 分类编号
  final String? columnCode;

  const HomeOtherPage({this.columnCode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.columnCode?.value = columnCode ?? "";
    controller.getLiveByColumnCode();
    return controller.obx((state) => OlGridView(
        dataList: state ?? [],
        gridDelegate: HomeWidget.of().getGridDelegate(),
        padding: const EdgeInsets.all(AppDimens.w_5),
        refreshCallback: _refreshCallback,
        loadMoreCallback: _loadMoreCallback,
        buildWidgetCallback: (_, index) =>
            LiveHomeWidget(controller: controller, item: state?[index])));
  }

  Future<bool> _refreshCallback(_) async {
    controller.getLiveByColumnCode();
    return false;
  }

  Future<bool> _loadMoreCallback(_) async {
    controller.getLiveByColumnCode(studioNum: controller.getLastStudioNum());
    return controller.hasMoreData.value;
  }
}
