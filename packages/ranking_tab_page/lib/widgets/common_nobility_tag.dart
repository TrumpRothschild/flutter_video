import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

enum NobilityTagType {
  marquis,
}

extension NobilityTagIcon on NobilityTagType {
  Widget get icon {
    switch (this) {
      case NobilityTagType.marquis:
        return Assets.livePage.marquis.image(
          width: 30,
          height: 11,
        );
    }
  }
}

class CommonNobilityTag extends StatelessWidget {
  const CommonNobilityTag({
    Key? key,
    required this.nobilityTagType,
  }) : super(key: key);

  final NobilityTagType nobilityTagType;

  @override
  Widget build(BuildContext context) {
    return nobilityTagType.icon;
  }
}
