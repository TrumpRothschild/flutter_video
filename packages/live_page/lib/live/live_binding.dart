import 'package:get/get.dart';
import 'live_page.dart';

class LiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveController>(() => LiveController(), fenix: true);
  }
}
