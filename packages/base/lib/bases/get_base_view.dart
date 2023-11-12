import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

/// 基础的GetView
abstract class GetBaseView<T> extends GetView<T> {
  const GetBaseView({Key? key}) : super(key: key);
}
