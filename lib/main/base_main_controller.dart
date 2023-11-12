import 'dart:async';

import 'package:base/app_event_bus.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:services/models/event/login_event.dart';

abstract class BaseMainController extends GetXBaseController {
  List<TabItem> tabItems = <TabItem>[].obs;

   DateTime lastPopTime = DateTime.now();

  StreamSubscription? _loginSubscription;

  /// 选择的那个tab_bar
  final selectIndex = 0.obs;

  /// PageView controller
  final PageController pageController = PageController();

  @override
  void onInit() {
    mainTabItems();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    _loginSubscription?.cancel();
    super.onClose();
  }

  @override
  void onReady() {
    _subEvent();
    super.onReady();
  }

  ///订阅登录事件
  _subEvent() {
    // 监听登录消息
    _loginSubscription = eventBus.on<LoginEvent>().listen((event) {
      // 重置默认选中
      selectIndex.value = 0;
    });
  }

  /// 主页tabs
  void mainTabItems();

  /// 获取tab对应的页面
  List<Widget> getTabItemPages();
}

/// tab实体对象
class TabItem {
  String name = '';
  String iconName = '';
  String selectIconName = '';
  Color? selectColor; // 选择的文字颜色
  Color? color; // 默认的颜色

  TabItem(this.name, this.iconName, this.selectIconName,
      {this.color, this.selectColor});
}
