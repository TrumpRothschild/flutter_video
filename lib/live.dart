import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/live_app_service.dart';
import 'flavor/my_app_live.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  log("【starting services ...】");
  await Get.putAsync(() => LiveAppService().init());
  log("【All services started ...】");
  runApp(MyAppLive());
}
