import 'package:base/bases/get_base_binding.dart';
import 'package:get/get.dart';
import 'package:home_page/controller/home_controller.dart';

import '../controller/home_follow_controller.dart';
import '../controller/home_nearby_controller.dart';
import '../controller/home_other_controller.dart';
import '../controller/home_recommend_controller.dart';
import '../controller/home_video_controller.dart';

/// 首页binding
class HomeBinding extends GetBaseBindings {
  @override
  void dependencies() {
    // 首页
    Get.lazyPut<HomeController>(() => HomeController());

    // 首页关注binding
    Get.lazyPut<HomeFollowController>(() => HomeFollowController());

    // 首页推荐binding
    Get.lazyPut<HomeRecommendController>(() => HomeRecommendController());

    // 首页附近binding
    Get.lazyPut<HomeNearbyController>(() => HomeNearbyController());

    // 首页热门、游戏、附近、体育binding
    Get.lazyPut<HomeOtherController>(() => HomeOtherController());

    // 首页星秀binding
    Get.lazyPut<HomeVideoController>(() => HomeVideoController());
  }
}
