// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer';

import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/video/video_page_list_model.dart';
import 'package:services/models/res/video/video_tag.dart';

class SearchResultPageController extends GetXBaseController {
  RxString titleString = "home".obs;

  RxList<Video> likeList = RxList<Video>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool isLoading = false.obs;
  RxString keyWord = "".obs;
  RxInt page = 1.obs;
  RxInt pageSize = 10.obs;
  RxList videoIds = [].obs;
  RxList<VideoTag> contentTypeList = RxList<VideoTag>();
  RxList<VideoTag> sortList = RxList<VideoTag>();

  final titleCtr = TextEditingController();
  final FocusNode titleFocus = FocusNode();
  RxInt sortType = 1.obs;
  int sortId = 1;
  RxInt contentType = 0.obs;
  RxInt sortType2 = 1.obs;
  RxBool filterFlag = false.obs;
  bool isNeedSelectPar = false; // 是否需要传筛选框参数

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    keyWord.value = Get.arguments?["keyWords"] ?? "";
    titleCtr.text = keyWord.value;
    // 调用
    videoDynamics();
    getInit(1);
  }

  // tab 切换
  setCurrentType(int index) {
    sortType.value = index;
    sortType2.value = 1;
    contentType.value = 0;
    sortId = sortList[0].id ?? 1;
    isNeedSelectPar = false;
    getInit(1);
    update();
  }

  // 筛选中的排序切换
  changeCurrentType(int index) {
    isNeedSelectPar = true;
    contentType.value = index;
    update();
  }

  // 筛选中的排序切换
  changeType(int index) {
    isNeedSelectPar = true;
    sortType2.value = index;
    sortId = index;
    update();
  }

  // 筛选菜单
  changeFlag() {
    filterFlag.value = !filterFlag.value;
    update();
  }

  // 确定
  makeSure() {
    isNeedSelectPar = true;
    filterFlag.value = false;
    getInit(1);
  }

  reset() {
    sortType2.value = 1;
    contentType.value = 0;
    sortId = sortList[0].id ?? 1;
    isNeedSelectPar = true;
    update();
  }

  /// 关键字搜索
  setTitle(String content) {
    keyWord.value = content;
    update();
  }

  // 清空
  clearWord() {
    if (keyWord.value.isNotEmpty) {
      List<String> list = keyWord.value.split(",");
      list.removeLast();
      keyWord.value = list.join(",");
    } else {
      keyWord.value = "";
    }
    titleCtr.text = keyWord.value;
    update();
  }

  // 接口搜索
  getInit(int pageNum) async {
    try {
      isLoading.value = true;
      if (filterFlag.value) {
        filterFlag.value = false;
      }
      page.value = pageNum;
      if (pageNum == 1) {
        likeList.clear();
      }

      var sort = sortId;
      // 这里判断是否是tab选择的参数
      if (isNeedSelectPar == false) {
        sort = sortType.value;
      }

      // 请求参数，这里保持和h5参数一致
      Map<String, dynamic> parmters = {
        /*"durationType": 0,*/
        "keyWord": keyWord.value,
        /*"mosaicFlag": 0,*/
        /*"priceType": 0,*/
        /*"region": 0,*/
        "pageNum": page.value,
        "pageSize": 10,
        "sortType": sort,
      };
      if (isNeedSelectPar && contentType.value != 0) {
        parmters["contentType"] = contentType.value;
      }
      Log.e("parmters: ${parmters}");
      BaseResponse response = await VideoApis.of.call().videoSearch(parmters);
      var list = (response.data as List).map((e) => Video.fromJson(e)).toList();
      likeList.addAll(list);
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      if (list.length < 10) {
        refreshController.loadNoData();
      }
      isLoading.value = false;
      likeList.refresh();
    } catch (e) {
      log(e.toString());
    }
  }

  void videoDynamics() async {
    VideoTags videoTags = await VideoApis.of.call().videoDynamics();
    sortList.value = videoTags.sortTags ?? [];
    contentTypeList.value = videoTags.dynamicTags ?? [];
    sortId = sortList[0].id ?? 1; // 初始化一个值
    sortList.refresh();
    contentTypeList.refresh();
  }
}
