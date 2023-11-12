import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';

import '../widgets/empty_placeholder.dart';
import '../widgets/focused_user_item.dart';
import 'mine_fans_controller.dart';

class MineFansPage extends GetView<MineFansController> {
  MineFansPage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
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
          "粉丝列表",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        enablePullUp: true,
        child: Obx(
          () => controller.fansUsers.isEmpty
              ? const EmptyPlaceholder(tipText: '暂无粉丝')
              : ListView.separated(
                  itemCount: controller.fansUsers.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color:
                          controller.currentCustomThemeData().colors0x000000_20,
                      height: 0.5,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final user = controller.fansUsers[index];
                    return InkWell(
                      onTap: () {
                        controller.onTapItem(user);
                      },
                      child: FocusedUserItem(
                        customTheme: controller.currentCustomThemeData(),
                        isFansPage: true,
                        user: user,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
