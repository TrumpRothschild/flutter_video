import 'package:base/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/live_app_pages.dart';
import '../app/live_app_bindings.dart';
import '../main/live_main_controller.dart';
import 'my_app_base.dart';

/// 直播入口
class MyAppLive extends MyAppBase<LiveMainController> {
  final _controller = Get.put(LiveMainController());

  MyAppLive({Key? key}) : super(key: key);

  @override
  Bindings? getInitialBinding() => LiveAppBindings();

  @override
  List<GetPage>? getPages() => LiveAppPages.routes;

  @override
  ThemeData? getTheme() => AppTheme.currentThemeData(_controller);

  @override
  String getTitle() => 'B球直播';
}
