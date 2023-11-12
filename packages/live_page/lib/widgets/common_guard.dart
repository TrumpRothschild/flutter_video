import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

enum GuardType {
  gold,
  silver,
}

extension GuardTypeHelper on GuardType {
  Widget get icon {
    switch (this) {
      case GuardType.gold:
        return Assets.livePage.guardGold.image(
          width: 15,
          height: 13,
        );
      case GuardType.silver:
        return Assets.livePage.guardSilver.image(
          width: 15,
          height: 13,
        );
    }
  }
}

class CommonGuard extends StatelessWidget {
  const CommonGuard({
    Key? key,
    required this.guardType,
  }) : super(key: key);

  final GuardType guardType;

  @override
  Widget build(BuildContext context) {
    return guardType.icon;
  }
}
