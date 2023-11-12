import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteBankCardAlert extends StatelessWidget {
  const DeleteBankCardAlert({
    Key? key,
    required this.customTheme,
    required this.onConfirm,
    this.title = '确定删除该银行卡？',
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback onConfirm;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: customTheme.colors0x000000,
      ),
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: customTheme.colors0xD9D9D9,
                    width: 0.5,
                  ),
                ),
              ),
              height: 54,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
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
                    child: VerticalDivider(
                      color: customTheme.colors0xD9D9D9,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Get.back();
                        onConfirm();
                      },
                      child: Text(
                        '确定',
                        style: TextStyle(
                          color: customTheme.colors0x000000,
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
      ),
    );
  }
}
