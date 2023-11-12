import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';

class TitleSubtitleRow extends StatelessWidget {
  const TitleSubtitleRow({
    Key? key,
    required this.title,
    required this.subtitle,
    this.showCopy = false,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool showCopy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF979797),
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 32),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        if (showCopy) ...[
          const Spacer(),
          InkWell(
            onTap: () {
              OLEasyLoading.showToast('复制订单：$subtitle');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFEBEBEB),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: const Text(
                '复制',
                style: TextStyle(
                  color: Color(0xFF949494),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
