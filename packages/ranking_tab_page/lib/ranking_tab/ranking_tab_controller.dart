part of 'ranking_tab_page.dart';

class RankingTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<Widget> tabs = [];

  @override
  void onInit() {
    tabs = [
      const Tab(text: '主播榜'),
      const Tab(text: '土豪榜'),
    ];
    tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
