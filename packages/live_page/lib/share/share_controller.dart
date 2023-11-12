part of 'share_page.dart';

class ShareController extends GetxController {
  int _activeIndex = 0;
  void onIndexChanged(int? activeIndex) {
    _activeIndex = activeIndex ?? 0;
  }

  void onCopyLink() {
    OLEasyLoading.showToast('复制链接：$_activeIndex');
  }

  void onSaveQRCode() {
    OLEasyLoading.showToast('保存二维码：$_activeIndex');
  }
}
