import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/withdraw_record/withdraw_record_provider.dart';

import '../models/withdraw_result_model.dart';

part 'withdraw_result_binding.dart';
part 'withdraw_result_controller.dart';

class WithdrawResultPage extends GetView<WithdrawResultController> {
  const WithdrawResultPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: controller.currentCustomThemeData().colors0x000000),
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "提现进度",
          style: TextStyle(
            color: controller.currentCustomThemeData().colors0x000000,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        Log.d('-------> ${controller.info.value}');
        return controller.info.value.withdrawNo.isEmpty
            ? const SizedBox()
            : Column(
                children: [
                  const SizedBox(height: 25),
                  Container(
                    margin: const EdgeInsets.only(left: 62),
                    child: DottedBorder(
                      color: controller
                          .currentCustomThemeData()
                          .colors0x000000_20!,
                      padding: EdgeInsets.zero,
                      customPath: (size) {
                        return Path()
                          ..moveTo(0, 20 / 2)
                          ..lineTo(0, size.height - 20 / 2);
                      },
                      child: Transform.translate(
                        offset: const Offset(-36 / 2, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 9,
                                  height: 9,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: (36 - 9) / 2),
                                  decoration: BoxDecoration(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x9F44FF,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Text(
                                  '发起提现申请',
                                  style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x9F9F9F,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 72),
                            Row(
                              children: [
                                Assets.minePage.withdrawCurrent.image(
                                  width: 36,
                                  height: 36,
                                ),
                                const SizedBox(width: 24),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '银行处理中',
                                      style: TextStyle(
                                        color: controller
                                            .currentCustomThemeData()
                                            .colors0x000000,
                                      ),
                                    ),
                                    Text(
                                      '预计5-15分钟到账',
                                      style: TextStyle(
                                        color: controller
                                            .currentCustomThemeData()
                                            .colors0x9F9F9F,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 67),
                            Row(
                              children: [
                                Container(
                                  width: 9,
                                  height: 9,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: (36 - 9) / 2),
                                  decoration: BoxDecoration(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0xD9D9D9,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Text(
                                  '到账成功',
                                  style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x9F9F9F,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 31),
                  Divider(
                    color: controller.currentCustomThemeData().colors0xD9D9D9,
                    thickness: 0.5,
                    height: 0.5,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Text(
                          '提现金额',
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x9F9F9F,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '￥${controller.info.value.withdrawAmt}',
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x9F9F9F,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Text(
                          '到账银行',
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x9F9F9F,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          controller.info.value.asteriskBankNo,
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x9F9F9F,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
