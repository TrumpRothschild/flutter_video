import 'dart:developer';
import 'package:base/app_config.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:services/models/res/login/image_code_model.dart';
import 'image_code_controller.dart';

/// 图片验证码
class ImageCodePage extends GetView<ImageCodeController> {
  void Function(ImageCodeModel?) submit;

  ImageCodePage({Key? key, required this.submit}) : super(key: key);

  final TextEditingController code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(ImageCodeController());
    return Center(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDimens.w_30,vertical: AppDimens.h_13),
            decoration: BoxDecoration(
              color: controller.currentCustomThemeData().colors0xFFFFFF,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: controller.currentCustomThemeData().colors0x9F44FF,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(6)),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "请输入下面的图形验证码",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: controller.currentCustomThemeData().colors0x000000,
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Obx(() {
                  if (controller.imageCodeData.value.img64Code?.isEmpty ??
                      true) {
                    return const SizedBox(
                      height: 35,
                    );
                  } else {
                    return InkWell(
                      onTap: controller.randCode,
                      child: Image.memory(
                        controller.imageCodeData.value.imageUrl(),
                        gaplessPlayback: true,
                        height: 35,
                      ),
                    );
                  }
                }),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 180,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimens.w_5),
                    border: Border.all(
                      color: controller.currentCustomThemeData().colors0xD9D9D9,
                      width: 0.5,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: code,
                      cursorColor: controller.currentCustomThemeData().colors0x9F44FF,
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0x000000,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      keyboardType: TextInputType.text,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))],
                      decoration: InputDecoration(
                        isCollapsed: true,
                        // labelText: "手机号",
                        border: InputBorder.none,
                        // 去掉下滑线
                        counterText: '',
                        // 去除输入框底部的字符计数

                        hintText: controller.basePageString("请输入图形码"),
                        hintStyle: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xD1D1D1,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        // prefix: prefix,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  height: 33,
                  minWidth: 150,
                  onPressed: () {
                    if (code.text.length != 4) {
                      OLEasyLoading.showToast(
                          controller.basePageString("请输入正确的验证码"));
                      return;
                    } else {
                      var imageCodeData = controller.imageCodeData.value;
                      imageCodeData.imgCode = code.text;
                      submit(imageCodeData);
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      color: controller.currentCustomThemeData().colors0x9F44FF,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Center(
                      child: Text(
                        controller.basePageString("确认"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: controller
                              .currentCustomThemeData()
                              .colors0xFFFFFF,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: AppDimens.w_16,
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              minWidth: 0,
              height: 28,
              onPressed: () {
                log("点击关闭");
                Get.back();
              },
              child: Image.asset(
                Assets.basePage.whileX.path,
                width: AppDimens.w_28,
                height: AppDimens.w_28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
