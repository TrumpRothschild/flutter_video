import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class NoPWDDialog extends StatelessWidget {
  final CustomTheme customTheme;

  NoPWDDialog({
    Key? key,
    required this.customTheme,
  }) : super(key: key);

  final TextEditingController textEditingController1 = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();

  bool _checkSetPwd(String pwd1, String pwd2) {
    if (pwd1.isEmpty) {
      OLEasyLoading.showToast('请先输入密码');
      return false;
    }
    if (pwd2.isEmpty) {
      OLEasyLoading.showToast('请再次确认密码');
      return false;
    }
    if (pwd1 != pwd2) {
      OLEasyLoading.showToast('两次输入密码不一致');
      return false;
    }
    return true;
  }

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
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Center(
                child: Text(
                  '为了您的安全，请先设置支付密码',
                  style: TextStyle(
                    color: customTheme.colors0xD9D9D9,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: customTheme.colors0xEEEEEE,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Assets.basePage.pwdBlack.image(
                    width: 12,
                    height: 14,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: textEditingController1,
                      obscureText: true,
                      obscuringCharacter: '*',
                      style: TextStyle(
                        color: customTheme.colors0x000000,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: '请设置密码（6-18位字符）',
                        hintStyle: TextStyle(
                          color: customTheme.colors0xD6D6D6,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => textEditingController1.clear(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Assets.basePage.xx.image(
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: customTheme.colors0xEEEEEE,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Assets.basePage.pwdOs.image(
                    width: 12,
                    height: 14,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: textEditingController2,
                      obscureText: true,
                      obscuringCharacter: '*',
                      style: TextStyle(
                        color: customTheme.colors0x000000,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: '请再次确认密码',
                        hintStyle: TextStyle(
                          color: customTheme.colors0xD6D6D6,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => textEditingController2.clear(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Assets.basePage.xx.image(
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ],
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
                        final valid = _checkSetPwd(textEditingController1.text,
                            textEditingController2.text);
                        if (!valid) return;
                        Navigator.pop(context, textEditingController2.text);
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

Future<String?> showNoPwdBottomSheet(
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
          '您仍未设置支付密码',
          textAlign: TextAlign.center,
        ),
        titleTextStyle:
            TextStyle(fontSize: 16, color: customTheme.colors0x000000),
        content: NoPWDDialog(
          customTheme: customTheme,
        ),
      );
    },
  );
}
