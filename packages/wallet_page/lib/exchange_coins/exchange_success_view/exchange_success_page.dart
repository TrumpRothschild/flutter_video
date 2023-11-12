import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/wallet/diamond_model.dart';
import 'exchange_coins_controller.dart';

class ExchangeSuccessPage extends GetView<ExchangeSuccessController> {
  final DiamondModel exData;
  final int exType;
  final bool isok;
  const ExchangeSuccessPage(this.exData, this.exType, this.isok, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeSuccessController());
    return Center(
      child: Stack(
        children: [
          Container(
            width: 240 + 28,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: controller.currentCustomThemeData().colors0xFFFFFF,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Assets.walletPage.exSuccess.path,
                  width: 113,
                  height: 108,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  isok
                      ? controller.walletPageString("兑换成功")
                      : controller.walletPageString("余额不足"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isok
                        ? controller.currentCustomThemeData().colors0x9F44FF
                        : controller.currentCustomThemeData().colors0x000000,
                  ),
                ),
                isok
                    ? Container()
                    : Text(
                        controller.walletPageString("当前账户余额不足，赶快去充值吧"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: controller
                              .currentCustomThemeData()
                              .colors0xBBBBBB,
                        ),
                      ),
                const SizedBox(
                  height: 19,
                ),
                !isok
                    ? Container()
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  exData.option ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x000000,
                                  ),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  exType == 0
                                      ? controller.walletPageString("兑换金币")
                                      : controller.walletPageString("兑换钻石"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0xBBBBBB,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0x000000_10,
                              ),
                              width: 1,
                              height: 20,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Obx(() {
                                  return Text(
                                    controller.wallet.value?.balance ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  controller.walletPageString("可用余额"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0xBBBBBB,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                const SizedBox(
                  height: 29,
                ),
                row(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  row() {
    return isok ? okRow() : failRow();
  }

  okRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          padding: EdgeInsets.zero,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 27,
          minWidth: 98,
          onPressed: () {
            Get.back();
          },
          child: Container(
            width: 98,
            height: 27,
            decoration: BoxDecoration(
              color: controller.currentCustomThemeData().colors0x9F44FF,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                controller.basePageString("重新兑换"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.currentCustomThemeData().colors0xFFFFFF,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        MaterialButton(
          padding: EdgeInsets.zero,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 27,
          minWidth: 98,
          onPressed: () {
            Get.back();
          },
          child: Container(
            width: 98,
            height: 27,
            decoration: BoxDecoration(
              border: Border.all(
                  color: controller.currentCustomThemeData().colors0x9F44FF,
                  width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                controller.basePageString("完成"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.currentCustomThemeData().colors0x9F44FF,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  failRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          padding: EdgeInsets.zero,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 27,
          minWidth: 98,
          onPressed: () {
            Get.back();
          },
          child: Container(
            width: 98,
            height: 27,
            decoration: BoxDecoration(
              border: Border.all(
                  color: controller.currentCustomThemeData().colors0x9F44FF,
                  width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                controller.basePageString("取消"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.currentCustomThemeData().colors0x9F44FF,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        MaterialButton(
          padding: EdgeInsets.zero,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 27,
          minWidth: 98,
          onPressed: () {
            Log.d("立即充值");
            //Get.offAndToNamed(AppRoutes.walletRoot);
            // 返回到指定页面，这里还需要判断一下，当前帐里是否存在walletRoot，存在则用back，不存在则push
            Get.back();
            Get.back();
          },
          child: Container(
            width: 98,
            height: 27,
            decoration: BoxDecoration(
              color: controller.currentCustomThemeData().colors0x9F44FF,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                controller.basePageString("立即充值"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.currentCustomThemeData().colors0xFFFFFF,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
