import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_msg/models/mine_msg_bean.dart';

class MineMsgRow extends StatelessWidget {
  const MineMsgRow({
    Key? key,
    required this.customTheme,
    required this.isAllReaded,
    required this.msg,
  }) : super(key: key);

  final CustomTheme customTheme;
  final RxBool isAllReaded;
  final MineMsgBean msg;

  bool get showBadge {
    if (isAllReaded.value) return false;
    return !msg.isRead;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.asset(
                    msg.typeIcon,
                    width: 58,
                    height: 58,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Text(
                              msg.typeTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: customTheme.colors0x151515,
                                fontSize: 16,
                              ),
                            ),
                            if (showBadge)
                              Positioned(
                                right: -7,
                                child: Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: customTheme.colors0xFF3434,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (msg.title.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          msg.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: customTheme.colors0x666666,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
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
