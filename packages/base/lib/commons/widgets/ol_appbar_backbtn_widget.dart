import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef BackFounction();

class AppBarBackButton extends StatelessWidget {
  BackFounction? backFounction;

  AppBarBackButton({Key? key, this.backFounction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.back();
        if (backFounction != null) {
          backFounction!();
        }
      },
      icon: Image.asset(
        Assets.basePage.backBlack.path,
        width: AppDimens.w_8,
        height: AppDimens.h_15,
      ),
    );
  }
}
