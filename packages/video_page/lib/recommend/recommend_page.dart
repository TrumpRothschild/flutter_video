import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_grid_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:video_page/recommend/recommend_controller.dart';
import 'package:video_page/video_home/video_item_widget.dart';

/// 视频推荐
class RecommendPage extends GetView<RecommendPageController> {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: controller.currentCustomThemeData().colors0xF8F8F8,
          leading: AppBarBackButton(),
          title: Obx(() => Text(controller.title.value,
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000,
                  fontSize: sp(32),
                  fontWeight: FontWeight.w600))),
        ),
        body: controller.obx((state) {
          var data = state ?? [];
          return OlGridView(
              dataList: data,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10)
                  .copyWith(top: AppDimens.h_20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //设置列数
                  crossAxisCount: 2,
                  childAspectRatio: 170 / 146,
                  //设置横向间距
                  crossAxisSpacing: AppDimens.w_5),
              refreshCallback: _refreshCallback,
              loadMoreCallback: _loadMoreCallback,
              buildWidgetCallback: (_, index) {
                return VideoItemWidget(
                    video: data[index],
                    coverWidth:
                        MediaQuery.of(context).size.width - AppDimens.w_25,
                    coverHeight: AppDimens.h_96);
              });
        }));
  }

  Future<bool> _refreshCallback(_) async {
    controller.pageNum.value = 1;
    controller.videoSearch();
    return false;
  }

  Future<bool> _loadMoreCallback(_) async {
    controller.pageNum.value++;
    controller.videoSearch();
    return controller.hasMoreData.value;
  }

  Widget _getFooter() {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(
            videoPageTranslations['up_loading_more'].toString(),
            style: TextStyle(color: const Color(0xff999999), fontSize: sp(28)),
          );
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text(
            videoPageTranslations['loading_failed_try_again'].toString(),
            style: TextStyle(color: const Color(0xff999999), fontSize: sp(28)),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(videoPageTranslations['release_loading_more'].toString(),
              style:
                  TextStyle(color: const Color(0xff999999), fontSize: sp(28)));
        } else {
          body = Text(
            videoPageTranslations['loading_no_data'].toString(),
            style: TextStyle(color: const Color(0xff999999), fontSize: sp(28)),
          );
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
