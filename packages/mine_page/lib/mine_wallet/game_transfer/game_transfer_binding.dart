part of 'game_transfer_page.dart';

class GameTransferInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameTransferInController>(
      () => GameTransferInController(),
    );
  }
}
