import 'dart:async';
import 'dart:io';
import 'package:base/app_config.dart';
import 'package:get/get.dart';

class NoNetworkcontroller extends GetxController {

  var subscription;

  @override
  void onInit() {
    super.onInit();
    AppConfig.releaseCount = 0;
  }

  @override
  void onClose() {
    subscription.cancel();
  }

  /// 如果已连接热点或VPN,此时断开根热点或VPN,此种方法也会返回true
  void checkInternet() async {
    bool connectionStatus;
    try {
      String host = "baidu.com"; //判断国内外，谷歌还是百度
      final result = await InternetAddress.lookup(host);
      print("result-- $result");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectionStatus = true;
        print("connected' $connectionStatus");
        Get.back();
      }
    } on SocketException catch (_) {
      connectionStatus = false;
      print("not connected $connectionStatus");
    }
  }

}
