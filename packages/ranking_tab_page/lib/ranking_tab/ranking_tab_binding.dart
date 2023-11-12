part of 'ranking_tab_page.dart';

class RankingTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankingTabController>(
      () => RankingTabController(),
    );
    Get.lazyPut<RankingAnchorController>(
      () => RankingAnchorController(),
    );
    Get.lazyPut<RankingToffController>(
      () => RankingToffController(),
    );
  }
}
