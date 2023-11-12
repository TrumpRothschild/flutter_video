part of 'sys_msg_list_page.dart';

class SysMsgListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SysMsgListController>(
      () => SysMsgListController(),
    );
  }
}
