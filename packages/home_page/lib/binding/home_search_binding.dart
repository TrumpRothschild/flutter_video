import 'package:base/bases/get_base_binding.dart';
import 'package:get/get.dart';

import '../controller/home_search_controller.dart';

/// 首页搜索binding
class HomeSearchBinding extends GetBaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeSearchController>(() => HomeSearchController());
  }
}
