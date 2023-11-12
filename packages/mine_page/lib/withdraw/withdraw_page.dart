import 'dart:convert';

import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/extension.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_normal_dialog_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mine_page/models/withdraw_result_model.dart';
import 'package:mine_page/withdraw/widgets/bind_mobile_dialog.dart';
import 'package:mine_page/withdraw/widgets/delete_bank_card_alert.dart';
import 'package:mine_page/withdraw/widgets/item_bank.dart';
import 'package:mine_page/withdraw/widgets/no_pwd_dialog.dart';
import 'package:mine_page/withdraw/widgets/pay_pwd_dialog.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/bank_model.dart';
import 'package:services/models/res/user/user_detail_model.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';
import 'package:services/provider/user_provider.dart';

part 'withdraw_binding.dart';
part 'withdraw_controller.dart';

class WithdrawPage extends GetView<WithdrawController> {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = controller.currentCustomThemeData();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
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
            '提现',
            style: TextStyle(
              fontSize: 18,
              color: customTheme.colors0x000000,
            ),
          ),
          centerTitle: true,
          actions: [
            UnconstrainedBox(
              child: InkWell(
                onTap: controller.toRecord,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '提现记录',
                    style: TextStyle(
                      fontSize: 14,
                      color: customTheme.colors0x979797,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 109,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 0.8,
                        enableInfiniteScroll: false,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) {
                          controller.currentBankIndex = index;
                        }),
                    items: controller.bankList.mapIndexed((item, index) {
                      if (index != controller.bankList.length - 1) {
                        return ItemBank(
                          customTheme: customTheme,
                          item: item,
                          onDelete: () => controller.onDeleteItem(item),
                        );
                      } else {
                        return _buildAddItem(customTheme);
                      }
                    }).toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 8)
                      .copyWith(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 0.5,
                      color:
                          customTheme.colors0x000000_10 ?? Colors.transparent,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '提现金额',
                        style: TextStyle(
                          color: customTheme.colors0x000000,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8, right: 32, bottom: 8),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                            width: 0.5,
                            color: customTheme.colors0x000000_10 ??
                                Colors.transparent,
                          )),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '￥',
                              style: TextStyle(
                                color: customTheme.colors0x000000,
                                fontSize: 32,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller.withdrawInput,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  hintText:
                                      '请输入${controller.minWithdraw.toStringAsFixed(0)}~${controller.maxWithdraw.toStringAsFixed(0)}',
                                  hintStyle: TextStyle(
                                    color: customTheme.colors0xD8D8D8,
                                    fontSize: 18,
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  //数字，只能是整数
                                  LengthLimitingTextInputFormatter(9),
                                  //限制长度
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]")),
                                  //数字包括小数
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: controller.setMaxAmount,
                              child: Container(
                                height: 25,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(
                                      color: customTheme.colors0xD8D8D8 ??
                                          Colors.transparent),
                                ),
                                child: Text(
                                  '最大金额',
                                  style: TextStyle(
                                    color: customTheme.colors0x000000,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '账户金币：',
                              style: TextStyle(
                                color: customTheme.colors0x9F9F9F,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: controller.amount.toStringAsFixed(2),
                              style: TextStyle(
                                color: customTheme.colors0x000000,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '提现所需打码量：',
                              style: TextStyle(
                                color: customTheme.colors0x9F9F9F,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: controller.accountDml.toStringAsFixed(2),
                              style: TextStyle(
                                color: customTheme.colors0x000000,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                UnconstrainedBox(
                  child: InkWell(
                    onTap: () {
                      if (controller.bankList.value.isEmpty) {
                        OLEasyLoading.showToast('请选择提现银行卡');
                        return;
                      }
                      controller.onWithdraw(context);
                    },
                    child: Container(
                      height: AppDimens.h_33,
                      width: AppDimens.h_150,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(AppDimens.w_20),
                        image: DecorationImage(
                          image: AssetImage(Assets.basePage.loginBunBg.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text(
                        '提 现',
                        style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xFFFFFF,
                          fontSize: FontDimens.fontSp16,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    '提现说明\n${controller.withdrawTip}',
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0x9F9F9F,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildAddItem(CustomTheme customTheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(colors: [
          customTheme.colors0xAA8CFF,
          customTheme.colors0xAFADFF.withOpacity(0.32),
        ]),
      ),
      child: InkWell(
        onTap: controller.bindBank,
        child: SizedBox(
          height: 60,
          child: DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: const [4, 1],
            color: customTheme.colors0xFFFFFF,
            padding: EdgeInsets.zero,
            radius: const Radius.circular(5),
            child: Center(
              child: Text(
                '+ 立即绑定银行卡',
                style: TextStyle(
                  color: customTheme.colors0xFFFFFF,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
