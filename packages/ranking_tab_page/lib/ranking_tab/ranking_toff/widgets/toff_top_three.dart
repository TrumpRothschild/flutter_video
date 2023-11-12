import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../widgets/ranking_NO1.dart';
import '../../../widgets/ranking_NO2.dart';
import '../../../widgets/ranking_NO3.dart';
import '../../../widgets/ranking_date_type.dart';
import '../../models/ranking_user_bean.dart';
import '../../widgets/ranking_time_tab.dart';

class ToffTopThree extends StatelessWidget {
  const ToffTopThree({
    Key? key,
    required this.dateTypes,
    required this.userNo1,
    required this.userNo2,
    required this.userNo3,
    required this.tabController,
  }) : super(key: key);

  final List<RankingDateType> dateTypes;
  final RankingUserBean? userNo1;
  final RankingUserBean? userNo2;
  final RankingUserBean? userNo3;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 380,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          AspectRatio(
            aspectRatio: 375 / 380,
            child: Assets.livePage.rankingToffBg.image(),
          ),
          RankingTimeTab(
            tabController: tabController,
            values: dateTypes,
          ),
          if (userNo1 != null)
            Padding(
              padding: const EdgeInsets.only(top: 145),
              child: RankingNO1(
                avatar: userNo1!.avatar,
                nickname: userNo1!.nickName,
                nicknameColor: Colors.black,
                vipLevel: userNo1!.userLevel,
              ),
            ),
          if (userNo2 != null)
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 26),
                child: RankingNO2(
                  avatar: userNo2!.avatar,
                  nickname: userNo2!.nickName,
                  diffFirepower: userNo2!.distance,
                  nicknameColor: Colors.black,
                  diffFirepowerColor: Colors.black,
                  vipLevel: userNo2!.userLevel,
                ),
              ),
            ),
          if (userNo3 != null)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 26),
                child: RankingNO3(
                  avatar: userNo3!.avatar,
                  nickname: userNo3!.nickName,
                  nicknameColor: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
