import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_refresh_load_more_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:services/image/ol_image.dart';

import '../controller/home_recommend_controller.dart';
import '../widget/home_widget.dart';
import '../widget/live_item_widget.dart';

//
// _topGameWidget(),
// _noticeWidget(),
// _recommendWidget(),
// _bannerWidget(),
// SliverToBoxAdapter(
// child: HomeWidget.of().subtitle(controller,
// Assets.homePage.icHomeHotVideo.path, 'hot_video')),
// _hotVideoWidget(),
// _liveListWidget(),
// ],

/// 首页推荐
class HomeRecommendPage extends GetBaseView<HomeRecommendController> {
  const HomeRecommendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OlRefreshLoadMoreView(
      refreshCallback: _refreshCallback,
      loadMoreCallback: _loadMoreCallback,
      buildWidgetCallback: () => ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [
                _topGameWidget(),
              ],
            );
          } else if (index == 1) {
            return _noticeWidget();
          } else if (index == 2) {
            return _recommendWidget();
          } else if (index == 3) {
            return _bannerWidget();
          } else if (index == 4) {
            return  HomeWidget.of().subtitle(controller, Assets.homePage.icHomeHotVideo.path, 'hot_video');
          } else if (index == 5) {
            return  _hotVideoWidget();
          } else {
            return _liveListWidget();
          }
        },
        itemCount: 7,
      ),
    );
  }

  Future<bool> _refreshCallback() async {
    controller.pageNum.value = 1;
    controller.onInit();
    return false;
  }

  Future<bool> _loadMoreCallback() async {
    controller.pageNum.value += 1;
    controller.getLiveList();
    return controller.hasMoreData.value;
  }

  /// 空视图
  Widget _buildEmpty() {
    return Container(
      child: OLBlankView(),
    );
  }

  /// 顶部游戏
  Widget _topGameWidget() => Obx(() {
        var data = controller.topGameData;
        return data.isEmpty
            ? _buildEmpty()
            : Padding(padding:  const EdgeInsets.symmetric(
            horizontal: AppDimens.w_10, vertical: AppDimens.w_5)
          , child: Column(
          children: [
            GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  //设置列数
                    crossAxisCount: 5,
                    //设置横向间距
                    crossAxisSpacing: AppDimens.w_5,
                    // 宽高比
                    childAspectRatio: 1.89,
                    //设置主轴间距
                    mainAxisSpacing: AppDimens.h_5),
                itemBuilder: (context, index) {
                  return HomeWidget.of().topGameItem(data[index]);
                },
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics())
          ],
        ),);
      });

  /// 跑马灯公告
  Widget _noticeWidget() => Obx(() {
        var data = controller.noticeBeanData.value;
        var noticeContent = data?.noticeContent ?? "  ";

        return Container(
          alignment: AlignmentDirectional.centerStart,
          height: AppDimens.h_26,
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_8),
          margin: const EdgeInsets.symmetric(horizontal: AppDimens.w_2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.w_5),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF9E85F6),
                    Color(0xFFA571EB),
                    Color(0xFFD3A5F7)
                  ],
                  stops: [
                    0.0449,
                    0.5682,
                    0.9571
                  ])),
          child: Row(
            children: [
              AssetGenImage(Assets.homePage.icHomeSuona.path)
                  .image(width: AppDimens.w_16, height: AppDimens.w_16),
              const SizedBox(width: AppDimens.w_4),
              Expanded(
                  child: Marquee(
                      blankSpace: AppDimens.w_50,
                      key: Key(noticeContent),
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xFFFFFF,
                          fontSize: FontDimens.fontSp12),
                      text: noticeContent.replaceAll("\n", "")))
            ],
          ),
        );
      });

  /// 推荐主播
  Widget _recommendWidget() => Obx(() {
        var data = controller.recommendLiveData;
        return data.isEmpty
            ? _buildEmpty()
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.w_10, vertical: AppDimens.w_5),
                child: GridView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return LiveHomeWidget(
                          controller: controller, item: data[index]);
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: HomeWidget.of().getGridDelegate()),
              );
      });

  /// 轮播图
  Widget _bannerWidget() => Obx(() {
        var data = controller.bannerData;
        return SizedBox(
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
            ),
            items: data.map((item) {
              return InkWell(
                onTap: () {
                  if (!(GetUtils.isNull(item.skipUrl) ||
                      (item.skipUrl ?? "").isEmpty)) {
                    OLEasyLoading.showToast("跳转");
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: AppDimens.h_20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppDimens.w_10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimens.w_10),
                    child: OLImage(
                      imageUrl: item.advImg ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      });

  /// 热门视频
  Widget _hotVideoWidget() => Obx(() {
        var data = controller.hotVideData;
        return data.isEmpty
            ? _buildEmpty()
            : Container(
                height: AppDimens.h_120,
                margin: const EdgeInsets.only(top: AppDimens.h_10),
                padding: const EdgeInsets.only(left: AppDimens.w_10),
                child: ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) =>
                        HomeWidget.of().hotVideoItem(data[index])),
              );
      });

  /// 已关注主播
  Widget _liveListWidget() => Obx(() {
        var data = controller.liveData;
        return data.isEmpty
            ? _buildEmpty()
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.w_10, vertical: AppDimens.w_5),
                child: GridView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return LiveHomeWidget(
                          controller: controller, item: data[index]);
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: HomeWidget.of().getGridDelegate()),
              );
      });
}
