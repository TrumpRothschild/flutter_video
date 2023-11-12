part of 'share_page.dart';

class LiveShareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareController>(
      () => ShareController(),
    );
  }
}
