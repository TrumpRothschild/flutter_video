import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/home/home_live_bean.dart';

import '../../widgets/common_image.dart';
import '../live_page.dart';

/// 直播间抽屉布局
class LiveRecommendDrawer extends StatelessWidget {
  final LiveController _controller = Get.find<LiveController>();

  LiveRecommendDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.w_145,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.h_180),
            child: InkWell(
              onTap: () => Get.back(),
              child: Assets.livePage.icLiveRecommendClose.image(
                width: AppDimens.w_30,
                height: AppDimens.h_40,
              ),
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimens.h_10, horizontal: AppDimens.w_8),
            color: _controller.currentCustomThemeData().colors0x000000_80,
            child: Column(
              children: [
                const Text('为您推荐',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontDimens.fontSp16,
                    )),
                const SizedBox(height: AppDimens.h_10),
                Expanded(
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: AppDimens.h_5),
                            itemCount: _controller.liveRecommendData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _itemWidget(
                                  _controller.liveRecommendData[index]);
                            })))
              ],
            ),
          ))
        ],
      ),
    );
  }

  /// 推荐列表item
  Widget _itemWidget(HomeLiveBean item) {
    return InkWell(
        onTap: () {
          var studioNum = item.studioNum ?? "";
          if (studioNum.isNotEmpty) {
            _controller.initData(studioNum);
          } else {
            OLEasyLoading.showToast("房间号为空！");
          }

          Get.back();
        },
        child: Container(
          width: AppDimens.w_100,
          height: AppDimens.w_100,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.w_8),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CommonImage(
                width: AppDimens.w_100,
                height: AppDimens.w_100,
                imageUrl: item.studioThumbImage,
              ),
              _itemTopAddress(item),
              _itemBottomTitle(item)
            ],
          ),
        ));
  }

  /// 顶部位置
  Widget _itemTopAddress(HomeLiveBean item) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: AppDimens.h_14,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_5),
        decoration: BoxDecoration(
          color: _controller.currentCustomThemeData().colors0x000000_30,
          borderRadius: BorderRadius.circular(AppDimens.w_20),
        ),
        margin: const EdgeInsets.all(AppDimens.w_6),
        child: Text(
          item.countryName ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: FontDimens.fontSp10,
          ),
        ),
      ),
    );
  }

  /// 底部标题
  Widget _itemBottomTitle(HomeLiveBean item) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: AppDimens.h_25,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_6),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0),
              Colors.black.withOpacity(0.7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Text(
          item.studioTitle ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: FontDimens.fontSp12,
          ),
        ),
      ),
    );
  }
}
