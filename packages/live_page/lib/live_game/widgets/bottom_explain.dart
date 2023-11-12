import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../live_game_page.dart';

class BottomExplainPage extends StatelessWidget {
  final String explain;

  const BottomExplainPage({
    Key? key,
    required this.explain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme customTheme =
        LiveGameController.to.currentCustomThemeData();

    return Container(
      decoration: BoxDecoration(
        color: customTheme.colors0xFFFFFF,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      constraints: BoxConstraints(
          maxHeight: 800 + MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  customTheme.colors0x6129FF,
                  customTheme.colors0xD96CFF,
                ],
              ),
            ),
            child: const Text(
              '玩法说明',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Html(data: explain),
              // child: Text(
              //   explain,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
