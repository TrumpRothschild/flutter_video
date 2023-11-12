part of 'gesture_pwd_page.dart';

class GesturePwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GesturePwdController>(
      () => GesturePwdController(),
    );
  }
}
