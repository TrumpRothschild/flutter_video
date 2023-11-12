import 'package:base/commons/utils/log_utils.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';

import 'get_base_controller.dart';

/// 基础的GetBuilder
abstract class GetBaseBuilder<T extends GetXBaseController>
    extends GetBuilder<T> {
  GetBaseBuilder(
      {Key? key, required GetControllerBuilder<GetXBaseController> builder})
      : super(key: key, builder: builder) {
    Log.d("GetBaseBuilder init");
  }
}
