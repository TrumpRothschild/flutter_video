import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/home/home_search_bean.dart';

import '../controller/home_search_controller.dart';
import '../widget/home_widget.dart';
import '../widget/live_item_widget.dart';

/// 首页搜索
class HomeSearchPage extends GetBaseView<HomeSearchController> {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tabCode = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _appBarTitle(tabCode),
        actions: [
          Center(
            child: InkWell(
              child: Text(
                controller.homePageString('cancel'),
                style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x9F44FF,
                    fontSize: FontDimens.fontSp16),
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
          const SizedBox(width: AppDimens.w_10)
        ],
      ),
      body: CustomScrollView(
        slivers: [
          tabCode == "star" ? _searchVideoResult() : _searchLiveResult(),
          SliverToBoxAdapter(
            child: Visibility(
                child: HomeWidget.of().subtitle(controller,
                    Assets.homePage.icHomeHistory.path, 'search_history'),
                visible: (!controller.isSearch.value &&
                    controller.historyData.isNotEmpty)),
          ),
          _searchHistory(),
          SliverToBoxAdapter(
            child: HomeWidget.of().subtitle(controller,
                Assets.homePage.icHomeRecommend.path, 'recommend_anchor',
                changeData: true,
                onPressed: () => controller.getLiveFocusRecommendList()),
          ),
          _liveDataWidget()
        ],
      ),
    );
  }

  /// 搜索框
  Widget _appBarTitle(String tabCode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_8),
      height: AppDimens.h_30,
      decoration: BoxDecoration(
          color: controller.currentCustomThemeData().colors0xF5F5F5,
          borderRadius: BorderRadius.circular(AppDimens.w_20)),
      child: Row(
        children: [
          AssetGenImage(Assets.homePage.icHomeSearchGray.path)
              .image(width: AppDimens.w_13, height: AppDimens.h_13),
          const SizedBox(width: AppDimens.w_8),
          Expanded(
              child: TextField(
            style: TextStyle(
                fontSize: FontDimens.fontSp14,
                color: controller.currentCustomThemeData().colors0x000000),
            controller: controller.searchTec,
            cursorColor: controller.currentCustomThemeData().colors0x9F44FF,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: controller.homePageString('hint_uid_nickname'),
                hintStyle: TextStyle(
                    color: controller.currentCustomThemeData().colors0xC8C8C8,
                    fontSize: FontDimens.fontSp12)),
            onChanged: (text) {
              // 延迟一秒进行搜索
              Future.delayed(const Duration(seconds: 1), () {
                controller.handleSearch(tabCode, controller.searchTec.text);
              });
            },
            onEditingComplete: () {
              controller.handleSearch(tabCode, controller.searchTec.text);
            },
          )),
          const SizedBox(width: AppDimens.w_8),
          InkWell(
            child: AssetGenImage(Assets.homePage.icHomeClear.path)
                .image(width: AppDimens.w_16, height: AppDimens.h_16),
            onTap: () => controller.searchTec.clear(),
          ),
        ],
      ),
    );
  }

  /// 空视图
  SliverToBoxAdapter _buildEmpty() {
    return SliverToBoxAdapter(
      child: OLBlankView(),
    );
  }

  /// 搜索结果为空
  SliverToBoxAdapter _searchResEmpty() {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          children: [
            AssetGenImage(Assets.homePage.icHomeSearchNoData.path)
                .image(width: AppDimens.w_220, height: AppDimens.h_175),
            Text(
              controller.homePageString('search_no_anchor'),
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000,
                  fontSize: FontDimens.fontSp14),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: AppDimens.h_6),
              child: Divider(
                  height: AppDimens.h_1,
                  color: controller.currentCustomThemeData().colors0xDEDEDE),
            ),
          ],
        ),
      ),
    );
  }

  /// 搜索结果
  Widget _searchLiveResult() => Obx(() {
        if (!controller.isSearch.value) {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
        var data = controller.searchData;
        return data.isEmpty
            ? _searchResEmpty()
            : SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.w_10, vertical: AppDimens.w_5),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  return _searchLiveWidget(data[index]);
                }, childCount: data.length)));
      });

  /// 搜索星秀结果展示组件
  Widget _searchVideoResult() => Obx(() {
        var data = controller.videData;
        if (!controller.isSearch.value) {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
        return data.isEmpty
            ? _searchResEmpty()
            : SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.w_10, vertical: AppDimens.w_5),
                sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return HomeWidget.of().videoItem(controller, data[index]);
                    }, childCount: data.length),
                    gridDelegate: HomeWidget.of().getGridDelegate()),
              );
      });

  /// 搜索历史
  Widget _searchHistory() => Obx(() {
        var data = controller.historyData;
        return (!controller.isSearch.value && data.isEmpty)
            ? const SliverToBoxAdapter(
                child: SizedBox.shrink(),
              )
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

  Widget _liveDataWidget() => Obx(() {
        var data = controller.focusRecommendData;
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

  /// 搜索直播结果展示item组件
  Widget _searchLiveWidget(AnchorList bean) {
    return ListTile(
      isThreeLine: true,
      leading: CircleAvatar(
        child: OLImage(
          imageUrl: bean.avatar ?? "",
        ),
      ),
      title: Text(bean.nickName ?? ""),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bean.remark ?? ""),
          Text(
            bean.remark ?? controller.homePageString('def_sign'),
            style: TextStyle(
                color: controller.currentCustomThemeData().colors0x8D8D8D,
                fontSize: FontDimens.fontSp14),
          ),
        ],
      ),
    );
  }
}
