import 'package:get/get.dart';
import 'package:video_page/problem_details/problem_details_controller.dart';
class ProblemDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProblemDetailsController>(()=> ProblemDetailsController());
  }
}
