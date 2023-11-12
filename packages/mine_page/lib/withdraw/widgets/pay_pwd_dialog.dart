import 'package:base/app_routes.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';

class PayPWDDialog extends StatelessWidget {
  final CustomTheme customTheme;

  PayPWDDialog({
    Key? key,
    required this.customTheme,
  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: '请输入密码',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // 忘记支付密码
                Get.toNamed(
                  AppRoutes.register,
                  arguments: {
                    "type": 4,
                    "mobilePhone":
                        UserManagerCache.shared.getUserDetail()?.mobilePhone ??
                            ""
                  },
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 32),
                  child: Text(
                    '忘记密码？',
                    style: TextStyle(
                      color: customTheme.colors0xD9D9D9,
                      fontSize: 14,
                    ),
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
                        if (_controller.text.length >= 6) {
                          Navigator.pop(context, _controller.text);
                        } else {
                          OLEasyLoading.showToast('密码小于6位');
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
      ),
    );
  }
}

Future<String?> showPayPwdBottomSheet(
  BuildContext context, {
  required CustomTheme customTheme,
}) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          '请输入支付密码',
          textAlign: TextAlign.center,
        ),
        titleTextStyle:
            TextStyle(fontSize: 16, color: customTheme.colors0x000000),
        content: PayPWDDialog(
          customTheme: customTheme,
        ),
      );
    },
  );
}
