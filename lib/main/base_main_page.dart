import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lottie/lottie.dart';

import 'base_main_controller.dart';

/// 主页面
abstract class BaseMainPage<T extends BaseMainController> extends GetView<T> {
  const BaseMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomTheme customTheme = controller.currentCustomThemeData();
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: onPageChanged,
              children: controller.getTabItemPages(),
            ),
            bottomNavigationBar: GetX<T>(
              builder: (_) {
                return BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: customTheme.colors0x9F44FF,
                  iconSize: 38,
                  unselectedItemColor: customTheme.colors0xD7D7D7,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  type: BottomNavigationBarType.fixed,
                  items: _buildTabItems(),
                  onTap: onBottomTap,
                  currentIndex: controller.selectIndex.value,
                );
              },
            )));
  }

  List<BottomNavigationBarItem> _buildTabItems() {
    return controller.tabItems
        .map((e) => BottomNavigationBarItem(
              icon: AssetGenImage(e.iconName).image(width: 38, height: 30),
              activeIcon: Lottie.asset(e.selectIconName,
                  repeat: false,
                  reverse: true,
                  animate: true,
                  width: 38,
                  height: 30),
              label: e.name,
            ))
        .toList();
  }

  /// 再按一次退出
  Future<bool> _onWillPop() async {
    // 点击返回键的操作
    if (DateTime.now().difference(controller.lastPopTime) >
        const Duration(seconds: 2)) {
      controller.lastPopTime = DateTime.now();
      OLEasyLoading.showToast('再按一次退出');
      return Future.value(false);
    } else {
      controller.lastPopTime = DateTime.now();
      // 退出app
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(true);
    }
  }

  /// 页面改变的事件
  void onPageChanged(int index) {
    Log.d("onPageChanged:【$index】");
  }

  /// 底部tab切换事件
  void onBottomTap(int index) {
    Log.d("onBottomTap:【$index】");
  }
}
