import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../game_transfer_page.dart';

class BalanceInput extends StatelessWidget {
  const BalanceInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GameTransferInController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: Obx(
            () =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '转账金额',
                  style: TextStyle(
                    color: controller
                        .currentCustomThemeData()
                        .colors0x000000,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  constraints: const BoxConstraints(minHeight: 77),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: controller
                        .currentCustomThemeData()
                        .colors0xF3F3F3,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.amountController,
                            keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: true),
                            style: TextStyle(
                              color:
                              controller
                                  .currentCustomThemeData()
                                  .colors0x000000,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText:
                              '可转金币 ${controller.showQuickBalance ? (controller
                                  .userWallet.amount ?? 0.0) : controller
                                  .freeMoney.value} 个',
                              hintStyle: TextStyle(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0xB6B6B6,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: controller.typeAllBalance,
                          child: Text(
                            '全部',
                            style: TextStyle(
                              color:
                              controller
                                  .currentCustomThemeData()
                                  .colors0x9F44FF,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '最低1金币起转',
                  style: TextStyle(
                    color: controller
                        .currentCustomThemeData()
                        .colors0xB6B6B6,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
