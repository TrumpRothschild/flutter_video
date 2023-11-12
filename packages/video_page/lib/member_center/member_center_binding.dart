import 'package:get/get.dart';
import 'package:video_page/member_center/member_center_controller.dart';
class MemberCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemberCenterController>(()=> MemberCenterController());
  }
}
