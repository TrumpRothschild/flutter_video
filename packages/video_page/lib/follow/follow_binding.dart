import 'package:get/get.dart';
import 'package:video_page/follow/follow_controller.dart';
class FollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowController>(()=> FollowController());
  }
}
