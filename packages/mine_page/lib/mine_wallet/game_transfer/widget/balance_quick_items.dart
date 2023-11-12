import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../game_transfer_page.dart';

class BalanceQuickItems extends StatelessWidget {
  const BalanceQuickItems({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GameTransferInController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 26),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Obx(
        () => Wrap(
          runSpacing: 8,
          spacing: 18,
          children: List.generate(controller.quickBalances.length, (index) {
            final model = controller.quickBalances[index];
            bool isSelected = controller.selectedQuick == model;
            return InkWell(
              onTap: () {
                controller.onQuickItemTap(controller.quickBalances[index]);
              },
              child: Container(
                width: (MediaQuery.of(context).size.width -
                        18 * 2 -
                        10 * 2 -
                        10 * 2) /
                    3,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: controller.currentCustomThemeData().colors0xF3F3F3,
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            controller.currentCustomThemeData().colors0x6129FF,
                            controller.currentCustomThemeData().colors0xD96CFF,
                          ],
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    '${model.platformGoldNum}金币',
                    style: TextStyle(
                      color: isSelected
                          ? controller.currentCustomThemeData().colors0xFFFFFF
                          : controller.currentCustomThemeData().colors0x979797,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
