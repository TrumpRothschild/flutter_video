import 'package:get/get.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/video_detail/video_detail_controller.dart';
class VideoDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoDetailController>(()=> VideoDetailController());
    Get.lazyPut<CardItemController>(()=> CardItemController());
  }
}
