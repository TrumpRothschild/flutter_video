import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/user/user_level_bean.dart';

class LevelProgress extends StatelessWidget {
  const LevelProgress({
    Key? key,
    required this.customTheme,
    required this.userLevelBean,
  }) : super(key: key);

  final CustomTheme customTheme;
  final UserLevelBean userLevelBean;

  int get _nextLevel {
    if (userLevelBean.levelWeight < 0) {
      return 0;
    }
    if (userLevelBean.isFullLevel) {
      return userLevelBean.levelWeight.toInt();
    }
    return userLevelBean.levelWeight.toInt() + 1;
  }

  double get _progress {
    if (userLevelBean.progress < 0) {
      return 0;
    }
    if (userLevelBean.progress > 1) {
      return 1;
    }
    return userLevelBean.progress.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: _progress,
            color: Colors.white,
            minHeight: 10,
            backgroundColor: Colors.white.withOpacity(0.3),
          ),
        ),
        const SizedBox(height: 6),
        DefaultTextStyle(
          style: TextStyle(
            color: customTheme.colors0xFFFFFF,
            fontSize: 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LV${userLevelBean.levelWeight}',
              ),
              Text(
                '经验值:${userLevelBean.currentExp}/${userLevelBean.needExp}',
              ),
              Text(
                'LV$_nextLevel',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
