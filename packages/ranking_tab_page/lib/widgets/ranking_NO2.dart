import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

import 'common_guard.dart';
import 'common_image.dart';
import 'common_vip.dart';

class RankingNO2 extends StatelessWidget {
  const RankingNO2({
    Key? key,
    required this.avatar,
    required this.nickname,
    required this.vipLevel,
    required this.diffFirepower,
    this.nicknameColor = Colors.white,
    this.diffFirepowerColor = Colors.white,
  }) : super(key: key);

  final String avatar;
  final String nickname;
  final Color nicknameColor;
  final int vipLevel;
  final int diffFirepower;
  final Color diffFirepowerColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: CommonImage(
                height: 54,
                width: 54,
                imageUrl: avatar,
              ),
            ),
            Assets.livePage.rankingNO2.image(
              width: 95,
              height: 90,
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          nickname,
          style: TextStyle(
            color: nicknameColor,
            fontSize: 12,
          ),
        ),
        if (diffFirepower > 0)
          Text(
            '落后$diffFirepower火力',
            style: TextStyle(
              color: diffFirepowerColor,
              fontSize: 12,
            ),
          ),
        if (vipLevel > 0)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonVip(
                vipType: VipType.silver,
                vipLevel: vipLevel,
              ),
              const SizedBox(width: 3),
              const CommonGuard(
                guardType: GuardType.silver,
              ),
            ],
          ),
      ],
    );
  }
}
