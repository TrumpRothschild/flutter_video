import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_sex.dart';
import 'package:base/commons/widgets/ol_vip.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/live/live_user_detail_bean.dart';
import '../../widgets/common_image.dart';
import '../live_page.dart';

/// 直播间用户信息弹框
class LiveUserInfo extends StatelessWidget {
  final LiveController _controller = Get.find<LiveController>();

  final LiveUserDetailBean userDetail;

  /// 是否主播
  final bool isAnchor;

  LiveUserInfo(this.userDetail, {Key? key, this.isAnchor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorB1B1B1 = _controller.currentCustomThemeData().colors0xB1B1B1;
    return Obx(() => Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppDimens.w_10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 举报
                  InkWell(
                    onTap: () {
                      Get.back();
                      _controller.getLiveReportReason();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppDimens.w_10, top: AppDimens.h_10),
                      child: Text(
                        '举报',
                        style: TextStyle(
                          color: colorB1B1B1,
                          fontSize: FontDimens.fontSp12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimens.h_4),
                  // 昵称
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userDetail.nickName ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: FontDimens.fontSp18,
                        ),
                      ),
                      const SizedBox(width: AppDimens.w_5),
                      OlSex((userDetail.sex ?? 0).toInt())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '会员ID：${userDetail.accno ?? ""}',
                        style: TextStyle(
                          color: colorB1B1B1,
                          fontSize: FontDimens.fontSp12,
                        ),
                      ),
                      const SizedBox(width: AppDimens.w_5),
                      Icon(
                        Icons.location_on_outlined,
                        color: colorB1B1B1,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        userDetail.registerArea ?? "火星",
                        style: TextStyle(
                          color: colorB1B1B1,
                          fontSize: FontDimens.fontSp12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.h_8),
                  Center(
                    child: OlVip((userDetail.level ?? 0).toInt()),
                  ),
                  const SizedBox(height: AppDimens.h_18),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.w_20),
                      child: Text(
                        userDetail.personalSignature ?? "主播好像忘记说什么了",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colorB1B1B1,
                          fontSize: FontDimens.fontSp14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimens.h_38),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _followedWidget(
                          title: "关注",
                          count: (userDetail.focusNum ?? 0).toInt()),
                      _followedWidget(
                          title: "粉丝", count: (userDetail.fansNum ?? 0).toInt())
                    ],
                  ),
                  const SizedBox(height: AppDimens.h_18),
                  Divider(
                    color: _controller.currentCustomThemeData().colors0xD9D9D9,
                    height: AppDimens.h_1,
                  ),

                  _footerWidget(userDetail)
                ],
              ),
            ),
            // 用户头像
            Positioned(
                top: -25,
                child: ClipOval(
                  child: CommonImage(
                    width: AppDimens.w_50,
                    height: AppDimens.w_50,
                    imageUrl: userDetail.avatar ?? '',
                  ),
                )),
          ],
        ));
  }

  /// 关注/粉丝
  Widget _followedWidget({required String title, required int count}) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(
            color: Colors.black,
            fontSize: FontDimens.fontSp18,
          ),
        ),
        const SizedBox(height: AppDimens.h_3),
        Text(
          title,
          style: TextStyle(
            color: _controller.currentCustomThemeData().colors0xB1B1B1,
            fontSize: FontDimens.fontSp12,
          ),
        ),
      ],
    );
  }

  Widget _footerWidget(LiveUserDetailBean detailBean) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.h_20),
      child: isAnchor
          ? Row(
              children: [
                // 主页
                Expanded(child: _getUserHomePage()),
                ColoredBox(
                  color: _controller.currentCustomThemeData().colors0xD9D9D9,
                  child: const SizedBox(
                    width: AppDimens.w_1,
                    height: AppDimens.h_16,
                  ),
                ),
                //  关注/已关注
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _controller.toggleFocus(
                          focus: _controller.isFocusAnchor.value,
                          uid: int.parse((userDetail.userId ?? "0")),
                          isAnchor: isAnchor);
                    },
                    child: Center(
                        child: Text(
                      _controller.isFocusAnchor.value ? '已关注' : '+关注',
                      style: TextStyle(
                        color:
                            _controller.currentCustomThemeData().colors0x9F44FF,
                        fontSize: FontDimens.fontSp18,
                      ),
                    )),
                  ),
                )
              ],
            )
          : _getUserHomePage(),
    );
  }

  /// 用户主页
  Widget _getUserHomePage() {
    return InkWell(
      onTap: () {
        OLEasyLoading.showToast('主播主页');
      },
      child: const Center(
        child: Text(
          '主页',
          style: TextStyle(
            color: Colors.black,
            fontSize: FontDimens.fontSp18,
          ),
        ),
      ),
    );
  }
}
