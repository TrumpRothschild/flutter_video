import 'package:base/commons/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

/// 基础的GetWidget
abstract class GetBaseWidget extends GetWidget {
  GetBaseWidget({Key? key}) : super(key: key) {
    Log.d("GetBaseView init");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
