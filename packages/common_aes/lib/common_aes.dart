
import 'dart:async';

import 'package:flutter/services.dart';

class CommonAes {

  static const MethodChannel _channel =
  MethodChannel('common_aes');

  /// Get device system version.
  ///
  /// * If it is a Android device, like 'Android 9.0'.
  /// * If it is a IOS device, like 'IOS 11.2'.
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


  /// Encrypts the [txt] with the given [key].
  ///
  /// The result of the encryption will be encoded by HEX.
  /// [txt] and [key] shoudn't be null.
  static Future<String?> encryptString(String txt, String key) async {
    try {
      final String? result =
      await _channel.invokeMethod('encrypt', {"input": txt, "key": key});
      return result;
    } on PlatformException catch (e) {
      throw "Failed to get string encoded: '${e.message}'.";
    }
  }

  /// Decrypts the [txt] with the given [key].
  ///
  /// The content [txt] that needs to be decrypted must be HEX encoded，key also.
  /// [txt] and [key] shoudn't be null.
  static Future<String?> decryptString(String txt, String key) async {
    try {
      final String? result =
      await _channel.invokeMethod('decrypt', {"input": txt, "key": key});
      return result;
    } on PlatformException catch (e) {
      throw "Failed to get string encoded: '${e.message}'.";
    }
  }

}
