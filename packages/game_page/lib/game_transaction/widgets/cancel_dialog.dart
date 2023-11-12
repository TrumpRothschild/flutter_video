import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class CancelDialog extends StatelessWidget {
  final CustomTheme customTheme;

  const CancelDialog({
    Key? key,
    required this.customTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            child: Center(
              child: Text(
                '是否确认取消订单？',
                style: TextStyle(
                  color: customTheme.colors0x000000,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: customTheme.colors0xD9D9D9, width: 0.5)),
            ),
            height: 47,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      '取消',
                      style: TextStyle(
                        color: customTheme.colors0xD9D9D9,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: VerticalDivider(color: customTheme.colors0xD9D9D9),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, true),
                    child: Text(
                      '确认',
                      style: TextStyle(
                        color: customTheme.colors0x9F44FF,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool?> showCancelDialog(
  BuildContext context, {
  required CustomTheme customTheme,
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: CancelDialog(
          customTheme: customTheme,
        ),
      );
    },
  );
}
