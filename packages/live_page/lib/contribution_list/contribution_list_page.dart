import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/contribution_list/contribution_list_provider.dart';
import 'package:live_page/contribution_list/models/contribution_user_bean.dart';
import 'package:live_page/widgets/ranking_item.dart';

import '../widgets/ranking_date_type.dart';
import 'widgets/ranking_header.dart';

part 'contribution_list_controller.dart';

class ContributionListPage extends GetView<ContributionListController> {
  const ContributionListPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContributionListController>(
      init: ContributionListController(),
      builder: (controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        child: Obx(
          () => NestedScrollView(
            body: ListView.builder(
              itemCount: controller.itemCount,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: RankingHeader(
                      dateTypes: controller.dateTypes,
                      onDateTypeChanged: controller.onDateTypeChanged,
                      userNo1: controller.userNo1,
                      userNo2: controller.userNo2,
                      userNo3: controller.userNo3,
                    ),
                  );
                }
                final user = controller.users[index - 3];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 23),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFD8D8D8),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: RankingItem(
                    rank: index + 3,
                    avatar: user.avatar,
                    nickname: user.userName,
                    diffFirepower: user.fireDifference,
                  ),
                );
              },
            ),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '贡献榜',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
