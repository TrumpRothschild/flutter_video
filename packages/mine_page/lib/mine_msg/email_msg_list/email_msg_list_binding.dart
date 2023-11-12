part of 'email_msg_list_page.dart';

class EmailMsgListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailMsgListController>(
      () => EmailMsgListController(),
    );
  }
}
