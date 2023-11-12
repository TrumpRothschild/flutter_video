import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarCenterTitle extends StatelessWidget {

  String title = "";
  final controller;
  double? fontsize;
  FontWeight? fontWeight;

  AppBarCenterTitle (
      {Key? key,
        required this.title,
        required this.controller,
        this.fontsize,
        this.fontWeight}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String navT = videoPageTranslations[title].toString();
    return Text(
        navT.isNotEmpty ? navT : "",
        style: TextStyle(
          color: controller.currentCustomThemeData().colors0x000000,
          fontSize: fontsize != null ? sp(fontsize!) : sp(32),
          fontWeight: fontWeight != null ? fontWeight! : FontWeight.w600
        )
    );
  }
}