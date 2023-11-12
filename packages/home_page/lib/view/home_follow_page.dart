import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/commons/widgets/ol_refresh_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_follow_controller.dart';
import '../widget/home_widget.dart';
import '../widget/live_item_widget.dart';

/// 首页关注
class HomeFollowPage extends GetBaseView<HomeFollowController> {
  const HomeFollowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: OlRefreshView(
        refreshCallback: _refreshCallback,
        buildWidgetCallback: () => SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: AppDimens.h_6),
                child: Divider(
                    height: AppDimens.h_1,
                    color: controller.currentCustomThemeData().colors0xDEDEDE),
              ),
              HomeWidget.of().subtitle(controller,
                  Assets.homePage.icHomeFollowed.path, 'followed_anchor'),
              // 已关注主播
              _followedWidget(),

              Container(
                margin: const EdgeInsets.symmetric(vertical: AppDimens.h_10),
                child: Divider(
                    height: AppDimens.h_1,
                    color: controller.currentCustomThemeData().colors0xDEDEDE),
              ),
              HomeWidget.of().subtitle(controller,
                  Assets.homePage.icHomeRecommend.path, 'recommend_anchor',
                  changeData: true,
                  onPressed: () => controller.getLiveFocusRecommendList()),
              const SizedBox(height: AppDimens.h_16),
              // 推荐主播
              _followRecommendWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _refreshCallback() async {
    controller.onInit();
    return false;
  }

  /// 空视图
  Widget _buildEmpty() {
    return OLBlankView();
  }

  /// 已关注主播
  Widget _followedWidget() => controller.obx(
        (state) => (state ?? []).isEmpty
            ? _buildEmpty()
            : GridView.builder(
                itemCount: state?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: HomeWidget.of().getGridDelegate(),
                padding: const EdgeInsets.all(AppDimens.w_10),
                itemBuilder: (_, int index) =>LiveHomeWidget(controller: controller, item: state?[index])),
      );

  /// 关注推荐
  Widget _followRecommendWidget() => Obx(() {
        var data = controller.focusRecommendData;
        return data.isEmpty
            ? _buildEmpty()
            : GridView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: HomeWidget.of().getGridDelegate(),
                padding: const EdgeInsets.all(AppDimens.w_10),
                itemBuilder: (_, int index) =>LiveHomeWidget(controller: controller, item: data[index]));
      });
}
