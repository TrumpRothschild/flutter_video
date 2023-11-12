import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/video_app_service.dart';
import 'flavor/my_app_video.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:power_image/power_image.dart';
// import 'app/video/app_bindings_video.dart';
// import 'app/video/app_pages_video.dart';
import 'main/video_main_controller.dart';
// import 'app/video/app_init_video.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:fps_monitor/widget/custom_widget_inspector.dart';

void main() async {
  print("------------------------>PowerImageBinding 1");
  PowerImageBinding();
  print("------------------------>PowerImageBinding 2");
  PowerImageLoader.instance.setup(PowerImageSetupOptions(renderingTypeTexture,
      errorCallbackSamplingRate: null,
      errorCallback: (PowerImageLoadException exception) {}));
  print("------------------------>PowerImageBinding 3");
  WidgetsFlutterBinding.ensureInitialized();
  log("【starting services ...】");
  await Get.putAsync(() => VideoAppService().init());
  log("【All services started ...】");
  runApp(MyAppVideo());
}
