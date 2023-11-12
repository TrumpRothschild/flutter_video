import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/capsule_container.dart';
import '../../widgets/common_image.dart';
import '../live_page.dart';

/// 直播间头部
class LiveHeader extends StatelessWidget {
  LiveHeader({Key? key}) : super(key: key);
  final LiveController _controller = Get.find<LiveController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10).copyWith(bottom: AppDimens.h_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getAnchorInfo(),
          Expanded(
            child: _onlineUsers(),
          )
        ],
      ),
    );
  }

  /// 主播信息组件
  Widget _getAnchorInfo() {
    // 主播信息
    var anchorVO = _controller.roomDetailData.value?.liveAnchorVO;
    return InkWell(
      onTap: () {
        // 获取主播信息
        _controller.getUserDetailInfo(anchorVO?.userId,
            studioNum: _controller.studioNum);
      },
      child: CapsuleContainer(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            ClipOval(
              child: CommonImage(
                width: AppDimens.w_33,
                height: AppDimens.w_33,
                imageUrl: anchorVO?.avatar ?? '',
              ),
            ),
            const SizedBox(width: AppDimens.w_4),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anchorVO?.nickName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _controller.currentCustomThemeData().colors0xFFFFFF,
                    fontSize: FontDimens.fontSp14,
                  ),
                ),
                Text(
                  "ID:${anchorVO?.accno ?? ''}",
                  maxLines: 1,
                  style: TextStyle(
                    color:
                        _controller.currentCustomThemeData().colors0xFFFFFF_50,
                    fontSize: FontDimens.fontSp11,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppDimens.w_2),
            Obx(() {
              return InkWell(
                onTap: () {
                  _controller.toggleFocus(
                      focus: _controller.isFocusAnchor.value,
                      uid: anchorVO?.userId,
                      isAnchor: true);
                },
                child: _controller.isFocusAnchor.value
                    ? Assets.livePage.followed.image(
                        width: AppDimens.w_25,
                        height: AppDimens.w_25,
                      )
                    : Assets.livePage.follow.image(
                        width: AppDimens.w_25,
                        height: AppDimens.w_25,
                      ),
              );
            }),
            const SizedBox(width: AppDimens.w_4)
          ],
        ),
      ),
    );
  }

  Widget _onlineUsers() {
    var onlineUserData = _controller.onlineUserData;
    var onlineUserWidget = List.generate(
      onlineUserData.length,
      (index) {
        return InkWell(
          onTap: () {
            // 获取用户信息
            _controller.getUserDetailInfo(onlineUserData[index].userId,
                flag: 1);
          },
          child: Transform.translate(
              offset: Offset(
                index == 0 ? 0 : -5.0 * index,
                0,
              ),
              child: ClipOval(
                child: CommonImage(
                  width: AppDimens.w_30,
                  height: AppDimens.w_30,
                  imageUrl: onlineUserData[index].avatar,
                ),
              )),
        );
      },
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: Offset((onlineUserData.length - 1) * 5, 0),
          child: Row(
            children: onlineUserWidget,
          ),
        ),
        const SizedBox(width: AppDimens.w_5),
        InkWell(
          onTap: () {
            // 获取在线用户列表
            _controller.getTop50UserList();
          },
          child: Container(
            decoration: BoxDecoration(
              color: _controller.currentCustomThemeData().colors0x000000_40,
              shape: BoxShape.circle,
            ),
            width: AppDimens.w_30,
            height: AppDimens.w_30,
            alignment: Alignment.center,
            child: Text(
              _getOnlineNumStr(_controller.onlineNum.value),
              style: TextStyle(
                color: _controller.currentCustomThemeData().colors0xFFFFFF,
                fontSize: FontDimens.fontSp12,
              ),
            ),
          ),
        )
      ],
    );
  }

  /// 在线用户数
  String _getOnlineNumStr(num onlineNum) {
    return onlineNum > 100 ? "99+" : onlineNum.toString();
  }
}
