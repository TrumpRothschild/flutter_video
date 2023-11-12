part of 'mine_msg_page.dart';

class MineMsgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineMsgController>(
      () => MineMsgController(),
    );
  }
}
