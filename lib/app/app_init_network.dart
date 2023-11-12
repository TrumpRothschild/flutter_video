import 'dart:async';
import 'dart:developer';

import 'package:base/app_config.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class AppNetWork {
  static final shared = AppNetWork();

  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
  }

  void initNetWork() async {
    /// 处理网络
    final Connectivity _connectivity = Connectivity();
    late StreamSubscription<ConnectivityResult> _connectivitySubscription;

    late ConnectivityResult result;

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.bluetooth) {
        AppConfig.networkType = "bluetooth";
      }
      else if (result == ConnectivityResult.wifi) {
        AppConfig.networkType = "wifi";
      }
      else if (result == ConnectivityResult.ethernet) {
        AppConfig.networkType = "ethernet";
      }
      else if (result == ConnectivityResult.mobile) {
        AppConfig.networkType =  "mobile";
      }
      else if (result == ConnectivityResult.vpn) {
        AppConfig.networkType =  "vpn";
      }
      else {
        AppConfig.networkType =  "unKnow";
      }

    } on PlatformException catch (e) {
      log("error $e");
    }
    _updateConnectionStatus(result);
  }



}