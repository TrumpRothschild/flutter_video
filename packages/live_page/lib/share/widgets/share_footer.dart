import 'package:flutter/material.dart';

class ShareFooter extends StatelessWidget {
  const ShareFooter({
    Key? key,
    required this.onCopyLink,
    required this.onSaveQRCode,
  }) : super(key: key);

  final VoidCallback onCopyLink;
  final VoidCallback onSaveQRCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onCopyLink,
          child: Container(
            width: 125,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF9F44FF),
              ),
            ),
            child: const Text(
              '复制连接',
              style: TextStyle(
                color: Color(0xFF9F44FF),
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 13),
        InkWell(
          onTap: onSaveQRCode,
          child: Container(
            width: 125,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6129FF),
                  Color(0xFFD96CFF),
                ],
              ),
            ),
            child: const Text(
              '保存二维码',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
