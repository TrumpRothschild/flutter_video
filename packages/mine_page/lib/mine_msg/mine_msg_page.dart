import 'package:base/app_config.dart';
import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_msg/models/mine_msg_bean.dart';
import 'package:mine_page/mine_root/mine_root_controller.dart';
import 'package:services/api/mine_msg_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:video_page/mine/mine_controller.dart';

import 'widgets/mine_msg_row.dart';
import 'widgets/msg_empty_placeholder.dart';

part 'mine_msg_binding.dart';
part 'mine_msg_controller.dart';

class MineMsgPage extends GetView<MineMsgController> {
  const MineMsgPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
      appBar: _buildAppBar(),
      body: Obx(
        () => controller.latestNews.isEmpty
            ? InkWell(
                onTap: () {
                  controller.getLatestNews();
                },
                child: const MsgEmptyPlaceholder(),
              )
            : ListView.separated(
                itemCount: controller.latestNews.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: controller.currentCustomThemeData().colors0xE6E6E6,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  final msgBean = controller.latestNews[index];
                  return InkWell(
                    onTap: () {
                      controller.onTapMsg(msgBean);
                    },
                    child: MineMsgRow(
                      customTheme: controller.currentCustomThemeData(),
                      isAllReaded: controller.isAllReaded,
                      msg: msgBean,
                    ),
                  );
                },
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
        "消息",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: controller.currentCustomThemeData().colors0x000000,
        ),
      ),
      actions: [
        InkWell(
          onTap: controller.clearAllUnread,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 11),
              child: Text(
                '一键已读',
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
