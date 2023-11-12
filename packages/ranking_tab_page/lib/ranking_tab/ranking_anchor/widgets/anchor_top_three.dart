import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../widgets/ranking_date_type.dart';
import '../../models/ranking_user_bean.dart';
import '../../widgets/ranking_time_tab.dart';
import 'anchor_no.dart';

class AnchorTopThree extends StatelessWidget {
  const AnchorTopThree({
    Key? key,
    required this.dateTypes,
    required this.userNo1,
    required this.userNo2,
    required this.userNo3,
    required this.tabController,
    required this.toggleFocus,
  }) : super(key: key);

  final List<RankingDateType> dateTypes;
  final RankingUserBean? userNo1;
  final RankingUserBean? userNo2;
  final RankingUserBean? userNo3;
  final TabController tabController;
  final ValueChanged<RankingUserBean?> toggleFocus;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / (380 + 55),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          AspectRatio(
            aspectRatio: 375 / 380,
            child: Assets.livePage.rankingAnchorBg.image(),
          ),
          RankingTimeTab(
            tabController: tabController,
            values: dateTypes,
          ),
          if (userNo1 != null)
            Padding(
              padding: const EdgeInsets.only(top: 205),
              child: AnchorNO(
                avatar: userNo1!.avatar,
                nickname: userNo1!.nickName,
                followed: userNo1!.isFocus,
                rank: userNo1!.position,
                toggleFocus: () {
                  toggleFocus(userNo1);
                },
              ),
            ),
          if (userNo2 != null)
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 26),
                child: AnchorNO(
                  avatar: userNo2!.avatar,
                  nickname: userNo2!.nickName,
                  followed: userNo2!.isFocus,
                  diffFirepower: userNo2!.distance,
                  rank: userNo2!.position,
                  toggleFocus: () {
                    toggleFocus(userNo2);
                  },
                ),
              ),
            ),
          if (userNo3 != null)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 26),
                child: AnchorNO(
                  avatar: userNo3!.avatar,
                  nickname: userNo3!.nickName,
                  followed: userNo3!.isFocus,
                  diffFirepower: userNo3!.distance,
                  rank: userNo3!.position,
                  toggleFocus: () {
                    toggleFocus(userNo3);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
