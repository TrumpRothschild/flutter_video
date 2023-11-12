part of 'mine_wallet_page.dart';

class MineWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineWalletController>(
      () => MineWalletController(),
    );
  }
}
