import 'package:base/commons/widgets/ol_vip.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/user/user_level_bean.dart';

class UserCurLevel extends StatelessWidget {
  const UserCurLevel({
    Key? key,
    required this.customTheme,
    required this.userLevelBean,
  }) : super(key: key);

  final UserLevelBean userLevelBean;
  final CustomTheme customTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '当前等级',
          style: TextStyle(
            color: customTheme.colors0xFFFFFF,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        OlVip(userLevelBean.levelWeight.toInt()),
      ],
    );
  }
}
