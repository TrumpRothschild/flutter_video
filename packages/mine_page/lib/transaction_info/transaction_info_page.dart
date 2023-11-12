import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/number_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/transaction_info/widgets/transaction_bg_image.dart';
import 'package:mine_page/transaction_info/widgets/transaction_icon_image.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

import 'widgets/title_subtitle_row.dart';

part 'transaction_info_binding.dart';
part 'transaction_info_controller.dart';

class TransactionInfoPage extends GetView<TransactionInfoController> {
  const TransactionInfoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('交易详情'),
        leading: InkWell(
          onTap: Get.back,
          child: const Icon(
            Icons.navigate_before,
            color: Colors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          TransactionBgImage(orderStatus: controller.info.orderStatus ?? 1),
          SafeArea(
            child: Center(
              child: SizedBox(
                width: 312,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TransactionIconImage(
                            orderStatus: controller.info.orderStatus ?? 1),
                        Text(
                          controller.stateName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 68),
                    Text(
                      '${NumberUtil.formatNum(controller.info.amount ?? 0.00, 2)} ${controller.info.billTypeName}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Assets.minePage.transactionInfoDotline
                              .image(height: 1),
                          const SizedBox(height: 20),
                          TitleSubtitleRow(
                            subtitle: controller.info.projectName ?? '',
                            title: '项目名称',
                          ),
                          const SizedBox(height: 10),
                          TitleSubtitleRow(
                            subtitle: controller.info.changeTypeName ?? '',
                            title: '交易类型',
                          ),
                          const SizedBox(height: 10),
                          TitleSubtitleRow(
                            subtitle: controller.info.billTypeName,
                            title: '交易方式',
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Container(
                      height: 5,
                      width: 312,
                      color: const Color(0xFFFAFAFA),
                    ),
                    const SizedBox(height: 21),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TitleSubtitleRow(
                        subtitle: controller.info.orderNO ?? '',
                        title: '订单号    ',
                        showCopy: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TitleSubtitleRow(
                        subtitle: controller.info.createTimeFormatter,
                        title: '交易时间',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
