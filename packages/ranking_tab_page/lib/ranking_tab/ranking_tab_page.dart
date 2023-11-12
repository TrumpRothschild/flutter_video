import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ranking_anchor/ranking_anchor_page.dart';
import 'ranking_toff/ranking_toff_page.dart';

part 'ranking_tab_binding.dart';
part 'ranking_tab_controller.dart';

class RankingTabPage extends GetView<RankingTabController> {
  const RankingTabPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          RankingAnchorPage(),
          RankingToffPage(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: UnconstrainedBox(
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: Assets.livePage.rankingNavBack.image(
            width: 25,
            height: 25,
          ),
        ),
      ),
      title: TabBar(
        // splashFactory: NoSplash.splashFactory,
        //  tabBar 长按的 highlightColor
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
        controller: controller.tabController,
        isScrollable: true,
        tabs: controller.tabs,
        physics: const BouncingScrollPhysics(),
        labelColor: const Color(0xFF6732FF),
        unselectedLabelColor: const Color(0xFF7032FF).withOpacity(0.4),
        indicatorSize: TabBarIndicatorSize.label,
        padding: EdgeInsets.zero,
        indicatorWeight: 3,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 12),
        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
        labelStyle: const TextStyle(
          fontSize: 16,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
        ),
        indicatorColor: const Color(0xFF6732FF),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }
}
