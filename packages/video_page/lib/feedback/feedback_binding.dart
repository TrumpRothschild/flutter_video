import 'package:get/get.dart';
import 'package:video_page/feedback/feedback_controller.dart';
class FeedBackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedBackController>(()=> FeedBackController());
  }
}
