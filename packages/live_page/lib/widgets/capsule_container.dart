import 'package:flutter/material.dart';

class CapsuleContainer extends StatelessWidget {
  const CapsuleContainer({
    Key? key,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    this.radius = 20,
    this.margin,
    this.bgColor = const Color(0x4D000000),
    this.alignment = Alignment.center,
  }) : super(key: key);

  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double radius;
  final Color bgColor;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: alignment,
      constraints: const BoxConstraints(minHeight: 20),
      padding: padding,
      child: child,
    );
  }
}
