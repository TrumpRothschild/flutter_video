import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';
import '../../translations/app_translations.dart';

class OLBlankView extends StatelessWidget {
  String? emptyTip;

  OLBlankView({Key? key, this.emptyTip}) : super(key: key) {
    emptyTip = emptyTip ?? AppTranslation.basePageString("empty_tip");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AssetGenImage(Assets.basePage.blank.path)
              .image(width: AppDimens.w_200, height: AppDimens.h_120),
          const SizedBox(height: AppDimens.h_6),
          Text(
            emptyTip ?? "",
            style: TextStyle(
                fontSize: FontDimens.fontSp12,
                color: AppTheme.lightCustom.colors0x000000_50),
          )
        ],
      ),
    );
  }
}
