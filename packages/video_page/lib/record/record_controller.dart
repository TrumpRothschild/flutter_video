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


class RecordController extends GetXBaseController {
  RxString titleString = "home".obs;
  RxInt page = 1.obs;
  RxInt pageSize = 10.obs;

  RxList<Video> likeList = RxList<Video>();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  RxBool isLoading = false.obs;

  RxBool isEdit = false.obs;
  RxBool allChooseFlag = false.obs; /// 是否全选
  RxString keyWord= "".obs;
  RxList videoIds = [].obs;


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

      BaseResponse response = await VideoApis.of.call().videoWatchRecord({
        "pageNum": page.value,
        "pageSize":pageSize.value
      });
      var list = (response.data as List).map((e) => Video.fromJson(e)).toList();
      // for (var element in list) {
      //   element.flag = false;
      // }
      likeList.addAll(list);
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      if (list.length < 10) {
        refreshController.loadNoData();
      }
      isLoading.value = false;
      // this.update(likeList, true);
    } catch (e) {
      log(e.toString());
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

  /// 选择
  chooseItem(Video item) {
    if (item.flag == true) {
      item.flag = false;
      videoIds.remove(item.id);
    } else {
      item.flag = true;
      videoIds.add(item.id);
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
        videoIds.add(element.id);
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
        saveIds.add(video.id.toString());
      }
    }
    BaseResponse response = await VideoApis.of
        .call()
        .deleteVideoWatchRecord({"recordIds": saveIds.join(",")});
    if (response.code == 200) {
      videoIds.clear();
      videoIds.refresh();
      getInit(1);
      OLEasyLoading.showToast("删除成功");
    }
  }
}
