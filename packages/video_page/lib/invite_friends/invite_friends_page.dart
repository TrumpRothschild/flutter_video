import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_appbar_title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:url_launcher/url_launcher.dart';

import 'invite_friends_controller.dart';

//全局key-截图key
final GlobalKey boundaryKey = GlobalKey();

class InviteFriendsPage extends GetView<InviteFriendscontroller> {
  const InviteFriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          leading: AppBarBackButton(),
          title: AppBarCenterTitle(
              title: "invate_friends_title", controller: controller),
          actions: [
            InkWell(
              onTap: () async {
                String url = UserManagerCache.shared.getNewOnlineUrl();
                await launchUrl(Uri.parse(url),
                mode: LaunchMode.externalApplication,);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image(
                  image: AssetImage(
                    Assets.rootPage.images.navKf.path,
                  ),
                  width: 30,
                  fit: BoxFit.fitWidth,
                ),
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: RepaintBoundary(
                    key: boundaryKey,
                    child: _getImgWidget(),
                  )),
              SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    height: 30,
                    minWidth: 124,
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: controller.qrUrlStr.value,
                        ),
                      );
                      OLEasyLoading.showToast("复制成功");
                    },
                    child: Container(
                      width: width(130 * 2),
                      height: width(30 * 2),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x9F44FF,
                            width: 0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          controller.basePageString("复制链接"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: controller
                                .currentCustomThemeData()
                                .colors0x9F44FF,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        await RepaintBoundaryUtils().savePhoto();
                      } catch (error) {
                        await OLEasyLoading.showToast("保存失败");
                        log(error.toString());
                      }
                    },
                    child: Container(
                      width: width(130 * 2),
                      height: width(30 * 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        gradient: LinearGradient(
                          colors: [
                            controller.currentCustomThemeData().colors0x6129FF,
                            controller.currentCustomThemeData().colors0xD96CFF,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "保存二维码",
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0xFFFFFF,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _getImgWidget() {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: 279,
            height: 496,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(Assets.minePage.mineInviteFriends.path),
                fit: BoxFit.fill, // 完全填充
              ),
            ),
          ),
          Positioned(
            left: 21,
            bottom: 2,
            child: Obx(
              () => controller.qrUrlStr.value.isEmpty
                  ? const SizedBox(
                      width: 100,
                      height: 100,
                      child: CupertinoActivityIndicator(),
                    )
                  : QrImage(
                      data: controller.qrUrlStr.value,
                      size: 100,
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class RepaintBoundaryUtils {
  //保存到相册
  Future savePhoto() async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    if (Platform.isIOS) {
      Uint8List images = byteData!.buffer.asUint8List();
      final result =
          await ImageGallerySaver.saveImage(images, quality: 60, name: "hello");
      if (result is Map && result['isSuccess'] == true) {
        EasyLoading.showToast("保存成功");
      } else {
        print('error');
        // toast("保存失败");
      }
    } else {
      Uint8List images = byteData!.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(images, quality: 60);
      if (result != null) {
        EasyLoading.showToast("保存成功");
      } else {
        print('error');
        // toast("保存失败");
      }
    }
  }
}
