import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';

import 'real_name_auth_function_column.dart';

class RealNameAuthFunctions extends StatelessWidget {
  const RealNameAuthFunctions({
    Key? key,
    required this.customTheme,
    required this.isRealNameAuth,
  }) : super(key: key);

  final CustomTheme customTheme;
  final bool isRealNameAuth;

  Color? get textColor =>
      isRealNameAuth ? customTheme.colors0x949494 : customTheme.colors0xDFDFDF;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '实名认证手机号码将用于以下功能',
          style: TextStyle(
            color: customTheme.colors0xB8B8B8,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 39),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RealNameAuthFunctionColumn(
              iconPath: isRealNameAuth
                  ? Assets.minePage.anQuanPhone.path
                  : Assets.minePage.anQuanPhoneNor.path,
              text: '手机认证',
              textColor: textColor,
            ),
            RealNameAuthFunctionColumn(
              iconPath: isRealNameAuth
                  ? Assets.minePage.anQuanPwd.path
                  : Assets.minePage.anQuanPwdNor.path,
              text: '安全认证',
              textColor: textColor,
            ),
            RealNameAuthFunctionColumn(
              iconPath: isRealNameAuth
                  ? Assets.minePage.anQuanMoney.path
                  : Assets.minePage.anQuanMoneyNor.path,
              text: '收益',
              textColor: textColor,
            ),
          ],
        ),
      ],
    );
  }
}
