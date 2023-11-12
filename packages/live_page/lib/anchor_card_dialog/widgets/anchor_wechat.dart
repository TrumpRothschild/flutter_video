import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class AnchorWechat extends StatelessWidget {
  const AnchorWechat({
    Key? key,
    required this.account,
    required this.onTap,
  }) : super(key: key);

  final String account;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                Assets.livePage.anchorCardWechat.image(width: 35, height: 35),
          ),
          const SizedBox(width: 9),
          Text(
            account.isEmpty ? '**********' : account,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFFFC466B),
                    Color(0xFF3F5EFB),
                  ],
                ),
              ),
              child: const Text(
                '获取',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
