import 'package:get/get.dart';
import 'package:video_page/offline_cache/offline_cache_controller.dart';
class OfflineCacheBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfflineCacheController>(()=> OfflineCacheController());
  }
}
