import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../widgets/common_image.dart';

class AnchorNO extends StatelessWidget {
  const AnchorNO({
    Key? key,
    required this.avatar,
    required this.nickname,
    required this.followed,
    this.diffFirepower = 0,
    required this.rank,
    required this.toggleFocus,
  }) : super(key: key);

  final String avatar;
  final String nickname;
  final bool followed;
  final int diffFirepower;
  final int rank;
  final VoidCallback toggleFocus;

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
                height: 80,
                width: 80,
                imageUrl: avatar,
              ),
            ),
            _buildAvatarPendant(),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          nickname,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        if (diffFirepower > 0)
          Text(
            '落后$diffFirepower火力',
            style: const TextStyle(
              color: Color(0xFF8D8D8D),
              fontSize: 12,
            ),
          ),
        InkWell(
          onTap: toggleFocus,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: followed
                    ? AssetImage(Assets.livePage.anchorNOFollowedBg.path)
                    : AssetImage(Assets.livePage.anchorNOUnfollowBg.path),
              ),
            ),
            child: Text(
              followed ? '已关注' : '关注',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildAvatarPendant() {
    print("rank biden"
        " ${rank}");
    switch (rank) {
      case 1:
        return Assets.livePage.anchorNo1.image(
          width: 85,
          height: 100,
          fit: BoxFit.cover,
        );
      case 2:
        return Assets.livePage.anchorNo2.image(
          width: 85,
          height: 100,
          fit: BoxFit.cover,
        );
      case 3:
        return Assets.livePage.anchorNo3.image(
          width: 85,
          height: 100,
          fit: BoxFit.cover,
        );
      default:
        return Assets.livePage.anchorNo1.image(
          width: 85,
          height: 100,
          fit: BoxFit.cover,
        );
    }
  }
}
