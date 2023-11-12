import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'transfer_result_binding.dart';
part 'transfer_result_controller.dart';

class TransferResultPage extends GetView<TransferResultController> {
  const TransferResultPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 40),
            Assets.minePage.transferSuccess.image(
              width: 275,
              height: 205,
            ),
            const Spacer(flex: 110),
            Text(
              '转账成功',
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0x000000,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              '恭喜，您本次转账成功',
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0xC0C0C0,
                fontSize: 16,
              ),
            ),
            const Spacer(flex: 65),
            InkWell(
              onTap: controller.onConfirm,
              child: FittedBox(
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  constraints:
                      const BoxConstraints(minHeight: 35, minWidth: 200),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        controller.currentCustomThemeData().colors0x6129FF,
                        controller.currentCustomThemeData().colors0xD96CFF,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      '确 认',
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xFFFFFF,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 213),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
      title: Text(
        controller.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: controller.currentCustomThemeData().colors0x000000,
        ),
      ),
    );
  }
}
