import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/commons/widgets/ol_gradient_button.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_refresh_load_more_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_nearby_controller.dart';
import '../widget/home_widget.dart';
import '../widget/live_item_widget.dart';

/// 首页附近
class HomeNearbyPage extends GetBaseView<HomeNearbyController> {
  const HomeNearbyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OlRefreshLoadMoreView(
          refreshCallback: _refreshCallback,
          loadMoreCallback: _loadMoreCallback,
          buildWidgetCallback: () => CustomScrollView(
                slivers: [_curLocation(), _liveDataWidget()],
              )),
    );
  }

  Future<bool> _refreshCallback() async {
    controller.getLiveByColumnCode();
    return false;
  }

  Future<bool> _loadMoreCallback() async {
    controller.getLiveByColumnCode(studioNum: controller.getLastStudioNum());
    return controller.hasMoreData.value;
  }

  /// 空视图
  SliverToBoxAdapter _buildEmpty() {
    return SliverToBoxAdapter(
      child: OLBlankView(),
    );
  }

  /// 当前位置信息
  Widget _curLocation() => Obx(() {
        var locationData = controller.locationData.value;
        return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10),
            sliver: SliverToBoxAdapter(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: OlGradientButton(
                        tapCallback: () {
                          OLEasyLoading.showToast("msg");
                        },
                        borderRadius: BorderRadius.circular(AppDimens.w_10),
                        height: AppDimens.h_20,
                        width: AppDimens.w_60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: AppDimens.w_4,
                            ),
                            Text(
                              locationData?.provinceName ??
                                  locationData?.countryName ??
                                  "",
                              style: TextStyle(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0xFFFFFF,
                                  fontSize: FontDimens.fontSp13),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.white,
                              size: AppDimens.w_18,
                            )
                          ],
                        )))));
      });

  Widget _liveDataWidget() => Obx(() {
        var data = controller.liveData;
        return data.isEmpty
            ? _buildEmpty()
            : SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.w_10, vertical: AppDimens.w_5),
                sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return LiveHomeWidget(
                          controller: controller, item: data[index]);
                    }, childCount: data.length),
                    gridDelegate: HomeWidget.of().getGridDelegate()),
              );
      });
}
