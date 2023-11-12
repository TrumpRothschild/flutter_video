import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../game_transfer_page.dart';

class BalanceHeader extends StatelessWidget {
  const BalanceHeader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GameTransferInController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 355 / 87,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Assets.minePage.gameTransferBg.image(fit: BoxFit.cover),
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: controller.showQuickBalance
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    if (!controller.showQuickBalance)
                      Obx(
                        () => Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: controller.showQuickBalance
                                    ? '余额：'
                                    : '游戏账户：',
                                style: TextStyle(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0xFFFFFF,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${controller.showQuickBalance ? (controller.userWallet.balance ?? 0.0) : controller.freeMoney.value}',
                                style: TextStyle(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0xFFFFFF,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Obx(
                      () => Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  controller.showQuickBalance ? '金币：' : '现有金币：',
                              style: TextStyle(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0xFFFFFF,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: (controller.showQuickBalance ? '\n' : '') +
                                  '${controller.userWallet.amount ?? 0.0}',
                              style: TextStyle(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0xFFFFFF,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FittedBox(
                child: InkWell(
                  onTap: controller.toRecharge,
                  child: Container(
                    constraints:
                        const BoxConstraints(minHeight: 25, minWidth: 79),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          controller.currentCustomThemeData().colors0x6129FF,
                          controller.currentCustomThemeData().colors0xD96CFF,
                        ],
                      ),
                      border: Border.all(
                        color:
                            controller.currentCustomThemeData().colors0xFFFFFF,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '充值',
                        style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xFFFFFF,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
