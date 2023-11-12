import 'package:base/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uni_client/app/video_app_bindings.dart';
import 'package:get/get.dart';

import '../app/video_app_pages.dart';
import '../main/video_main_controller.dart';
import 'my_app_base.dart';

/// 视频入口
class MyAppVideo extends MyAppBase<VideoMainController> {

  final _controller = Get.put(VideoMainController());

  MyAppVideo({Key? key}) : super(key: key);

  @override
  Bindings? getInitialBinding() => VideoAppBindings();

  @override
  List<GetPage>? getPages() => VideoAppPages.routes;

  @override
  ThemeData? getTheme() => AppTheme.currentThemeData(_controller);

  @override
  String getTitle() => '彩狐视频';
}
