import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_list_footer_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:video_page/video_home/video_home_controller.dart';
import 'package:video_page/video_home/video_home_widget.dart';

class VideoListPage extends StatelessWidget {
  final int categoryId;

  const VideoListPage({Key? key, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoHomeController>(
        id: categoryId,
        builder: (controller) {
          var data = controller.curPageData;
          RefreshController refreshController = controller.controllers[categoryId.toString()] ?? RefreshController(initialRefresh: false);
          return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              header: const WaterDropHeader(),
              footer: ListFooterWidget(),
              onRefresh: () {
                _loadReflashData(controller);
              },
              onLoading: () {
                _loadMoreCallback(controller);
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.w_10),
                  child: Wrap(
                    spacing: AppDimens.w_5,
                    runSpacing: AppDimens.h_10,
                    children: VideoHomeWidget.of().getItems(data, context),
                  )));
        });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GetBuilder<VideoHomeController>(
  //       id: categoryId,
  //       builder: (controller) {
  //         var data = controller.handleCurPageData;
  //         return Scaffold(
  //             body: OlRefreshView(refreshCallback: () async {
  //           controller.getCurrentPageData(isRefresh: true);
  //           return true;
  //         }, buildWidgetCallback: () {
  //           if (data.isEmpty) {
  //             return VideoHomeWidget.of().videoEmpty();
  //           } else {
  //             return MediaQuery.removePadding(
  //                 context: context,
  //                 removeTop: true,
  //                 removeBottom: true,
  //                 child: ListView.separated(
  //                     separatorBuilder: (BuildContext context, int index) {
  //                       return const Divider(
  //                         height: AppDimens.h_10,
  //                         color: Colors.transparent,
  //                       );
  //                     },
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: AppDimens.w_10, vertical: 0),
  //                     itemCount: data.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return VideoHomeWidget.of()
  //                               .getItemWidget(data[index], context) ??
  //                           const SizedBox(
  //                             height: 0,
  //                           );
  //                     }));
  //           }
  //         }));
  //       });
  // }
  /// 下拉刷新
  _loadReflashData(VideoHomeController controller) {
    controller.pageNums[controller.curCategoryId.value.toString()] = 1.obs;
    Log.e("pageNums:${controller.pageNums}");
    controller.getCurrentPageData(isRefresh: true);
  }

  /// 上拉加载更多
  _loadMoreCallback(VideoHomeController controller) async {
    RxInt pageNum = controller.pageNums[controller.curCategoryId.value.toString()];
    pageNum.value += 1;
    controller.pageNums[controller.curCategoryId.value.toString()] = pageNum;
    Log.e("pageNums:${controller.pageNums}");
    controller.getCurrentPageData(isUpRefresh: true);
  }
}
