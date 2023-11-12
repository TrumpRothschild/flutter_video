import 'package:get/get.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/my_like/my_like_controller.dart';
class MyLikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyLikeController>(()=> MyLikeController());
    Get.lazyPut<CardItemController>(()=> CardItemController());
  }
}
