import 'package:get/get.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/record/record_controller.dart';
class RecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordController>(()=> RecordController());
    Get.lazyPut<CardItemController>(()=> CardItemController());
  }
}
