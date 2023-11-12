import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/widgets/ol_tab_indicator.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_page/controller/home_controller.dart';
import 'package:services/models/res/home/home_tab_bean.dart';

/// 首页
class HomePage extends GetBaseView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Center(
            child: DefaultTabController(
          initialIndex: 1,
          length: state?.length ?? 0,
          child: Scaffold(
            appBar: AppBar(
                toolbarHeight: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(AppDimens.h_50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDimens.w_5),
                            child: _homeTabBar(state),
                          )),
                      // 搜索
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.home + AppRoutes.homeSearch,
                              arguments: controller.curTabCode?.value);
                        },
                        child: AssetGenImage(Assets.homePage.icHomeSearch.path)
                            .image(
                                width: AppDimens.w_32, height: AppDimens.h_28),
                      ),
                      const SizedBox(width: AppDimens.w_4),
                      // 排行榜
                      InkWell(
                        onTap: () {
                          // OLEasyLoading.showToast("排行榜");
                          Get.toNamed(AppRoutes.rankingTab);
                        },
                        child: AssetGenImage(Assets.homePage.icHomeRank.path)
                            .image(
                          width: AppDimens.w_32,
                          height: AppDimens.h_28,
                        ),
                      ),
                      const SizedBox(width: AppDimens.w_10)
                    ],
                  ),
                )),
            body: TabBarView(
              // physics: const NeverScrollableScrollPhysics(),
              children: controller.getTabBarViews(state),
            ),
          ),
        )));
  }

  ///tabBar
  Widget _homeTabBar(List<HomeTabBean>? state) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      indicator: const OlTabBarIndicator(height: AppDimens.h_4),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: AppDimens.w_6),
      labelPadding: const EdgeInsets.symmetric(horizontal: AppDimens.w_6),
      labelColor: controller.currentCustomThemeData().colors0x000000,
      labelStyle: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: FontDimens.fontSp18),
      unselectedLabelColor: controller.currentCustomThemeData().colors0x9F9F9F,
      unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal, fontSize: FontDimens.fontSp15),
      tabs: _homeTabs(state),
      onTap: (index) {
        controller.curTabCode?.value = state?[index].columnCode ?? "";
      },
    );
  }

  List<Widget> _homeTabs(List<HomeTabBean>? state) {
    List<Widget> tabs = [];
    state?.forEach((bean) {
      tabs.add(Tab(
        text: bean.columnName ?? "",
      ));
    });
    return tabs;
  }
}
