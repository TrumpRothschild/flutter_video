import 'dart:ui';

import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/judge_string_utils.dart';
import 'package:base/commons/widgets/ol_keep_alive_widget.dart';
import 'package:base/commons/widgets/ol_tab_indicator.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:base_page/ad/ol_ad_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_rich_text/flutter_html_rich_text.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/video/banner_data_bean.dart';
import 'package:services/models/res/video/banner_list_bean.dart';
import 'package:services/models/res/video/notice_list_bean.dart';
import 'package:services/models/res/video/video_bean.dart';
import 'package:services/models/res/video/video_category_model.dart';
import 'package:services/models/res/video/video_page_list_bean.dart';
import 'package:video_page/video_home/video_home_controller.dart';
import 'package:video_page/video_home/video_item_widget.dart';
import 'package:video_page/video_home/video_list_page.dart';

import 'marquee/marquee.dart';

/// 视频首页组件
class VideoHomeWidget {
  static VideoHomeWidget of() => VideoHomeWidget();
  final VideoHomeController _controller = Get.find<VideoHomeController>();

  /// 搜索
  Widget searchWidget() {
    var customTheme = _controller.currentCustomThemeData();
    return InkWell(
        onTap: () {
          Get.toNamed(
            "/searchTypePage",
          );
        },
        child: Container(
          height: AppDimens.h_30,
          margin: const EdgeInsets.only(left: AppDimens.w_10),
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.w_20),
              color: customTheme.colors0xF8F7F7,
              border: Border.all(
                  color: customTheme.colors0xECECEC!, width: AppDimens.w_1)),
          child: Row(
            children: [
              Image.asset(Assets.videoPage.vSeachIcon.path,
                  width: AppDimens.w_18, height: AppDimens.w_18),
              const SizedBox(width: AppDimens.w_10),
              Text(
                _controller.videoPageString('search_what_you_want_to_see'),
                style: TextStyle(
                    color: customTheme.colors0x979797,
                    fontSize: FontDimens.fontSp12),
              ),
            ],
          ),
        ));
  }

  /// 数据为空的列表
  Widget videoEmpty() {
    return Container(
        margin: const EdgeInsets.only(top: AppDimens.h_96),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.videoPage.icVideoEmpty.path,
                width: AppDimens.w_126, height: AppDimens.h_100),
            const SizedBox(height: AppDimens.h_16),
            Text("正在加载中...",
                style: TextStyle(
                    color: _controller.currentCustomThemeData().colors0xD6D6D6,
                    fontSize: FontDimens.fontSp12))
          ],
        ));
  }

  /// tabBar
  PreferredSizeWidget topTabBar(List<VideoCategoryModel> data) {
    var customTheme = _controller.currentCustomThemeData();
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      indicator: const OlTabBarIndicator(height: AppDimens.h_4),
      isScrollable: true,
      indicatorPadding: const EdgeInsets.only(bottom: AppDimens.w_6),
      labelPadding: const EdgeInsets.symmetric(horizontal: AppDimens.w_12),
      labelColor: customTheme.colors0x000000,
      labelStyle: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: FontDimens.fontSp16),
      unselectedLabelColor: customTheme.colors0x9F9F9F,
      unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal, fontSize: FontDimens.fontSp15),
      tabs: VideoHomeWidget.of()._videoTopTabs(data),
      onTap: (index) {},
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller.tabController,
    );
  }

  /// 获取tab
  List<Widget> _videoTopTabs(List<VideoCategoryModel> data) {
    List<Widget> tabs = [];
    for (var bean in data) {
      tabs.add(Tab(
        text: bean.categoryName ?? "",
      ));
    }
    return tabs;
  }

  ///  tab对应的页面
  List<Widget> videoTabPages(List<VideoCategoryModel> data) {
    List<Widget> pages = [];
    var index = 0;
    for (var bean in data) {
      pages.add(OlKeepAliveWidget(
        child: VideoListPage(
          categoryId: bean.id ?? 0,
        ),
      ));
      index = index + 1;
    }
    return pages;
  }

  /// 面板列表
  List<Widget> getItems(List<VideoPageListBean> data, BuildContext context) {
    List<Widget> _items = <Widget>[];
    for (var element in data) {
      Widget? w = getItemWidget(element, context);
      if (w != null) {
        _items.add(w);
      }
    }
    return _items;
  }

  /// 面板内容
  Widget? getItemWidget(VideoPageListBean element, BuildContext context) {
    List<List<VideoBean>> videoss = [];
    Widget? _widget;
    var noticeList = element.noticeList ?? [];
    PanelInfo? panelInfo = element.panelInfo;
    if (element.refrenceType == 0) {
      /// 面板信息
      _widget = _getPanel(panelInfo);
    } else if (element.refrenceType == 1 && noticeList.isNotEmpty) {
      /// 通知集合
      _widget = _noticeWidget(noticeList);
    } else if (element.refrenceType == 2) {
      ///banner集合
      _widget = _bannerGroupWidget(element.bannerList, context);
    } else if (element.refrenceType == 3) {
      ///banner
      _widget = _bannerWidget(element.banner, context);
    } else if (element.refrenceType == 4) {
      ///视频
      var columnNum = element.columnNum ?? 2;

      double _coverWidth = MediaQuery.of(context).size.width - AppDimens.w_20;
      double _coverHeight = AppDimens.h_195;

      if (columnNum > 1) {
        _coverWidth = (_coverWidth - AppDimens.w_5) / columnNum;
        _coverHeight = AppDimens.h_96;
      }
      VideoBean? _video = element.video;
      _widget = VideoItemWidget(
        video: _video,
        coverHeight: _coverHeight,
        coverWidth: _coverWidth,
      );
    }
    return _widget;
  }

  /// 通知
  Widget _noticeWidget(List<NoticeListBean> noticeList) {
    return Container(
      decoration: BoxDecoration(
          color: _controller.currentCustomThemeData().colors0xF0EAFF,
          borderRadius: BorderRadius.circular(AppDimens.w_5)),
      alignment: AlignmentDirectional.centerStart,
      height: AppDimens.h_30,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_5),
      child: Row(
        children: [
          AssetGenImage(Assets.videoPage.videoVector.path)
              .image(width: AppDimens.w_16, height: AppDimens.w_16),
          const SizedBox(width: AppDimens.w_4),
          Expanded(
            child: _buildMarqueeWidget(noticeList),
          )
        ],
      ),
    );
  }

  List<Widget> _buildMarqueeItems(List<NoticeListBean> loopList) {
    var index = 0;
    final items = loopList.map((e) {
      String itemStr = loopList[index].richText.toString();
      bool isChinese = StringUtil.isChinese(itemStr);
      index = index + 1;
      //通常可以是一个 Text文本
      return Container(
        padding: const EdgeInsets.only(right: 150),
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            fontSize: FontDimens.fontSp12,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
          maxLines: 1,
          child: InkWell(
            onTap: () {
              _controller.onclickNotice(e);
            },
            child: HtmlRichText(
              padding: EdgeInsets.only(top: isChinese ? 6 : 8),
              htmlText: itemStr,
              golobalTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: FontDimens.fontSp12,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ),
      );
    }).toList();
    return items;
  }

  /// 通知跑马灯
  Widget _buildMarqueeWidget(List<NoticeListBean> loopList) {
    ///上下轮播 安全提示
    int duration = loopList.length * 15000;
    return Marquee(
      directionMarguee: DirectionMarguee.oneDirection,
      animationDuration: Duration(milliseconds: duration),
      backDuration: const Duration(seconds: 5),
      pauseDuration: const Duration(milliseconds: 100),
      forwardAnimation: const Cubic(1.0, 1.0, 1.0, 1.0),
      autoRepeat: true,
      child: Wrap(
        children: _buildMarqueeItems(loopList),
      ),
    );
  }

  /// banner组
  Widget? _bannerGroupWidget(List<BannerListBean>? data, BuildContext context) {
    if (data == null || data.isEmpty) {
      return null;
    }
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.9,
        aspectRatio: 2.2,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        autoPlayInterval: const Duration(seconds: 10),
        pauseAutoPlayInFiniteScroll: true,
      ),
      items: data.map((item) {
        return InkWell(
          onTap: () {
            OLAdController.shared.click(item.type ?? 0, item.skipModel ?? 0,
                item.skipValue ?? "", item.extraParams ?? "");
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.w_5)),
            margin: const EdgeInsets.symmetric(horizontal: AppDimens.w_3),
            child: OLImage(
              imageUrl: item.bannerImage ?? "",
              fit: BoxFit.fitHeight,
              placeholderPath: Assets.videoPage.videoDefaultBanner.path,
              errorBuilder: (context, error, stacktrace) =>
                  Assets.videoPage.videoDefaultBanner.image(
                width: double.infinity,
                height: AppDimens.h_166,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 普通banner
  Widget? _bannerWidget(BannerDataBean? data, BuildContext context) {
    if (data == null) {
      return null;
    }
    return InkWell(
        onTap: () async {
          OLAdController.shared.click(data.type ?? 0, data.skipModel ?? 0,
              data.skipValue ?? "", data.extraParams ?? "");
        },
        child: AspectRatio(
          aspectRatio: 346 / 100,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.w_5)),
            child: OLImage(
              width: MediaQuery.of(context).size.width,
              imageUrl: data.bannerImage ?? "",
              placeholderPath: Assets.videoPage.videoDefaultBanner.path,
            ),
          ),
        ));
  }

  /// 面板信息
  Widget? _getPanel(PanelInfo? panel) {
    var isTitle = panel?.showTitleFlag == 1;
    var isMore = panel?.showMoreFlag == 1;
    if (panel == null || !isTitle) {
      return null;
    }
    var customTheme = _controller.currentCustomThemeData();
    return Padding(
        padding: const EdgeInsets.only(top: AppDimens.h_8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
                child: Text(
                  panel.panelName ?? "",
                  style: TextStyle(
                      color: customTheme.colors0x262626,
                      fontSize: FontDimens.fontSp16,
                      fontWeight: FontWeight.bold),
                ),
                visible: isTitle),
            Visibility(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.recommendPage, arguments: {
                      "title": panel.panelName,
                      "sortType": panel.sortType
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _controller.videoPageString('more'),
                        style: TextStyle(
                            color: customTheme.colors0xBBBBBB,
                            fontSize: FontDimens.fontSp13),
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          color: customTheme.colors0xBBBBBB,
                          size: AppDimens.w_14)
                    ],
                  ),
                ),
                visible: isMore)
          ],
        ));
  }

  /// 滑动到底部的提示
  Widget _footer() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: AppDimens.h_14),
      child: Text("—— 我也是有底线的 ——",
          style: TextStyle(
              color: _controller.currentCustomThemeData().colors0xD6D6D6,
              fontSize: FontDimens.fontSp14)),
    );
  }
}
