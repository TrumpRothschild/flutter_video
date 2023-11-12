// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer';

import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/video/tag_model.dart';

class SearchTypePageController extends GetXBaseController {
  RxString titleString = "home".obs;

  RxList<TagModel> tagList = RxList<TagModel>();
  RxList<TagModel> savTagList = RxList<TagModel>();
  RxList<TagModel> firstList = RxList<TagModel>();
  RxList<String> tagItemList = RxList<String>();
  RxList selectTag = [].obs;

  RxInt currentKey = 0.obs;

  final TextEditingController searchTextController =
      TextEditingController(text: "");

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // 调用
    getInit();
    getHotData();
  }

  chooseTag(TagSubModel subModel) {
    if (selectTag.toString().contains(subModel.name ?? "")) {
      selectTag.remove(subModel.name);
      if (selectTag.isEmpty) {
        searchTextController.text = "";
      }
    } else {
      if (selectTag.length < 5) {
        selectTag.add(subModel.name);
      } else {
        OLEasyLoading.showToast(
            videoPageTranslations['sliding_up_to_5_can_be_selected']
                .toString());
      }
      selectTag.refresh();
    }
  }

  clearAllSelectTags() {
    selectTag.removeLast();
    if (selectTag.value.length == 0) {
      searchTextController.text = "";
    } else {
      searchTextController.text = selectTag.join(",");
    }
    selectTag.refresh();
    update();
  }

  changeKey(int index) {
    currentKey.value = index;
    TagModel model = savTagList[index];
    for (var sModel in savTagList) {
      if (model.id == sModel.id) {
        tagList.remove(sModel);
      }
    }
    tagList.insert(0, model);
    update();
  }

  getInit() async {
    try {
      BaseResponse response = await VideoApis.of.call().videoTag();
      log('火星黑洞');
      var list =
          (response.data as List).map((e) => TagModel.fromJson(e)).toList();
      tagList.addAll(list);
      savTagList.addAll(list);
      for (var model in tagList) {
        tagItemList.add(model.name ?? "");
      }
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  getHotData() async {
    try {
      BaseResponse response = await VideoApis.of.call().videoHotSearch();
      var model = TagModel.fromJson(response.data);
      firstList.add(model);
    } catch (e) {
      log('jim------');
      log(e.toString());
    }
  }
}
