/*
 * @Author: 王长春
 * @Date: 2022-03-14 09:24:34
 * @LastEditors: 王长春
 * @LastEditTime: 2022-03-17 10:01:41
 * @Description: 截图工具，生成截图，保存到相册或者保存本地cash文件夹返回文件路径（供分享使用）
 */

import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RepaintBoundaryUtils {
//生成截图
  /// 截屏图片生成图片流ByteData
  Future<String> captureImage(GlobalKey boundaryKey) async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    var filePath = "";

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    // 获取手机存储（getTemporaryDirectory临时存储路径）
    Directory applicationDir = await getTemporaryDirectory();
    // getApplicationDocumentsDirectory();
    // 判断路径是否存在
    bool isDirExist = await Directory(applicationDir.path).exists();
    if (!isDirExist) Directory(applicationDir.path).create();
    // 直接保存，返回的就是保存后的文件
    File saveFile = await File(
        applicationDir.path + "${DateTime.now().toIso8601String()}.jpg")
        .writeAsBytes(pngBytes);
    filePath = saveFile.path;
    // if (Platform.isAndroid) {
    //   // 如果是Android 的话，直接使用image_gallery_saver就可以了
    //   // 图片byte数据转化unit8
    //   Uint8List images = byteData!.buffer.asUint8List();
    //   // 调用image_gallery_saver的saveImages方法，返回值就是图片保存后的路径
    //   String result = await ImageGallerySaver.saveImage(images);
    //   // 需要去除掉file://开头。生成要使用的file
    //   File saveFile = new File(result.replaceAll("file://", ""));
    //   filePath = saveFile.path;
    //
    //
    // } else if (Platform.isIOS) {
    //   // 图片byte数据转化unit8
    //
    // }

    return filePath;
  }

//申请存本地相册权限
  Future<bool> getPormiation() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.photos,
        ].request();
        // saveImage(globalKey);
      }
      return status.isGranted;
    } else {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
        ].request();
      }
      return status.isGranted;
    }
  }

//保存到相册
  Future savePhoto(GlobalKey boundaryKey) async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;

    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    if (Platform.isIOS) {
      Uint8List images = byteData!.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(images,
          quality: 60, name: "hello");
      EasyLoading.showToast("保存成功");
    } else {
      Uint8List images = byteData!.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(images, quality: 60);
      if (result != null) {
        EasyLoading.showToast("保存成功");
      } else {
        print('error');
        EasyLoading.showToast("保存失败");
      }
    }
  }
}
