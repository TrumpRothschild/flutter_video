import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/ranking_date_type.dart';
import '../../widgets/ranking_item.dart';
import '../models/ranking_user_bean.dart';
import '../ranking_user_provider.dart';
import 'widgets/toff_top_three.dart';

part 'ranking_toff_binding.dart';
part 'ranking_toff_controller.dart';

class RankingToffPage extends GetView<RankingToffController> {
  const RankingToffPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ToffTopThree(
              dateTypes: controller.dateTypes,
              tabController: controller.tabController,
              userNo1: controller.userNo1,
              userNo2: controller.userNo2,
              userNo3: controller.userNo3,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 26),
              child: Divider(
                color: Color(0xFFD8D8D8),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final user = controller.users[index - 3];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFD8D8D8),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: RankingItem(
                    rank: user.position,
                    avatar: user.avatar,
                    nickname: user.nickName,
                    diffFirepower: user.distance,
                  ),
                );
              },
              childCount: controller.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
