part of 'ranking_anchor_page.dart';

class RankingAnchorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankingAnchorController>(
      () => RankingAnchorController(),
    );
  }
}
