import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../widgets/capsule_container.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    this.vipLevel,
    required this.nickname,
    required this.msg,
  }) : super(key: key);

  final int? vipLevel;
  final String nickname;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CapsuleContainer(
          // 置空，让背景适配内容
          alignment: null,
          padding: const EdgeInsets.all(10),
          radius: 12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (vipLevel != null && vipLevel! > 0)
                CapsuleContainer(
                  bgColor: const Color(0xFFE681FF),
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.livePage.vipComeInDiamond.image(
                        width: 7,
                        height: 6,
                      ),
                      const SizedBox(width: 1.5),
                      Text(
                        'VIP $vipLevel',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  nickname + (msg.isNotEmpty ? ': ' : ''),
                  style: const TextStyle(
                    color: Color(0xFFE681FF),
                    fontSize: 13,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  msg,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
