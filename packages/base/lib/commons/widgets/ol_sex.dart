import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/cupertino.dart';

/// 性别组件
class OlSex extends StatelessWidget {
  final int sex;

  final double w = AppDimens.w_20;
  final double h = AppDimens.w_14;

  const OlSex(this.sex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _path;
    if (sex == 1) {
      // 男
      _path = Assets.basePage.icSexMan.path;
    } else if (sex == 2) {
      //女
      _path = Assets.basePage.icSexWoman.path;
    } else {
      // 保密
      _path = Assets.basePage.icSexSecrecy.path;
    }
    return AssetGenImage(_path).image(width: w, height: h);
  }
}
