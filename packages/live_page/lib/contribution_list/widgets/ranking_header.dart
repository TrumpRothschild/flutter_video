import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/contribution_list/models/contribution_user_bean.dart';
import 'package:live_page/widgets/capsule_container.dart';

import '../../widgets/ranking_NO1.dart';
import '../../widgets/ranking_NO2.dart';
import '../../widgets/ranking_NO3.dart';
import '../../widgets/ranking_date_type.dart';

class RankingHeader extends StatefulWidget {
  const RankingHeader({
    Key? key,
    required this.dateTypes,
    required this.onDateTypeChanged,
    required this.userNo1,
    required this.userNo2,
    required this.userNo3,
  }) : super(key: key);

  final List<RankingDateType> dateTypes;
  final ValueChanged<RankingDateType> onDateTypeChanged;
  final ContributionUserBean? userNo1;
  final ContributionUserBean? userNo2;
  final ContributionUserBean? userNo3;

  @override
  State<RankingHeader> createState() => _RankingHeaderState();
}

class _RankingHeaderState extends State<RankingHeader> {
  RankingDateType _selectedRankingType = RankingDateType.day;

  _onTypeChanged(RankingDateType newType) {
    if (newType == _selectedRankingType) return;
    _selectedRankingType = newType;
    setState(() {});
    widget.onDateTypeChanged(_selectedRankingType);
  }

  _openRankingPage() {
    Get.back();
    Get.toNamed(AppRoutes.rankingTab);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 240,
      child: Stack(
        children: [
          Assets.livePage.rankingBg.image(
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _buildRankingType(),
                const SizedBox(height: 18),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.userNo2 != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Spacer(),
                            RankingNO2(
                              avatar: widget.userNo2!.avatar,
                              nickname: widget.userNo2!.userName,
                              vipLevel: widget.userNo2!.userLevel,
                              diffFirepower: widget.userNo2!.fireDifference,
                            ),
                          ],
                        ),
                      if (widget.userNo1 != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RankingNO1(
                                avatar: widget.userNo1!.avatar,
                                nickname: widget.userNo1!.userName,
                                vipLevel: widget.userNo1!.userLevel,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      if (widget.userNo3 != null)
                        RankingNO3(
                          avatar: widget.userNo3!.avatar,
                          nickname: widget.userNo3!.userName,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingType() {
    return Row(
      children: [
        ...widget.dateTypes.map(
          (e) => Container(
            margin: const EdgeInsets.only(right: 5),
            child: InkWell(
              onTap: () {
                _onTypeChanged(e);
              },
              child: CapsuleContainer(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                bgColor: _selectedRankingType == e
                    ? const Color(0xFF9F44FF)
                    : Colors.white.withOpacity(0.5),
                child: Text(
                  e.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: _openRankingPage,
          child: const Text(
            '排行榜',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
