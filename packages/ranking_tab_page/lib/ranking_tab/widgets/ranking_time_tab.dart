import 'package:flutter/material.dart';

import '../../widgets/capsule_container.dart';
import '../../widgets/ranking_date_type.dart';
import 'bubble_tab_indicator.dart';

class RankingTimeTab extends StatelessWidget {
  const RankingTimeTab({
    Key? key,
    required this.values,
    required this.tabController,
  }) : super(key: key);

  final List<RankingDateType> values;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        width: 240,
        height: 25,
        child: CapsuleContainer(
          bgColor: Colors.white,
          padding: EdgeInsets.zero,
          child: TabBar(
            controller: tabController,
            tabs: values
                .map(
                  (e) => Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(
                      minWidth: 83,
                      minHeight: 28,
                    ),
                    child: Text(e.title),
                  ),
                )
                .toList(),
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFF6732FF),
            indicatorSize: TabBarIndicatorSize.tab,
            padding: EdgeInsets.zero,
            // isScrollable: true,
            // splashBorderRadius: const BorderRadius.all(Radius.circular(8)),
            indicator: const BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: Color(0xFF6732FF),
              indicatorRadius: 25,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.zero,
              insets: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
