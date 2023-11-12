import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    Key? key,
    required this.anchorNickname,
  }) : super(key: key);

  final String anchorNickname;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.cancel_outlined,
          color: Colors.transparent,
          size: 25,
        ),
        Text(
          '$anchorNickname 的名片',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
            size: 25,
          ),
        ),
      ],
    );
  }
}
