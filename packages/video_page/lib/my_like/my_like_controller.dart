// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer';

import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_operate_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/video/video_page_list_model.dart';


class MyLikeController extends GetXBaseController {
  RxString titleString = "home".obs;
  RxBool isEdit = false.obs;
  RxBool allChooseFlag = false.obs; /// 是否全选
  RxString keyWord= "".obs;
  RxInt page = 1.obs;
  RxInt pageSize = 10.obs;
  RxList videoIds = [].obs;
  RxBool isSearchBarEdit = false.obs;

  final titleCtr = TextEditingController();
  final FocusNode titleFocus = FocusNode();

  RxList<Video> likeList = RxList<Video>();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();

    titleFocus.addListener(() {
      if (titleFocus.hasFocus) {
        isSearchBarEdit.value = true;
      } else {
        isSearchBarEdit.value = false;
      }
      update();
    });
  }

  @override
  void onReady() {
    // 调用
    getInit(1);
  }

  /// 关键字搜索
  setTitle(String content) {
    keyWord.value = content;
    update();
  }

  getInit(int pageNum) async {
    try {
      isLoading.value = true;
      page.value = pageNum;
      if (pageNum == 1) {
        likeList.clear();
      }

      BaseResponse response = await VideoApis.of.call().videoCollectList({
        "keyWord":keyWord.value,
        "pageNum": page.value,
        "pageSize":pageSize.value
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

  // 删除
  void deleteItems()  {
    Get.dialog(OperatDialogWidgetAlert(
      controller: this,
      isShowClose: false,
      content: "确认删除吗？",
      callBack: () {
        OLEasyLoading.showLoading("删除中");
        sureDeleteItems();
      },
    ));
  }

  void sureDeleteItems() async {
    List<String> saveIds = [];
    for (var i = 0; i < likeList.length; i++) {
      Video video = likeList[i];
      if (video.flag == true) {
        saveIds.add(video.videoId.toString());
      }
    }
    BaseResponse response = await VideoApis.of
        .call()
        .videoUnCollect({"videoIds": saveIds.join(",")});
    if (response.data) {
      getInit(1);
      videoIds.clear();
      videoIds.refresh();
      OLEasyLoading.showToast("删除成功");
    }
  }
}
