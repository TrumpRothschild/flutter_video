import 'package:get/get.dart';

import 'customer_service_controller.dart';

/// 登录binding
class CustomerServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerServiceController>(() => CustomerServiceController());
  }
}
