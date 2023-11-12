import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contribution_list/contribution_list_page.dart';
import '../../widgets/capsule_container.dart';
import '../live_page.dart';

/// 推荐区域
class LiveRecommend extends StatelessWidget {
  LiveRecommend({Key? key}) : super(key: key);
  final LiveController _controller = Get.find<LiveController>();

  @override
  Widget build(BuildContext context) {
    const SizedBox spaceBox = SizedBox(width: AppDimens.h_5);
    var customTheme = _controller.currentCustomThemeData();
    return Padding(
      padding: const EdgeInsets.only(left: AppDimens.w_10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.bottomSheet(
                const ContributionListPage(),
              );
            },
            child: CapsuleContainer(
              child: Row(
                children: [
                  Assets.livePage.contribute.image(
                    width: AppDimens.w_14,
                    height: AppDimens.h_15,
                  ),
                  spaceBox,
                  Text(
                    '贡献榜',
                    style: TextStyle(
                      color: customTheme.colors0xFFFFFF,
                      fontSize: FontDimens.fontSp12,
                    ),
                  ),
                  spaceBox,
                  Assets.livePage.arrowRightWhite.image(
                    width: 4,
                    height: 8,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: _controller.openEndDrawer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: customTheme.colors0x000000_40,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(AppDimens.w_20)),
              ),
              child: Row(
                children: [
                  Assets.livePage.liveRecommend.image(
                    width: AppDimens.w_10,
                    height: AppDimens.w_10,
                  ),
                  spaceBox,
                  Text(
                    '为你推荐',
                    style: TextStyle(
                      color: customTheme.colors0xFFFFFF,
                      fontSize: FontDimens.fontSp12,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
