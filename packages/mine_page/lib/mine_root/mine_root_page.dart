import 'dart:developer';

import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_select_actionsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/image/ol_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mine_root_controller.dart';

class MineRootPage extends GetView<MineRootPageController> {
  MineRootPage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get.put(MineRootPageController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(
            () => UnconstrainedBox(
              child: Center(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.mineMsg);
                  },
                  child: Stack(
                    children: [
                      Image.asset(
                        Assets.minePage.sysMsg.path,
                        width: width(40),
                        height: width(40),
                      ),
                      if (controller.hasUnReadMsg.value)
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: ShapeDecoration(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0xFF0000,
                                shape: const CircleBorder(),
                              ),
                            )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.setUp);
            },
            child: UnconstrainedBox(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(right: width(20), left: width(20)),
                  child: Image.asset(
                    Assets.minePage.setting.path,
                    width: width(40),
                    height: width(40),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          itemCount: controller.arryDic.length + 3,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return head();
            } else if (index == 1) {
              return fans();
            } else if (index == 2) {
              return wallet();
            } else {
              return other(index);
            }
          }),
    );
  }

  ///头部
  head() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.editInformation);
          },
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(65 / 2.0),
                  ),
                  color: controller.currentCustomThemeData().colors0x000000,
                ),
                height: 65,
                width: 65,
                child: Obx(
                  () => OLImage(
                    imageUrl: controller.info.value.avatar ?? "",
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(17 / 2.0),
                      ),
                      color: controller.currentCustomThemeData().colors0x9F44FF,
                    ),
                    height: 17,
                    width: 60,
                    child: Text(
                      "编辑资料",
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xFFFFFF,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Text(
                (controller.info.value.nickName?.isEmpty ?? true)
                    ? controller.info.value.userAccount ?? ""
                    : controller.info.value.nickName ?? "",
                style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x333333,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              );
            }),
            Obx(() {
              return Text(
                "会员ID：${controller.info.value.accno ?? ""}",
                style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x808080,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
            Obx(() {
              return Text(
                "等级${controller.info.value.userLevel ?? 0}",
                style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000_80,
                  fontSize: 14,
                ),
              );
            }),
          ],
        ),
        Expanded(child: Container()),
        MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          minWidth: 0,
          onPressed: () {},
          child: Row(
            children: [
              Text(
                "切换视频模式",
                style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000,
                  fontSize: 14,
                ),
              ),
              Image.asset(
                Assets.minePage.mineArrowRight.path,
                width: 12,
                height: 7,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///粉丝
  fans() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 18, 0, 10),
      child: Row(
        children: [
          fansItem(0),
          Container(
            color: controller.currentCustomThemeData().colors0x9F9F9F,
            width: 1,
            height: 16,
          ),
          fansItem(1),
        ],
      ),
    );
  }

  fansItem(int index) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          if (index == 0) {
            Get.toNamed(AppRoutes.mineFocus);
          } else {
            Get.toNamed(AppRoutes.mineFans);
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: Center(child: Obx(() {
                return Text(
                  index == 0
                      ? "${controller.info.value.focusNum ?? 0}"
                      : "${controller.info.value.fansNum ?? 0}",
                  style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x333333,
                    fontSize: 14,
                  ),
                );
              })),
            ),
            SizedBox(
              height: 17,
              child: Center(
                child: Text(
                  index == 0 ? "关注" : "粉丝",
                  style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x535353,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///钱包
  wallet() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Row(
        children: [
          walletItem(0),
          walletItem(1),
          walletItem(2),
          walletItem(3),
        ],
      ),
    );
  }

  walletItem(int index) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () async {
          log(
            controller.arryWalletDic[index]["title"] ?? "",
          );
          if (index == 0) {
            Get.toNamed(AppRoutes.mineWallet);
          } else if (index == 1) {
            Get.toNamed(AppRoutes.withdraw);
          } else if (index == 2) {
            Get.toNamed(AppRoutes.activityCenter);
          } else if (index == 3) {
            String url = UserManagerCache.shared.getNewOnlineUrl();
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          }
        },
        child: Column(
          children: [
            Image.asset(
              controller.arryWalletDic[index]["icon"] ?? "",
              width: 48,
              height: 48,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              controller.arryWalletDic[index]["title"] ?? "",
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0x333333,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  other(int index) {
    return InkWell(
      onTap: () {
        log(
          controller.arryDic[index - 3]["title"] ?? "",
        );
        if ((index - 3) == 0) {
          Get.toNamed(AppRoutes.transactionDetail);
        } else if ((index - 3) == 1) {
          Get.toNamed(AppRoutes.gameRecord);
        } else if ((index - 3) == 2) {
          Get.toNamed(AppRoutes.phoneBind);
        } else if ((index - 3) == 3) {
          Get.toNamed(AppRoutes.myGrade);
        } else if ((index - 3) == 4) {
          Get.bottomSheet(SelectActionSheetWidgetAlert(
            controller: controller,
            callBack: (type) {
              Get.toNamed(AppRoutes.fanGroup);
            },
          ));
        } else if ((index - 3) == 5) {
          Get.toNamed(AppRoutes.setUp);
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
        child: Row(
          children: [
            Image.asset(
              controller.arryDic[index - 3]["icon"] ?? "",
              width: 24,
              height: 24,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              controller.arryDic[index - 3]["title"] ?? "",
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0x333333,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: Obx(() {
                return Text(
                  (controller.info.value.mobilePhone?.isEmpty ?? true) &&
                          (controller.arryDic[index - 3]["title"]
                                  ?.contains("手机") ??
                              false)
                      ? "去认证"
                      : "",
                  style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x9F44FF,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.right,
                );
              }),
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              Assets.minePage.mineArrowRight.path,
              width: 7,
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
