import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_msg/models/mine_msg_bean.dart';

import '../../widgets/msg_empty_placeholder.dart';

part 'email_msg_detail_binding.dart';
part 'email_msg_detail_controller.dart';

class EmailMsgDetailPage extends GetView<EmailMsgDetailController> {
  const EmailMsgDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
      appBar: _buildAppBar(),
      body: const Center(
        child: MsgEmptyPlaceholder(),
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
        '与 ${controller.emailSender?.title ?? ''} 的对话',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: controller.currentCustomThemeData().colors0x000000,
        ),
      ),
      actions: [
        InkWell(
          onTap: controller.clearMsg,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 11),
              child: Text(
                '清空',
                style: TextStyle(
                  fontSize: 12,
                  color: controller.currentCustomThemeData().colors0x666666,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
