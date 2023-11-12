import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  /// app全局配置
  static SharedPreferences? sp;

  /// 必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    sp = await SharedPreferences.getInstance();
  }


  static getNum() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? num = preferences.getString('num');
    return num;
  }

  static setNum(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('num', text);
  }

  static getFirst() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? splashFlag = preferences.getString('splashFlag');
    return Future.value(splashFlag);
  }

  static setFirst(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('splashFlag', text);
  }

  static Future<String> getDomain() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String domain = preferences.getString('domain') ?? "";
    return Future.value(domain);
  }

  static setDomain(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('domain', text);
  }

  static getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    return Future.value(token);
  }

  static setToken(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', text);
  }

  static getIsFamily() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? token = preferences.getBool('isFamily');
    return Future.value(token);
  }

  static setIsFamily(bool text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isFamily', text);
  }

  static setUserId(int text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userId', text.toString());
  }

  static getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    return Future.value(userId);
  }

  static setUUId(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('uuid', text.toString());
  }

  static getUUId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('uuid');
    return Future.value(userId);
  }

  static getPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? phone = preferences.getString('phone');
    return Future.value(phone);
  }
  static setPhone(String p) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('phone', p);
  }

  static getSessionId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? sessionId = preferences.getString('sessionId');
    return Future.value(sessionId);
  }

  static Future<int> getHostIndex() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? index = preferences.getInt("hostIndex");
    if (index == null) {
      await serHostIndex(0);
      return 0;
    }
    return Future.value(index);
  }

  static serHostIndex(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt("hostIndex", index);
  }

  /*
   * 存储数据
   */
  // ignore: unused_element
  Future _set(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  /*
   * 读取数据
   */
  // ignore: unused_element
  Future _get(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Object? account = preferences.get(key);
    return Future.value(account);
  }

  /*
   * 删除数据
   */
  // ignore: unused_element
  Future _remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
}
