import 'package:get/get.dart';
import 'package:video_page/my_request/my_request_controller.dart';
class MyRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRequestController>(()=> MyRequestController());
  }
}
