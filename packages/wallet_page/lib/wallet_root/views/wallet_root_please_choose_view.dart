import 'package:base/assets.gen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wallet_root_controller.dart';

class WalletRootPleaseChoose extends StatelessWidget {
  final WalletRootController controller = Get.find();
  final String tip;

  WalletRootPleaseChoose({
    Key? key,
    required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          Image.asset(
            Assets.walletPage.line.path,
            width: 4,
            height: 18,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            tip,
            style: TextStyle(
              color: controller.currentCustomThemeData().colors0x333333,
              fontSize: FontDimens.fontSp18,
            ),
          ),
        ],
      ),
    );
  }
}
