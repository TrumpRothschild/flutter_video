import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class StadiumBorderButton extends StatelessWidget {
  const StadiumBorderButton({
    Key? key,
    required this.customTheme,
    this.constraints = const BoxConstraints(minWidth: 100, minHeight: 38),
    this.onTap,
    required this.title,
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback? onTap;
  final String title;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: constraints,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: customTheme.colors0xFFFFFF,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: customTheme.colors0xFFFFFF,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
