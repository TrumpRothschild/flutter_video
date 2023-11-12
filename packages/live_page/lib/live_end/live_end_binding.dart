part of 'live_end_page.dart';

class LiveEndBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveEndController>(
      () => LiveEndController(),
    );
  }
}
