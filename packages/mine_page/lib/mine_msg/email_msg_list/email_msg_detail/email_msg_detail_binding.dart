part of 'email_msg_detail_page.dart';

class EmailMsgDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailMsgDetailController>(
      () => EmailMsgDetailController(),
    );
  }
}
