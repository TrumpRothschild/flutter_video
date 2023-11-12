import 'package:flutter/material.dart';

class RealNameAuthFunctionColumn extends StatelessWidget {
  const RealNameAuthFunctionColumn({
    Key? key,
    required this.iconPath,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  final String iconPath;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 43,
          height: 44,
        ),
        const SizedBox(height: 18),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
