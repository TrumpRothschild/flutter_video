import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class BindMobileDialog extends StatelessWidget {
  final CustomTheme customTheme;

  const BindMobileDialog({
    Key? key,
    required this.customTheme,
    required this.onConfirm,
  }) : super(key: key);

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: Center(
              child: Text(
                '为了您的账户安全，请您先绑定手机号码？',
                style: TextStyle(
                  color: customTheme.colors0xD9D9D9,
                  fontSize: 14,
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
            height: 54,
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
                    onTap: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    child: Text(
                      '立即绑定',
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

Future<void> showBindMobileBottomSheet(
  BuildContext context, {
  required CustomTheme customTheme,
  required VoidCallback onConfirm,
}) async {
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          '温馨提示',
          textAlign: TextAlign.center,
        ),
        titleTextStyle:
            TextStyle(fontSize: 20, color: customTheme.colors0x000000),
        content: BindMobileDialog(
          customTheme: customTheme,
          onConfirm: onConfirm,
        ),
      );
    },
  );
}
