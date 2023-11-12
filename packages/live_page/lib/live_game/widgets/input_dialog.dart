import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class InputDialog extends StatelessWidget {
  final CustomTheme customTheme;

  InputDialog({
    Key? key,
    required this.customTheme,
  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: customTheme.colors0xD9D9D9),
            ),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '请输入',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              child: Text(
                '自定义范围：2~10000',
                style: TextStyle(
                  color: customTheme.colors0xD9D9D9,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: customTheme.colors0xD9D9D9, width: 0.5)),
            ),
            height: 37,
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
                VerticalDivider(color: customTheme.colors0xD9D9D9),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final int cusChip = int.tryParse(_controller.text) ?? 0;
                      if (cusChip > 2 && cusChip < 10000) {
                        Navigator.pop(context, cusChip);
                      } else {
                        OLEasyLoading.showToast('范围：2~10000');
                      }
                    },
                    child: Text(
                      '确定',
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

Future<int?> showCustomBottomSheet(
  BuildContext context, {
  required CustomTheme customTheme,
}) async {
  return await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          '请输入自定义底分',
          textAlign: TextAlign.center,
        ),
        titleTextStyle:
            TextStyle(fontSize: 16, color: customTheme.colors0x000000),
        content: InputDialog(
          customTheme: customTheme,
        ),
      );
    },
  );
}
