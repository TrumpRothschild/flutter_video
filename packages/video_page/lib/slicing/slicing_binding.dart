import 'package:get/get.dart';
import 'package:video_page/slicing/slicing_controller.dart';
class SlicingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SlicingController>(()=> SlicingController());
  }
}
