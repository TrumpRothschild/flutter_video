import 'package:flutter/material.dart';

class CircularMenuItem extends StatelessWidget {
  final Widget menuWidget;
  final VoidCallback? onTap;

  const CircularMenuItem({
    Key? key,
    this.onTap,
    required this.menuWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: InkWell(
        child: menuWidget,
        onTap: onTap,
      ),
    );
  }
}
