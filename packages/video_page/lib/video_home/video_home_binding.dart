import 'package:get/get.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/video_home/video_home_controller.dart';

class VideoHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoHomeController>(() => VideoHomeController());
    Get.lazyPut<CardItemController>(() => CardItemController());
  }
}
