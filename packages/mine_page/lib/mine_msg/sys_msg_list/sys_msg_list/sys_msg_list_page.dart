import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_msg/models/msg_page_bean.dart';
import 'package:mine_page/mine_msg/sys_msg_list/sys_msg_list/widgets/sys_msg_item.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/mine_msg_apis.dart';
import 'package:services/models/res/base_response.dart';

import '../../models/mine_msg_bean.dart';
import '../../widgets/msg_empty_placeholder.dart';

part 'sys_msg_list_binding.dart';
part 'sys_msg_list_controller.dart';

class SysMsgListPage extends GetView<SysMsgListController> {
  const SysMsgListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
      appBar: _buildAppBar(),
      body: SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoad,
        header: const WaterDropHeader(),
        child: Obx(
          () => controller.sysMsgs.isEmpty
              ? const MsgEmptyPlaceholder()
              : ListView.separated(
                  itemCount: controller.sysMsgs.length,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final msgBean = controller.sysMsgs[index];
                    return SysMsgItem(
                      customTheme: controller.currentCustomThemeData(),
                      msg: msgBean,
                    );
                  },
                ),
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
        "系统消息",
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
