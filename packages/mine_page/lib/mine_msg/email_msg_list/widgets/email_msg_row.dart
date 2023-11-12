import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:mine_page/mine_msg/models/mine_msg_bean.dart';
import 'package:services/image/ol_image.dart';

class EmailMsgRow extends StatelessWidget {
  const EmailMsgRow({
    Key? key,
    required this.customTheme,
    required this.msg,
  }) : super(key: key);

  final CustomTheme customTheme;
  final MineMsgBean msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ClipOval(
                  child: OLImage(
                    imageUrl: '',
                    width: 35,
                    height: 35,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    msg.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: customTheme.colors0x151515,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                if (!msg.isRead)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: customTheme.colors0xFF3434,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '未读',
                        style: TextStyle(
                          color: customTheme.colors0x000000_30,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Text(
            msg.createTimeStr,
            style: TextStyle(
              fontSize: 12,
              color: customTheme.colors0xCFCFCF,
            ),
          ),
        ],
      ),
    );
  }
}
