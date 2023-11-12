import 'package:get/get.dart';
import 'package:video_page/recommend/recommend_controller.dart';
class RecommendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecommendPageController>(()=> RecommendPageController());
  }
}
