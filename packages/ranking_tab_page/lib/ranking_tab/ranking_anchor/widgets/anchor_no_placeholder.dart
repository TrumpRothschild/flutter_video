import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../widgets/common_image.dart';

class AnchorNOPlaceholder extends StatelessWidget {
  const AnchorNOPlaceholder({
    Key? key,
    required this.rank,
  }) : super(key: key);

  final int rank;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const ClipOval(
              child: CommonImage(
                height: 80,
                width: 80,
                imageUrl: '',
              ),
            ),
            _buildAvatarPendant(),
          ],
        ),
        const SizedBox(height: 3),
        const Text(
          'nickname',
          style: TextStyle(
            color: Colors.transparent,
            fontSize: 14,
          ),
        ),
        const Text(
          '落后diffFirepower火力',
          style: TextStyle(
            color: Colors.transparent,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(Assets.livePage.anchorNOUnfollowBg.path),
            ),
          ),
          child: const Text(
            '虚位以待',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        )
      ],
    );
  }

  _buildAvatarPendant() {
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
    }
  }
}
