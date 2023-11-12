import 'package:flutter/material.dart';

class GiftTab extends StatelessWidget {
  const GiftTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18 / 13),
          child: Text(
            '礼物',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6129FF),
                Color(0xFFD96CFF),
              ],
            ),
          ),
          width: 15,
          height: 3,
        ),
      ],
    );
  }
}
