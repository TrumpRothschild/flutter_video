import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mine_page/widgets/empty_placeholder.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';

import 'transaction_detail_controller.dart';
import 'widgets/transaction_item.dart';

class TransactionDetailPage extends GetBaseView<TransactionDetailController> {
  const TransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = controller.currentCustomThemeData();
    return Scaffold(
        backgroundColor: customTheme.colors0xF6F5FB,
        appBar: AppBar(
          iconTheme: IconThemeData(color: customTheme.colors0x000000),
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            icon: Assets.basePage.backBlack.image(
              width: AppDimens.w_8,
              height: AppDimens.h_15,
              fit: BoxFit.fill,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          title: Text(
            controller.title,
            style: TextStyle(color: customTheme.colors0x000000, fontSize: 16),
          ),
          actions: [
            UnconstrainedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDatePicker(context);
                    },
                    child: Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                            right: controller.billType.isEmpty ? 0 : 16),
                        child: Text(
                          controller.selectedDateStr,
                          style: TextStyle(
                            color: customTheme.colors0x000000,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (controller.billType.isEmpty)
                    InkWell(
                      onTap: controller.openFilter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '筛选',
                          style: TextStyle(
                            color: customTheme.colors0x000000,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
        body: GetBuilder<TransactionDetailController>(
          builder: (controller) => controller.transactionList.isEmpty
              ? EmptyPlaceholder(
                  tipText: '暂无数据',
                  onTap: controller.onRefresh,
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10).copyWith(left: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _HeaderItem(
                            customTheme,
                            title: '支出：',
                            value: controller.billOutcomeValue,
                            value1:
                                (controller.transactionModel?.goldOutcome ?? 0)
                                    .toStringAsFixed(2),
                            value2:
                                (controller.transactionModel?.silverOutcome ??
                                        0)
                                    .toStringAsFixed(0),
                            value3:
                                (controller.transactionModel?.balanceOutcome ??
                                        0)
                                    .toStringAsFixed(2),
                          ),
                          _HeaderItem(
                            customTheme,
                            title: '收入：',
                            value: controller.billIncomeValue,
                            value1:
                                (controller.transactionModel?.goldIncome ?? 0)
                                    .toStringAsFixed(2),
                            value2:
                                (controller.transactionModel?.silverIncome ?? 0)
                                    .toStringAsFixed(0),
                            value3:
                                (controller.transactionModel?.balanceIncome ??
                                        0)
                                    .toStringAsFixed(2),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                        height: 2,
                        thickness: 2,
                        color: customTheme.colors0xE6E6E6),
                    Expanded(
                      child: SmartRefresher(
                        controller: controller.refreshController,
                        enablePullUp: true,
                        onRefresh: controller.onRefresh,
                        onLoading: controller.onLoading,
                        footer: CustomFooter(
                          builder: (context, mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = Text(
                                videoPageTranslations['up_loading_more'].toString(),
                                style: TextStyle(
                                    color: const Color(0xff999999),
                                    fontSize: sp(28)),
                              );
                            } else if (mode == LoadStatus.loading) {
                              body = const CupertinoActivityIndicator();
                            } else if (mode == LoadStatus.failed) {
                              body = Text(
                                  videoPageTranslations['loading_failed_try_again'].toString(),
                                style: TextStyle(
                                    color: const Color(0xff999999),
                                    fontSize: sp(28)),
                              );
                            } else if (mode == LoadStatus.canLoading) {
                              body = Text(videoPageTranslations['release_loading_more'].toString(),
                                  style: TextStyle(
                                      color: const Color(0xff999999),
                                      fontSize: sp(28)));
                            } else {
                              body = Text(
                                videoPageTranslations['loading_no_data'].toString(),
                                style: TextStyle(
                                    color: const Color(0xff999999),
                                    fontSize: sp(28)),
                              );
                            }
                            return SizedBox(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: controller.transactionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = controller.transactionList[index];
                            return InkWell(
                              onTap: () {
                                controller.toInfo(item);
                              },
                              child: TransactionItem(
                                detail: item,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                                height: 1,
                                thickness: 1,
                                color: customTheme.colors0xE6E6E6);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }

  void showDatePicker(BuildContext context) {
    Pickers.showDatePicker(
      context,
      mode: DateMode.YM,
      suffix: Suffix(),
      // selectDate: PDuration(month: 2),
      // minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(
        year: DateTime.now().year,
        month: DateTime.now().month,
      ),
      selectDate: PDuration(
        year: controller.selectedDate.value?.year ?? 1999,
        month: controller.selectedDate.value?.month ?? 1,
      ),
      // minDate: PDuration(hour: 12, minute: 38, second: 3),
      // maxDate: PDuration(hour: 12, minute: 40, second: 36),
      onConfirm: (p) {
        // selectData[model] = '${p.year}-${p.month}';
        // 处理选择后的日期
        controller.onDateUpdate(DateTime(p.year ?? 1999, p.month ?? 1));
      },
      // onChanged: (p) => print(p),
    );
  }
}

class _HeaderItem extends StatelessWidget {
  final CustomTheme customTheme;
  final String title;
  final String value1;
  final String value2;
  final String value3;
  final String? value;

  const _HeaderItem(
    this.customTheme, {
    Key? key,
    required this.title,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: customTheme.colors0x000000, fontSize: 12),
        ),
        DefaultTextStyle(
          style: TextStyle(color: customTheme.colors0xA0A0A0, fontSize: 12),
          child: Column(
            children: [
              if (value != null && value != 'null' && value!.isNotEmpty)
                Text('$value')
              else ...[
                Text('金币：$value1'),
                Text('钻石：$value1'),
                Text('余额：$value1'),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
