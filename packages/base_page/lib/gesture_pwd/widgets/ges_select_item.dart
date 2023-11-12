import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class GesSelectItem extends StatelessWidget {
  const GesSelectItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Assets.basePage.gestureSelectBorder.image(
            width: 38,
            height: 38,
          ),
          Assets.basePage.gestureSelectDot.image(
            width: 18,
            height: 18,
          ),
        ],
      ),
    );
  }
}
