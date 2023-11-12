import 'package:get/get.dart';
import 'package:video_page/search_type/search_type_controller.dart';


class SearchTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchTypePageController>(()=> SearchTypePageController());
  }
}
