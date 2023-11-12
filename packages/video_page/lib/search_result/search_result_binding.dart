import 'package:get/get.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/search_result/search_result_controller.dart';
class SearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchResultPageController>(()=> SearchResultPageController());
    Get.lazyPut<CardItemController>(()=> CardItemController());
  }
}
