import 'package:base/assets.gen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';

import '../../res/app_dimens.dart';

/// 会员等级组件
class OlVip extends StatelessWidget {
  final int level;

  const OlVip(
    this.level, {
    Key? key,
  }) : super(key: key);

  double get _paddingLeft {
    if (level >= 90) {
      return 30;
    }
    if (level >= 40) {
      return 25;
    }
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    int tmpLevel = level;
    if (tmpLevel <= 0) {
      tmpLevel = 1;
    }
    String vipPath;
    if (tmpLevel >= 280) {
      vipPath = Assets.basePage.icVip13.path;
    } else if (tmpLevel >= 250) {
      vipPath = Assets.basePage.icVip12.path;
    } else if (tmpLevel >= 220) {
      vipPath = Assets.basePage.icVip11.path;
    } else if (tmpLevel >= 190) {
      vipPath = Assets.basePage.icVip10.path;
    } else if (tmpLevel >= 160) {
      vipPath = Assets.basePage.icVip9.path;
    } else if (tmpLevel >= 130) {
      vipPath = Assets.basePage.icVip8.path;
    } else if (tmpLevel >= 110) {
      vipPath = Assets.basePage.icVip7.path;
    } else if (tmpLevel >= 90) {
      vipPath = Assets.basePage.icVip6.path;
    } else if (tmpLevel >= 60) {
      vipPath = Assets.basePage.icVip5.path;
    } else if (tmpLevel >= 40) {
      vipPath = Assets.basePage.icVip4.path;
    } else if (tmpLevel >= 20) {
      vipPath = Assets.basePage.icVip3.path;
    } else if (tmpLevel >= 10) {
      vipPath = Assets.basePage.icVip2.path;
    } else {
      vipPath = Assets.basePage.icVip1.path;
    }
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(minHeight: AppDimens.h_14,minWidth: AppDimens.w_40,maxWidth: AppDimens.w_50),
      padding: EdgeInsets.only(left: _paddingLeft, right: 4, top: 2, bottom: 2),
      child: Text(
        "VIP $tmpLevel",
        style: const TextStyle(
            fontSize: FontDimens.fontSp10,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
      decoration: ShapeDecoration(
          image: DecorationImage(image: AssetImage(vipPath), fit: BoxFit.cover),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.w_20))),
    );
  }
}
