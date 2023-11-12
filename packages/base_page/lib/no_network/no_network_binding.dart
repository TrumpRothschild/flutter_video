import 'package:get/get.dart';

import 'no_network_controller.dart';

class NoNetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoNetworkcontroller());
  }
}
