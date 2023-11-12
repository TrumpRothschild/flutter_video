part of 'ranking_toff_page.dart';

class RankingToffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankingToffController>(
      () => RankingToffController(),
    );
  }
}
