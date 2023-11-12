import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../models/mine_msg_bean.dart';

class SysMsgItem extends StatelessWidget {
  const SysMsgItem({
    Key? key,
    required this.customTheme,
    required this.msg,
  }) : super(key: key);

  final CustomTheme customTheme;
  final MineMsgBean msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: [
          Center(
            child: Text(
              msg.createTimeStr,
              style: TextStyle(
                fontSize: 14,
                color: customTheme.colors0x000000_30,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.minePage.sysMsgDetail.image(
                width: 46,
                height: 46,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '公告',
                      style: TextStyle(
                        color: customTheme.colors0x9F44FF,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 9),
                      decoration: BoxDecoration(
                        color: customTheme.colors0xF7F7F7,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Html(data: msg.content),
                          // const SizedBox(height: 30),
                          // Text(
                          //   msg.title,
                          //   style: TextStyle(
                          //     color: customTheme.colors0x000000,
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
