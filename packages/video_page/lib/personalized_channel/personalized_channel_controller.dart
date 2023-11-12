// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer';
import 'package:base/app_event_bus.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/api/apis.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/video/video_category_model.dart';
import 'package:base/caches/ol_cache_manager.dart';
import 'package:services/models/event/video_personalized_event.dart';


class PersonalizedChannelController extends GetXBaseController {
  RxString titleString = "home".obs;

  List<String> tabs = ['AV 中字', '欧美', '狼友上传', '性爱知识', '性爱知识', '性爱知识'];
  RxMap tabMap = {0:'AV 中字',27: "欧美", 32: "狼友上传", 14: "性爱知识", 34:"性爱知识", 26:"性爱知识"}.obs;
  RxInt currentIndex = 0.obs;
  RxList<VideoCategoryModel> tabList = RxList<VideoCategoryModel>();
  RxList<VideoCategoryModel> allList = RxList<VideoCategoryModel>();
  int useOldIndex = 0;
  int useNewIndex = 0;
  int currentUseCount = 0;
  RxInt editStates = 0.obs; //  是否编辑状态
  RxList<VideoCategoryModel> savTagList = RxList<VideoCategoryModel>();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getDatas();
  }

  @override
  void onClose() {
    log("PersonalizedChannelController销毁了");
  }

  changeActionState() {

  }

  getDatas() async {
    Future.wait([getInit(),getAll()]).then((value) {
      log("test合并接口");
      for (var i = 0; i < allList.length; i++) {
        var model = allList[i];
        var categoryList = model.categoryList as List;
        for (var j = 0; j < tabList.length; j++) {
          var nModel = tabList[j];
          if (model.id == nModel.id) {
            model.isSelect = nModel.isSelect;
          }
          for (var k = 0; k < categoryList.length; k++) {
            CategoryList kModel = categoryList[k];
            if (nModel.id == kModel.id) {
              kModel.isSelect = nModel.isSelect;
            }
            categoryList[k] = kModel;
            model.categoryList = categoryList.cast<CategoryList>();
            allList[i] = model;
          }
        }
      }
      update();
    }).catchError((error) {

    });
  }

  // 返回的时候缓存数据
  void savePersonData() {
    // 把数据缓存起来
    List saveList = [];
    for (var model in tabList) {
      Map map = model.toJson();
      saveList.add(map);
    }
    if (saveList.length > 0) {
      Map<String, dynamic> newMap = {"videoCategoryList": saveList};
      OLCacheManager.shared.putData("${Apis.videoCategoryList}", newMap);
      // 发送通知
      eventBus.fire(VideoPersonalizedEvent());
    }
  }

  // 选择下面头部tab
  void selectItem(VideoCategoryModel model) {
    if (editStates == 0) {
      return;
    }
    if (judgeCanSelect(model.isSelect ?? false) == false) {
      return;
    }
    for (var i = 0; i < allList.length; i++) {
      var m = allList[i];
      if (model.id == m.id) {
        if (model.isSelect == true) {
          model.isSelect = false;
        } else {
          model.isSelect = true;
        }
        allList[i] = model;
        break;
      }
    }
    if (model.isSelect == true) {
      bool isHave = false;
      int tag = 0;
      for (var i = 0; i < tabList.length; i++) {
        VideoCategoryModel tmodel = tabList[i];
        if (model.id == tmodel.id) {
          isHave = true;
          tag = i;
          break;
        }
      }
      if (isHave == true) {
        tabList[tag] = model;
      } else {
        tabList.insert(0, model);
      }
    } else {
      for (var j = 0; j < tabList.length; j++) {
        var nModel = tabList[j];
        if (model.id == nModel.id) {
          nModel.isSelect = false;
          tabList.removeAt(j);
          break;
        }
      }
    }
    getCurrentUseCount();
    update();
  }

  // 选择下面子tab
  void selectSubItem (CategoryList model) {
    if (editStates == 0) {
      return;
    }
    if (judgeCanSelect(model.isSelect ?? false) == false) {
      return;
    }
    for (var i = 0; i < allList.length; i++) {
      var m = allList[i];
      var list = m.categoryList as List;
      for (var k = 0; k < list.length; k++) {
        CategoryList kModel = list[k];
        if (model.id == kModel.id) {
          if (kModel.isSelect == true) {
            kModel.isSelect = false;
          } else {
            kModel.isSelect = true;
          }
          list[k] = kModel;
          m.categoryList = list.cast<CategoryList>();
          allList[i] = m;
          break;
        }
      }
    }
    if (model.isSelect == true) {
      // 先判断当前集合是否存在
      bool isHave = false;
      int tag = 0;
      for (var i = 0; i < tabList.length; i++) {
        VideoCategoryModel tmodel = tabList[i];
        if (model.id == tmodel.id) {
          isHave = true;
          tag = i;
          break;
        }
      }
      VideoCategoryModel sModel = VideoCategoryModel();
      sModel.id = model.id;
      sModel.categoryName = model.categoryName;
      if (isHave == true) {
        sModel.isSelect = true;
        tabList[tag] = sModel;
      } else {
        sModel.isSelect = true;
        tabList.insert(0, sModel);
      }
    } else {
      for (var j = 0; j < tabList.length; j++) {
        var nModel = tabList[j];
        if (model.id == nModel.id) {
          nModel.isSelect = false;
          tabList.removeAt(j);
          break;
        }
      }
    }
    getCurrentUseCount();
    update();
  }

  // 当前选中tab
  void selectTabListItem(VideoCategoryModel model) {
    if (editStates == 0) {
      return;
    }
    if (model.isSelect == true) {
      model.isSelect = false;
    } else {
      model.isSelect = true;
    }
    for (var i = 0; i < allList.length; i++) {
      var m = allList[i];
      if (model.id == m.id) {
        m.isSelect = model.isSelect;
        allList[i] = m;
        break;
      }
      var list = m.categoryList as List;
      for (var k = 0; k < list.length; k++) {
        CategoryList kModel = list[k];
        if (kModel.id == model.id) {
          kModel.isSelect = model.isSelect;
          list[k] = kModel;
          m.categoryList = list.cast<CategoryList>();
          allList[i] = m;
          break;
        }
      }
    }
    // 当前使用选中效果
    for (var j = 0; j < tabList.length; j++) {
      VideoCategoryModel nmodel = tabList[j];
      if (model.id == nmodel.id) {
        if (model.isSelect == true) {
          tabList[j] = model;
        } else {
          tabList.remove(nmodel);
        }
        break;
      }
    }
    getCurrentUseCount();
    update();
  }

  // 获取当前使用选中数量
  void getCurrentUseCount() {
    int icount = 0;
    for (var j = 0; j < tabList.length; j++) {
      VideoCategoryModel nmodel = tabList[j];
      if (nmodel.isSelect == true) {
        icount++;
      }
    }
    currentUseCount = icount;
  }

  bool judgeCanSelect(bool isSelect) {
    if (isSelect == false && tabList.length >= 9) {
      OLEasyLoading.showToast(basePageString("最多只能添加9个"));
      return false;
    }
    if (tabList.length > 9 && isSelect == true) {
      OLEasyLoading.showToast(basePageString("最多只能添加9个"));
      return false;
    }
    return true;
  }

  // 导航左右选中tag
  changeIndex(VideoCategoryModel model){
    currentIndex.value = model.id as int;
    for (var sModel in savTagList) {
      if (model.id == sModel.id) {
        allList.remove(sModel);
        break;
      }
    }
    allList.insert(0, model);
    update();
  }

  // 当前选择的接口
  Future<RxList<VideoCategoryModel>> getInit() async {
    Map<String, dynamic> data = await getVideoCategoryList();
    if (data.isNotEmpty) {
      tabList.clear();
      final dataList = data["videoCategoryList"];
      for (var map in dataList) {
        VideoCategoryModel m = VideoCategoryModel.fromJson(map);
        m.isSelect = true;
        tabList.add(m);
      }
      return Future.value(tabList);
    }
    try {
      tabList.clear();
      BaseResponse response = await VideoApis.of.call().videoCategoryList();
      log('火星黑洞');
      var list = (response.data as List).map((e) => VideoCategoryModel.fromJson(e)).toList();
      for (var i = 0; i < 9; i++) {
        VideoCategoryModel model = list[i];
        model.isSelect = true;
        tabList.add(model);
      }
    } catch (e) {
      log(e.toString());
    }
    return Future.value(tabList);
  }

  // 编辑按钮
  void editActionItem() {
    if (editStates == 0) {
      editStates.value = 1;
      update();
    } else {
      if (tabList.length > 0) {
        savePersonData();
        OLEasyLoading.showToast("保存成功");
        editStates.value = 0;
        Get.back();
      } else {
        OLEasyLoading.showToast("至少保留一个");
      }
    }
  }
  
  void draggableItem() {
    VideoCategoryModel oldModel = tabList[useOldIndex];
    VideoCategoryModel newModel = tabList[useNewIndex];
    if (useOldIndex > useNewIndex) {
      // tabList.remove(oldModel);
      // tabList.insert(useNewIndex, oldModel);
    } else {

    }
  }

  // 获取所有分类接口
  Future<Map<String, dynamic>> getVideoCategoryList() async {
    final data = await OLCacheManager.shared.getData("${Apis.videoCategoryList}");
    return data;
  }

  Future<RxList<VideoCategoryModel>> getAll() async {
    try {
      allList.clear();
      BaseResponse response = await VideoApis.of.call().videoCategoryListGroup();
      log('火星黑洞2');
      log(response.data.toString());
      var list = (response.data as List).map((e) => VideoCategoryModel.fromJson(e)).toList();
      allList.addAll(list);
      if (allList.isNotEmpty) {
        currentIndex.value = allList[0].id!;
      }
      savTagList.addAll(list);
    } catch (e) {
      log(e.toString());
    }
    return Future.value(allList);
  }
}
