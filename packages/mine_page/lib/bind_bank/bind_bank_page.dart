import 'package:base/app_contant.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_appbar_title_widget.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base_page/image_code/image_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mine_page/bind_bank/widgets/bind_card_code_dialog.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/login/image_code_model.dart';
import 'package:services/models/res/user/simple_bank_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mine_home_page/edit_information/widgets/cancel_confirm_sheet.dart';
import 'bind_bank_provider.dart';

part 'bind_bank_binding.dart';
part 'bind_bank_controller.dart';

class BindBankPage extends GetView<BindBankController> {
  const BindBankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = controller.currentCustomThemeData();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: customTheme.colors0xFFFFFF,
          leading: AppBarBackButton(),
          title: AppBarCenterTitle(title: "binding_bank_card", controller: controller),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () async {
                      String url = UserManagerCache.shared.getNewOnlineUrl();
                      await launchUrl(Uri.parse(url),
                mode: LaunchMode.externalApplication,);
                    },
                    child: SvgPicture.asset(
                      Assets.basePage.kefu,
                      height: 26,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
              ],
            )
          ],
          elevation: 1,
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            controller.currentCustomThemeData().colors0xEEEEEE,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '持卡人',
                        style: TextStyle(
                          fontSize: 18,
                          color: customTheme.colors0x000000,
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: TextField(
                          controller: controller.textEditingController1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: '请输入持卡人姓名',
                            hintStyle: TextStyle(
                              color: customTheme.colors0xACACAC,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: customTheme.colors0x9F44FF,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            controller.currentCustomThemeData().colors0xEEEEEE,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '银行卡号',
                        style: TextStyle(
                          fontSize: 18,
                          color: customTheme.colors0x000000,
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: TextField(
                          controller: controller.textEditingController2,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: '请输入银行卡号',
                            hintStyle: TextStyle(
                              color: customTheme.colors0xACACAC,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: customTheme.colors0x9F44FF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      CancelConfirmSheet(
                        customTheme: customTheme,
                        selectedItem: controller.selectBank.value,
                        items: controller.bankList
                            .map((element) => element.value ?? '')
                            .toList(),
                        onConfirm: (String value) async {
                          if (controller.selectBank.value != value) {
                            controller.selectBank.value = value;
                            // final succ = await _updateUserInfo();
                            // if (succ) {
                            //   update();
                            // }
                          }
                          Get.back();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xEEEEEE,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '开户银行',
                          style: TextStyle(
                            fontSize: 18,
                            color: customTheme.colors0x000000,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              controller.selectBank.value,
                              style: TextStyle(
                                fontSize: 18,
                                color: customTheme.colors0xACACAC,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: customTheme.colors0xACACAC,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 150),
                  child: Center(
                    child: Text(
                      '（请妥善填写银行卡信息，绑定后不可更改）',
                      style: TextStyle(
                        fontSize: 12,
                        color: customTheme.colors0xFF0000,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: controller.onConfirm,
                    style: ElevatedButton.styleFrom(
                      primary:
                          controller.currentCustomThemeData().colors0x9F44FF,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 100,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    child: Text(
                      '添加银行卡',
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xFFFFFF,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
