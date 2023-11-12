import 'package:get/get.dart';
import 'package:video_page/mine/mine_controller.dart';

import '../components/card_item/card_item_controller.dart';
class MineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineController>(()=> MineController());
    Get.lazyPut<CardItemController>(()=> CardItemController());
  }
}
