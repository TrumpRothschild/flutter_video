import 'package:flutter/material.dart';
import 'package:live_page/widgets/common_image.dart';

class RankingItem extends StatelessWidget {
  const RankingItem({
    Key? key,
    required this.rank,
    required this.avatar,
    required this.nickname,
    required this.diffFirepower,
    this.trailing,
  }) : super(key: key);

  final int rank;
  final String avatar;
  final String nickname;
  final int diffFirepower;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 30),
            alignment: Alignment.center,
            child: Text(
              '$rank',
              style: const TextStyle(
                color: Color(0xFF9F9F9F),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 5),
          ClipOval(
            child: CommonImage(
              width: 54,
              height: 54,
              imageUrl: avatar,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        nickname,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                if (diffFirepower > 0) ...[
                  const SizedBox(height: 6),
                  Text(
                    '落后$diffFirepower火力',
                    style: const TextStyle(
                      color: Color(0xFF9F9F9F),
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
