import 'package:base_page/login/login_controller.dart';
import 'package:game_page/game_home/game_home_controller.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_root/mine_root_controller.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/mine/mine_controller.dart';
import 'package:video_page/video_home/video_home_controller.dart';
import 'package:wallet_page/wallet_root/wallet_root_controller.dart';
import 'package:base_page/splash/splash_controller.dart';
import '../main/video_main_controller.dart';


class VideoAppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletRootController>(() => WalletRootController());
    Get.lazyPut<MineRootPageController>(() => MineRootPageController());
    Get.lazyPut<VideoHomeController>(() => VideoHomeController());
    Get.lazyPut<CardItemController>(() => CardItemController());
    Get.lazyPut<VideoMainController>(() => VideoMainController());
    Get.lazyPut<GameHomeController>(() => GameHomeController());
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<MineController>(() => MineController());
  }
}
