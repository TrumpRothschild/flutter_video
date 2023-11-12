import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/res/app_dimens.dart';
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

import 'widgets/transaction_item.dart';
import 'withdraw_record_controller.dart';

class WithdrawRecordPage extends GetBaseView<WithdrawRecordController> {
  const WithdrawRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = controller.currentCustomThemeData();
    return Scaffold(
        backgroundColor: customTheme.colors0xFFFFFF,
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
          elevation: 1,
          titleSpacing: 0,
          title: Text(
            "提现记录",
            style: TextStyle(color: customTheme.colors0x000000, fontSize: 16),
          ),
          centerTitle: true,
          actions: [
            UnconstrainedBox(
              child: Obx(
                () => InkWell(
                  onTap: () async {
                    showDatePicker(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
            )
          ],
        ),
        body: GetBuilder<WithdrawRecordController>(
          builder: (controller) => controller.transactionList.isEmpty
              ? EmptyPlaceholder(
                  tipText: '暂无数据',
                  onTap: controller.onRefresh,
                )
              : Column(
                  children: [
                    Expanded(
                      child: SmartRefresher(
                        controller: controller.refreshController,
                        enablePullUp: true,
                        onRefresh: controller.onRefresh,
                        onLoading: controller.onLoading,
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
                                onCancel: () {
                                  controller.onCancel(item.id);
                                },
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                                height: 1,
                                thickness: 1,
                                color: customTheme.colors0xEEEEEE);
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
        day: controller.selectedDate.value?.day ?? 1,
      ),
      // minDate: PDuration(hour: 12, minute: 38, second: 3),
      // maxDate: PDuration(hour: 12, minute: 40, second: 36),
      onConfirm: (p) {
        // selectData[model] = '${p.year}-${p.month}';
        // 处理选择后的日期
        controller
            .onDateUpdate(DateTime(p.year ?? 1999, p.month ?? 1));
      },
      // onChanged: (p) => print(p),
    );
  }
}
