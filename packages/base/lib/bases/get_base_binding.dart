import 'package:get/get_instance/src/bindings_interface.dart';

import '../commons/utils/log_utils.dart';

/// @date 2023/02/15  13:15
/// @author a-bert
/// @des binding基类

abstract class GetBaseBindings extends Bindings {
  @override
  void dependencies() {
    Log.d("GetBaseBindings dependencies");
  }
}
