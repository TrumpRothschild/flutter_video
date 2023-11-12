import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class EndPlaceholder extends StatelessWidget {
  const EndPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.livePage.liveEndPlaceholder.image(
          width: 150,
          height: 150,
        ),
        const Text(
          '直播结束啦~',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const Text(
          '要不去看看别的吧~~~',
          style: TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 40),
        const Divider(
          color: Color(0xFFEDEDED),
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            const SizedBox(width: 10),
            Assets.livePage.liveEndGussULike.image(
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 6),
            const Text(
              '猜你喜欢',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
