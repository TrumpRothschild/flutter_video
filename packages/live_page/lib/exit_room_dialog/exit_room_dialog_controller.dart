part of 'exit_room_dialog_page.dart';

class ExitRoomDialogController extends GetxController {

 var anchor= LiveController.of.roomDetailData.value?.liveAnchorVO;

  void exit() {
    Get.back();
    Get.back();

  }

  Future<void> followThenExit() async {
    if (anchor?.userId == 0) return;
    OLEasyLoading.showLoading('');
    final succ = await LiveProvider.focusUser(
      focusUserId: anchor?.userId??0,
    );
    OLEasyLoading.dismiss();
    if (succ) {
      await OLEasyLoading.showToast('关注成功');
    }
    exit();
  }
}
