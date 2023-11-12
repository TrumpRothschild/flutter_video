import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:live_page/widgets/common_image.dart';

class RankingNO3 extends StatelessWidget {
  const RankingNO3({
    Key? key,
    required this.avatar,
    this.nickname = '',
    this.nicknameColor = Colors.white,
  }) : super(key: key);

  final String avatar;
  final String nickname;
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
            Assets.livePage.rankingNO3.image(
              width: 88,
              height: 87,
            ),
          ],
        ),
        if (nickname.isNotEmpty)
          Text(
            nickname,
            style: TextStyle(
              color: nicknameColor,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
