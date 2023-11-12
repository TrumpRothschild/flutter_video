import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

enum VipType {
  gold,
  silver,
}

extension VipTypeHelper on VipType {
  List<Color> get colors {
    switch (this) {
      case VipType.gold:
        return [
          const Color(0xFFFC5806),
          const Color(0xFFFDD650),
        ];
      case VipType.silver:
        return [
          const Color(0xFF2399FB),
          const Color(0xFFB8F9FE),
        ];
    }
  }

  Widget get icon {
    switch (this) {
      case VipType.gold:
        return Assets.livePage.nobilityGold.image(
          width: 15,
          height: 13,
        );
      case VipType.silver:
        return Assets.livePage.nobilitySilver.image(
          width: 15,
          height: 13,
        );
    }
  }
}

class CommonVip extends StatelessWidget {
  const CommonVip({
    Key? key,
    required this.vipType,
    required this.vipLevel,
  }) : super(key: key);

  final VipType vipType;
  final int vipLevel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 3),
          margin: const EdgeInsets.only(left: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: vipType.colors,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            'VIP $vipLevel',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        vipType.icon,
      ],
    );
  }
}
