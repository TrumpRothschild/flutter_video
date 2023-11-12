import 'dart:math';

import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class LevelUpContained extends StatelessWidget {
  const LevelUpContained({
    Key? key,
    required this.customTheme,
  }) : super(key: key);

  final CustomTheme customTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      decoration: BoxDecoration(
        color: customTheme.colors0xFFFFFF,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.minePage.levelUpLine.image(
                width: 78,
                height: 2,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '如何升级',
                  style: TextStyle(
                    color: customTheme.colors0x6B16F4,
                  ),
                ),
              ),
              Transform.rotate(
                angle: pi,
                child: Assets.minePage.levelUpLine.image(
                  width: 78,
                  height: 2,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 38),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLevelUpItem(
                Assets.minePage.levelUpGift.path,
                '送礼',
              ),
              _buildLevelUpItem(
                Assets.minePage.levelUpLive.path,
                '看播',
              ),
              _buildLevelUpItem(
                Assets.minePage.levelUpShare.path,
                '分享',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildLevelUpItem(String path, String title) {
    return Row(
      children: [
        Image.asset(
          path,
          width: 28,
          height: 28,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            color: customTheme.colors0x000000,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
