import 'package:get/get.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/screen/screen_controller.dart';
class ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenController>(()=> ScreenController());
    Get.lazyPut<CardItemController>(()=> CardItemController());
  }
}
