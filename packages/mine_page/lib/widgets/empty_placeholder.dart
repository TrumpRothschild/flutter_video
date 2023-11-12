import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({
    Key? key,
    required this.tipText,
    this.onTap,
  }) : super(key: key);

  final String tipText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.minePage.msgEmptyPlaceholder.image(
              width: 230,
              height: 180,
            ),
            Text(
              tipText,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
