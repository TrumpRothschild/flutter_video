import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class CommonManager extends StatelessWidget {
  const CommonManager({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Assets.livePage.manager.image(
      width: 15,
      height: 13,
    );
  }
}
