part of 'email_msg_detail_page.dart';

class EmailMsgDetailController extends GetXBaseController {
  late final MineMsgBean? emailSender;

  void clearMsg() {}

  @override
  void onInit() {
    emailSender = Get.arguments as MineMsgBean?;
    super.onInit();
  }
}
