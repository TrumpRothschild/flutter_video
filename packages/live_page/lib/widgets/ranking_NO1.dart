import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:live_page/widgets/common_guard.dart';
import 'package:live_page/widgets/common_image.dart';
import 'package:live_page/widgets/common_manager.dart';
import 'package:live_page/widgets/common_nobility_tag.dart';
import 'package:live_page/widgets/common_vip.dart';

class RankingNO1 extends StatelessWidget {
  const RankingNO1({
    Key? key,
    required this.avatar,
    required this.nickname,
    required this.vipLevel,
    this.nicknameColor = Colors.white,
  }) : super(key: key);

  final String avatar;
  final String nickname;
  final int vipLevel;
  final Color nicknameColor;

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
            Assets.livePage.rankingNO1.image(
              width: 95,
              height: 89,
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
        const SizedBox(height: 2),
        if (vipLevel > 0)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonVip(
                vipType: VipType.gold,
                vipLevel: vipLevel,
              ),
              const SizedBox(width: 3),
              const CommonNobilityTag(
                nobilityTagType: NobilityTagType.marquis,
              ),
              const SizedBox(width: 3),
              const CommonGuard(
                guardType: GuardType.gold,
              ),
              const SizedBox(width: 2),
              const CommonManager(),
            ],
          ),
      ],
    );
  }
}