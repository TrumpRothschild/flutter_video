import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/ranking_date_type.dart';
import '../../widgets/ranking_item.dart';
import '../models/ranking_user_bean.dart';
import '../ranking_user_provider.dart';
import 'widgets/anchor_top_three.dart';

part 'ranking_anchor_binding.dart';
part 'ranking_anchor_controller.dart';

class RankingAnchorPage extends GetView<RankingAnchorController> {
  const RankingAnchorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AnchorTopThree(
              dateTypes: controller.dateTypes,
              tabController: controller.tabController,
              userNo1: controller.userNo1,
              userNo2: controller.userNo2,
              userNo3: controller.userNo3,
              toggleFocus: controller.toggleFocus,
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
                final user = controller.users[index + 3];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Color(0xFFD8D8D8),
                    width: 0.5,
                  ))),
                  child: RankingItem(
                    rank: user.position,
                    avatar: user.avatar,
                    nickname: user.nickName,
                    diffFirepower: user.distance,
                    trailing: InkWell(
                      onTap: () {
                        controller.toggleFocus(user);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        width: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: user.isFocus ? null : const Color(0xFFC1A7FF),
                          borderRadius: BorderRadius.circular(30),
                          image: user.isFocus
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      Assets.livePage.anchorUnfollowBg.path))
                              : null,
                        ),
                        child: Text(
                          user.isFocus ? '关注' : '已关注',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
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
