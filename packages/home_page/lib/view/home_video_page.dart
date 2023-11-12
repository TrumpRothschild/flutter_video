import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/widgets/ol_grid_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_video_controller.dart';
import '../widget/home_widget.dart';

/// 首页星秀
class HomeVideoPage extends GetBaseView<HomeVideoController> {
  const HomeVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => OlGridView(
        dataList: state ?? [],
        gridDelegate: HomeWidget.of().getGridDelegate(),
        padding: const EdgeInsets.all(AppDimens.w_10),
        refreshCallback: _refreshCallback,
        loadMoreCallback: _loadMoreCallback,
        buildWidgetCallback: (_, index) =>
            HomeWidget.of().videoItem(controller, state?[index])));
  }

  Future<bool> _refreshCallback(_) async {
    controller.onInit();
    return false;
  }

  Future<bool> _loadMoreCallback(_) async {
    controller.onInit();
    return controller.hasMoreData.value;
  }
}
