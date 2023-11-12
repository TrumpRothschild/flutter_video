// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer';

import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/video/video_page_list_model.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';


class OfflineCacheController extends GetXBaseController {
  RxString titleString = "home".obs;
  RxInt currentType = 1.obs;
  RxBool isEdit = false.obs;
  RxBool allChooseFlag = false.obs; /// 是否全选
  RxString keyWord= "".obs;
  RxInt page = 1.obs;
  RxInt pageSize = 10.obs;
  RxList videoIds = [].obs;
  RxBool isSelected = true.obs;


  final titleCtr = TextEditingController();
  final FocusNode titleFocus = FocusNode();

  RxList<Video> likeList = RxList<Video>();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    // 调用
    getInit(1);
  }

  getInit(int pageNum) async {
    try {
      isLoading.value = true;
      page.value = pageNum;
      if (pageNum == 1) {
        likeList.clear();
      }
      BaseResponse response = await VideoApis.of.call().videoCollectList({
        "keyWord": keyWord.value,
        "pageNum": page.value,
        "pageSize": pageSize.value
      });
      log('火星黑洞');
      log(response.data.toString());
      log('火星黑洞');
      var list = (response.data as List).map((e) => Video.fromJson(e)).toList();
      for (var element in list) {
        element.flag = false;
      }
      likeList.addAll(list);
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      if (list.length < 10) {
        refreshController.loadNoData();
      }
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }
  /// 选择
  chooseItem(Video item) {
    if (item.flag == true) {
      item.flag = false;
      videoIds.remove(item.videoId);
    } else {
      item.flag = true;
      videoIds.add(item.videoId);
    }
    likeList.refresh();
  }
  /// 全选
  selectAll() {
    allChooseFlag.value = !allChooseFlag.value;
    videoIds.clear();
    for (var element in likeList) {
      element.flag = allChooseFlag.value;
      if (allChooseFlag.value) {
        videoIds.add(element.videoId);
      }
    }
  }

  changeEdit() {
    isEdit.value = !isEdit.value;
    if (isEdit.value) {
      videoIds.clear();
      for (var element in likeList) {
        element.flag = false;
      }
    }
  }

  changeType(int index) {
    currentType.value = index;
  }
}
