import 'dart:math';

import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/number_util.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/transaction_detail/transaction_detail_controller.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';

import '../mine_wallet_page.dart';

class CoinItem extends StatelessWidget {
  const CoinItem({
    Key? key,
    required this.controller,
    required this.wallet,
  }) : super(key: key);

  final MineWalletController controller;
  final UserWalletModel wallet;

  CustomTheme get _customTheme => controller.currentCustomThemeData();

  @override
  Widget build(BuildContext context) {
    return Container(
        //超出部分，可裁剪
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
        ),
        child: AspectRatio(
          aspectRatio: 355 / 180,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Assets.minePage.coinBg.image(fit: BoxFit.cover),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '金币',
                              style: TextStyle(
                                color: _customTheme.colors0xFFFFFF,
                                fontSize: 19,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller
                                    .toTransferList(TransactionPageType.coin);
                              },
                              child: Text(
                                '交易明细>',
                                style: TextStyle(
                                  color: _customTheme.colors0xFFFFFF,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 26.6 / 19 + 35 / 25),
                        Text(
                          NumberUtil.formatNum(
                              double.parse(wallet.amount ?? '0.00'), 2),
                          style: TextStyle(
                            color: _customTheme.colors0xFFFFFF,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => _buildFooter(),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.withdraw,
                  );
                },
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, minHeight: 38),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: _customTheme.colors0xFFFFFF,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '提现',
                      style: TextStyle(
                        color: _customTheme.colors0xFFFFFF,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.rollOutAll();
                },
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, minHeight: 38),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: _customTheme.colors0xFFFFFF,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '一键转出',
                      style: TextStyle(
                        color: _customTheme.colors0xFFFFFF,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.toRecharge(2);
                },
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, minHeight: 38),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: _customTheme.colors0xFFFFFF,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '充值',
                      style: TextStyle(
                        color: _customTheme.colors0xFFFFFF,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: controller.onExpandGameTap,
          child: Container(
            margin: const EdgeInsets.fromLTRB(2, 12, 0, 0),
            constraints: const BoxConstraints(minHeight: 29),
            decoration: BoxDecoration(
              color: _customTheme.colors0x763EAE_50,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(13),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: controller.isCoinExpand ? -pi : 0,
                    child: Assets.minePage.coinMore.image(
                      width: 13,
                      height: 17,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Padding(
                    padding: EdgeInsets.only(
                        top: controller.isCoinExpand ? 0 : 3,
                        bottom: controller.isCoinExpand ? 3 : 0),
                    child: Text(
                      '查看更多',
                      style: TextStyle(
                        color: _customTheme.colors0xFFFFFF,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
