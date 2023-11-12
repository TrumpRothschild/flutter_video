import 'package:base/bases/get_base_binding.dart';
import 'package:base_page/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends GetBaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
