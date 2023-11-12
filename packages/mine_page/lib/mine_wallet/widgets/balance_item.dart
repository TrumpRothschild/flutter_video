// import 'dart:ffi';

import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/number_util.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';

import 'stadium_border_button.dart';
import 'package:base/app_config.dart';

class BalanceItem extends StatelessWidget {
  const BalanceItem({
    Key? key,
    required this.customTheme,
    required this.toTransferList,
    required this.toExchangeCoin,
    required this.toExchangeDiamond,
    required this.toRecharge,
    required this.wallet,
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback toTransferList;
  final VoidCallback toExchangeCoin;
  final VoidCallback toExchangeDiamond;
  final VoidCallback toRecharge;
  final UserWalletModel wallet;

  Widget diamondsButton() {
    final isVideo = AppConfig.app == EnvApp.video;
    return isVideo
        ? Container()
        : StadiumBorderButton(
            customTheme: customTheme,
            title: '兑换钻石',
            onTap: toExchangeDiamond,
          );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 355 / 170,
      child: Stack(
        children: [
          Assets.minePage.balanceBg.image(fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '账户余额',
                          style: TextStyle(
                            color: customTheme.colors0xFFFFFF,
                            fontSize: 19,
                          ),
                        ),
                        InkWell(
                          onTap: toTransferList,
                          child: Text(
                            '交易明细>',
                            style: TextStyle(
                              color: customTheme.colors0xFFFFFF,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26.6 / 19 + 35 / 25),
                    Text(
                      NumberUtil.formatNum(double.parse(wallet.balance ?? '0.00'), 2),
                      style: TextStyle(
                        color: customTheme.colors0xFFFFFF,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StadiumBorderButton(
                      customTheme: customTheme,
                      title: '兑换金币',
                      onTap: toExchangeCoin,
                    ),
                    diamondsButton(),
                    StadiumBorderButton(
                      customTheme: customTheme,
                      title: '充值',
                      onTap: toRecharge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
