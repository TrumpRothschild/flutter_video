part of 'update_ges_pwd_page.dart';

class UpdateGesPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateGesPwdController>(
      () => UpdateGesPwdController(),
    );
  }
}
