import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/provider/user_provider.dart';

import '../widgets/real_name_auth_functions.dart';

part 'account_safety_binding.dart';
part 'account_safety_controller.dart';

class AccountSafetyPage extends GetView<AccountSafetyController> {
  const AccountSafetyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            Assets.basePage.backBlack.path,
             width: 10,
            height: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          "账户安全中心",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(flex: 21),
          Assets.minePage.anQuan.image(
            width: 150,
            height: 165,
          ),
          const Spacer(flex: 14),
          Obx(
            () => Text(
              controller.isPhoneBinded ? '安全等级-高' : '安全等级-低',
              style: TextStyle(
                fontSize: 16,
                color: controller.isPhoneBinded
                    ? controller.currentCustomThemeData().colors0x000000
                    : Colors.red,
              ),
            ),
          ),
          const Spacer(flex: 39),
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              color: controller.currentCustomThemeData().colors0xF7F7F7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.bindPhoneStatus,
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0xACACAC,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: controller.toPhoneBinding,
                    child: SizedBox(
                      height: 35,
                      child: Center(
                        child: Text(
                          controller.bindPhoneNumber,
                          style: TextStyle(
                            color: controller.isPhoneBinded
                                ? controller
                                    .currentCustomThemeData()
                                    .colors0x000000
                                : controller
                                    .currentCustomThemeData()
                                    .colors0x9F44FF,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 60),
          Obx(
            () => RealNameAuthFunctions(
              customTheme: controller.currentCustomThemeData(),
              isRealNameAuth: controller.isPhoneBinded,
            ),
          ),
          const Spacer(flex: 221),
        ],
      ),
    );
  }
}
