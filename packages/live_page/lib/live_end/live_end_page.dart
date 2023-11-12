import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live_end/widgets/live_card.dart';
import 'package:services/models/res/home/home_live_bean.dart';

import 'widgets/end_placeholder.dart';

part 'live_end_binding.dart';
part 'live_end_controller.dart';

class LiveEndPage extends GetView<LiveEndController> {
  const LiveEndPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const EndPlaceholder(),
          Expanded(
            child: Obx(
              () => OlGridView(
                dataList: controller.lives,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //设置列数
                  crossAxisCount: 2,
                  //设置横向间距
                  crossAxisSpacing: 5,
                  //设置主轴间距
                  mainAxisSpacing: 5,
                ),
                padding: const EdgeInsets.all(5),
                refreshCallback: controller.onRefresh,
                loadMoreCallback: controller.onLoadMore,
                buildWidgetCallback: (_, index) => LiveCard(
                  item: controller.lives[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.navigate_before,
          color: Colors.black,
        ),
      ),
    );
  }
}
