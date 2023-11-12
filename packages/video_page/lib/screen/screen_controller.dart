// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer';

import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/video/tag_model.dart';
import 'package:services/models/res/video/video_page_list_model.dart';

class ScreenController extends GetXBaseController {
  RxString titleString = "home".obs;
  RxList<String> regionList = ["大陆", "日本", "韩国", "欧美", "台湾", "港澳"].obs;
  RxInt region = 0.obs;
  RxList<String> sortTypeList = ["标准", "最多播放", "最多评论", "时间", "热度"].obs;
  RxList<String> priceTypeList = ["免费", "收费"].obs;
  RxInt priceType = 0.obs;
  RxList<String> contentTypeList = ["AV", "三级", "动漫", "自拍"].obs;
  RxList<String> mosaicFlagList = ["无码", "有码"].obs;
  RxInt mosaicFlag = 0.obs;
  RxList<String> subtitleFlagList = ["无中字", "中字"].obs;
  RxInt subtitleFlag = 0.obs;
  RxList<String> durationTypeList =
      ["0-10分钟", "11-30分钟", "31-60分钟", "61-180分钟", "大于180分钟"].obs;
  RxInt durationType = 0.obs;
  RxBool buttonShow = false.obs;

  RxList<TagSubModel> tagList = RxList<TagSubModel>();
  List<TagSubModel> selectTagList = [];
  RxList<TagSubModel> tagList1 = RxList<TagSubModel>();
  RxList<TagSubModel> tagList2 = RxList<TagSubModel>();
  RxList<TagSubModel> tagList3 = RxList<TagSubModel>();

  /// 已经选择的tagid

  RxList<Video> videoList = RxList<Video>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;

  late ScrollController _scrollController;
  get scrollController => _scrollController;

  @override
  void onInit() {
    _scrollController = ScrollController();
    _scrollController.addListener(isScroll);
    super.onInit();
  }

  @override
  void onClose() {
    _scrollController.removeListener(isScroll);
  }

  @override
  void onReady() {
    // 调用
    getInit();
    getVideo(1);
  }

  getVideo(int pageNum) async {
    try {
      isLoading.value = true;
      page.value = pageNum;
      if (pageNum == 1) {
        videoList.clear();
      }

      var params = {};

      var selectTagStr = "";
      if (selectTagList.length > 0) {
        List<String> saveList = [];
        for (TagSubModel model in selectTagList) {
          saveList.add(model.name ?? "");
        }
        selectTagStr = saveList.join(",");
      }

      /// 根据服务端要求没有的参数或者全部传0
      int mosaicFlags = mosaicFlag.value;
      if (mosaicFlag.value == 0) {
        mosaicFlags = -1;
      } else if (mosaicFlag.value == 1) {
        mosaicFlags = 0;
      } else {
        mosaicFlags = 1;
      }
      int subtitleFlags = subtitleFlag.value;
      if (subtitleFlag.value == 0) {
        subtitleFlags = -1;
      } else if (subtitleFlag.value == 1) {
        subtitleFlags = 0;
      } else {
        subtitleFlags = 1;
      }
      params = {
        "durationType": durationType.value,
        "keyWord": selectTagStr,
        "pageNum": page.value,
        "pageSize": 20,
        "priceType": priceType.value,
        "contentType": "0",
        "mosaicFlag": mosaicFlags,
        "region": region.value,
        "subtitleFlag" : subtitleFlags,
        "tagList": "",
        "sortType": "0",
      };

      Log.e("params:${params}");
      BaseResponse response = await VideoApis.of.call().videoSearch(params);
      var list = (response.data as List).map((e) => Video.fromJson(e)).toList();
      for (var element in list) {
        element.flag = false;
      }
      videoList.addAll(list);
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      if (list.length < 10) {
        refreshController.loadNoData();
      }
      videoList.refresh();
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }

  getInit() async {
    try {
      BaseResponse response = await VideoApis.of.call().videofilterList();
      var list =
          (response.data as List).map((e) => TagNewModel.fromJson(e)).toList();
      List<TagSubModel> saveList = [];
      for (var model in list) {
        if (model.tagList?.isNotEmpty ?? false) {
          saveList.addAll(model.tagList!);
        }
      }
      tagList.value = saveList;
      // 进行3行显示，小于3个显示为1行
      int totalCount = saveList.length;
      if (totalCount < 3) {
        tagList1.value = saveList;
      } else {
        int oneRowCount = (totalCount / 3).truncate();
        int twoRowCount = (totalCount / 3).truncate();
        int threeRowCount = (totalCount / 3).truncate();
        if (totalCount % 3 == 1) {
          oneRowCount = (totalCount / 3).truncate() + 1;
        } else if (totalCount % 3 == 2) {
          threeRowCount = (totalCount / 3).truncate() + 1;
          twoRowCount = (totalCount / 3).truncate() + 1;
        }
        List<TagSubModel> saveList1 = [];
        for (var i = 0; i < oneRowCount; i++) {
          TagSubModel model = saveList[i];
          saveList1.add(model);
        }
        tagList1.value = saveList1;
        List<TagSubModel> saveList2 = [];
        for (var i = oneRowCount; i < oneRowCount + twoRowCount; i++) {
          TagSubModel model = saveList[i];
          saveList2.add(model);
        }
        tagList2.value = saveList2;
        List<TagSubModel> saveList3 = [];
        for (var i = oneRowCount + twoRowCount;
            i < oneRowCount + twoRowCount + threeRowCount;
            i++) {
          TagSubModel model = saveList[i];
          saveList3.add(model);
        }
        tagList3.value = saveList3;
      }
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  chooseTag(TagSubModel model) {
    if (model.isSelected == false) {
      if (selectTagList.length < 5) {
        model.isSelected = true;
        selectTagList.add(model);
      } else {
        OLEasyLoading.showToast(
            videoPageTranslations['sliding_up_to_5_can_be_selected']
                .toString());
      }
    } else {
      model.isSelected = false;
      for (var i = 0; i < selectTagList.length; i++) {
        TagSubModel subModel = selectTagList[i];
        if (model.name == subModel.name) {
          selectTagList.remove(subModel);
          break;
        }
      }
    }
    // 更新显示数据
    for (var i = 0; i < tagList.length; i++) {
      TagSubModel subModel = tagList[i];
      if (model.name == subModel.name) {
        tagList[i] = model;
        break;
      }
    }
    getVideo(1);
  }

  isScroll() {
    log((_scrollController.offset > 10).toString());
    if (_scrollController.offset > 10) {
      buttonShow.value = true;
    } else {
      buttonShow.value = false;
    }
  }

  scrollToTop(context) {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  changeRegin(int index) {
    region.value = index + 1;
    update();
    getVideo(1);
  }

  changeMosaic(int index) {
    mosaicFlag.value = index;
    update();
    getVideo(1);
  }

  changeSubtitle(int index) {
    subtitleFlag.value = index;
    update();
    getVideo(1);
  }

  changeDuration(int index) {
    durationType.value = index + 1;
    update();
    getVideo(1);
  }

  changePriceType(int index) {
    priceType.value = index + 1;
    update();
    getVideo(1);
  }
}
