import 'package:base_page/login/login_controller.dart';
import 'package:game_page/game_home/game_home_controller.dart';
import 'package:get/get.dart';
import 'package:home_page/controller/home_controller.dart';
import 'package:home_page/controller/home_follow_controller.dart';
import 'package:home_page/controller/home_nearby_controller.dart';
import 'package:home_page/controller/home_other_controller.dart';
import 'package:home_page/controller/home_recommend_controller.dart';
import 'package:home_page/controller/home_search_controller.dart';
import 'package:home_page/controller/home_video_controller.dart';
import 'package:live_page/gift_list/gift_list_page.dart';
import 'package:live_page/live/live_page.dart';
import 'package:mine_page/mine_root/mine_root_controller.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/mine/mine_controller.dart';
import 'package:video_page/video_home/video_home_controller.dart';
import 'package:wallet_page/wallet_root/wallet_root_controller.dart';
import 'package:base_page/splash/splash_controller.dart';
import '../main/live_main_controller.dart';

class LiveAppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<WalletRootController>(() => WalletRootController());
    Get.lazyPut<MineRootPageController>(() => MineRootPageController());
    Get.lazyPut<VideoHomeController>(() => VideoHomeController());
    Get.lazyPut<CardItemController>(() => CardItemController());
    Get.lazyPut<LiveMainController>(() => LiveMainController());
    Get.lazyPut<GameHomeController>(() => GameHomeController());
    Get.lazyPut<HomeFollowController>(() => HomeFollowController());
    Get.lazyPut<HomeRecommendController>(() => HomeRecommendController());
    Get.lazyPut<HomeOtherController>(() => HomeOtherController());
    Get.lazyPut<HomeNearbyController>(() => HomeNearbyController());
    Get.lazyPut<HomeVideoController>(() => HomeVideoController());
    Get.lazyPut<HomeSearchController>(() => HomeSearchController());
    Get.lazyPut<LiveController>(() => LiveController());
    Get.lazyPut<GiftListController>(() => GiftListController());
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<MineController>(() => MineController());
  }
}
