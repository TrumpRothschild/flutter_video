import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class MsgEmptyPlaceholder extends StatelessWidget {
  const MsgEmptyPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.minePage.msgEmptyPlaceholder.image(
            width: 228,
            height: 180,
          ),
          const Text(
            '暂无内容',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
