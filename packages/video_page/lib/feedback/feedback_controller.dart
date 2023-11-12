// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer';

import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';


class FeedBackController extends GetXBaseController {
  getx.RxString titleString = "home".obs;
  getx.RxList<String> list = [videoPageTranslations['cannot_play'].toString(),
    videoPageTranslations['the_film_is_playing'].toString(),
   // videoPageTranslations['the_charging_video_cannot_be_viewed'].toString(),
    //videoPageTranslations['unable_to_download_to_album'].toString(),
    videoPageTranslations['cache_problems'].toString(),
    videoPageTranslations['film_request_content_suggestion'].toString(),
    videoPageTranslations['no_subtitles_or_sound'].toString(),
    videoPageTranslations['other'].toString()
  ].obs;
  getx.RxInt questionType = 0.obs;
  getx.RxString description = "".obs;
  getx.RxList images = [].obs;
  getx.RxString urlPath = "".obs;

  final titleCtr = TextEditingController();
  final FocusNode titleFocus = FocusNode();

  var videoId = "";
  var videoTitle= "";
  var feedbackType = "2";
  //
  // "videoId": "",
  // "videoTitle": ""
  //

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      feedbackType = Get.arguments['feedbackType'] as String? ?? "2";
      videoId = Get.arguments['videoId'] as String? ?? "" ;
      videoTitle = Get.arguments['videoTitle'] as String? ?? "" ;
    }


  }

  @override
  void onReady() {
    // 调用
  }
  /// 选择分类
  changeType(int index) {
    questionType.value = index;
    update();
  }

  /// 详情
  setTitle(String content) {
    description.value = content;
    update();
  }

  /// 上传相册图片
  getImage() async {
    if (images.length<6) {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      urlPath.value = pickedFile != null ? pickedFile.path.toString() : "";
      if (pickedFile != null) {
        upload(pickedFile);
        OLEasyLoading.showToast(videoPageTranslations['uploading'].toString());
      }
    } else {
      OLEasyLoading.showToast(videoPageTranslations['max_upload'].toString());
    }

  }

  upload(image) async {
    // getx.Get.back();
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formdata = FormData.fromMap(
        {"file": await MultipartFile.fromFile(path, filename: name)});
    print(formdata);

    try {
      BaseResponse response = await VideoApis.of.call().uploadPicture(formdata);
      log('火星黑洞');
      log(response.data.toString());
      log('火星黑洞');
      if (response.code == 200) {
        images.add(response.data['filekeyurl']);
        update();
        OLEasyLoading.showToast(videoPageTranslations['upload_success'].toString());
      } else {
        OLEasyLoading.dismiss();
        OLEasyLoading.showToast(response.msg.toString());
      }
    } catch (e) {
      log(e.toString());
      OLEasyLoading.dismiss();
    }
  }

  /// 删除已提交图片
  delImg(int index) {
    images.removeAt(index);
    update();
  }

  /// 提交
  submit() async {
    if (description.value.isEmpty) {
      OLEasyLoading.showToast(videoPageTranslations['please_fill_in_the_detailed_description'].toString());
    } else {

      var params = {
        "description":description.value,
        "questionype": questionType.value + 1 ,
        "images":images.isNotEmpty?images.join(','):''
      };
      if (feedbackType.isNotEmpty) {
        params["feedbackType"] = feedbackType;
      }

      if (videoId.isNotEmpty) {
        params["videoId"] = videoId;
      }

      if (videoTitle.isNotEmpty) {
        params["videoTitle"] = videoTitle;
      }

      try {
        BaseResponse response = await VideoApis.of.call().videoFeedback(params);
        log('火星黑洞');
        log(response.data.toString());
        if (response.code == 200) {
          OLEasyLoading.showToast(videoPageTranslations['submit_successfully'].toString());
          titleCtr.text = "";
          description.value = "";
          getx.Get.back();
        } else {
          OLEasyLoading.showToast(response.msg.toString());
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

}
