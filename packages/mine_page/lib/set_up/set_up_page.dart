import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/set_up/widgets/setup_cell.dart';

import 'set_up_controller.dart';

class SetUpPage extends GetView<SetUpController> {
  SetUpPage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final customTheme = controller.currentCustomThemeData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: customTheme.colors0x000000),
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          icon: Assets.basePage.backBlack.image(
            width: AppDimens.w_10,
            height: AppDimens.h_20,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "设置",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: Center(
        child: Obx(
          () => Column(
            children: [
              Divider(
                height: 5,
                thickness: 5,
                color: controller.currentCustomThemeData().colors0xF7F7F7,
              ),
              ...controller.cellModels
                  .map(
                    (e) => SetupCell(
                      customTheme: controller.currentCustomThemeData(),
                      onTap: controller.onCellTap,
                      cellModel: e,
                    ),
                  )
                  .toList(),
              Expanded(
                child: InkWell(
                  onTap: () {
                    /// 调用退出登录接口
                    controller.logout();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: AppDimens.h_38,
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppDimens.w_80),
                    child: const Text("切换账户",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: FontDimens.fontSp20)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.w_20),
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.minePage.loginOut.path,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
