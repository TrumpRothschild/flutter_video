
import 'package:base/translations/zh-Hans//zh_cn_home_page.dart';
import 'package:base/translations/zh-Hans/zh_cn_base_page.dart';
import 'package:base/translations/zh-Hans/zh_cn_game_page.dart';
import 'package:base/translations/zh-Hans/zh_cn_mine_page.dart';
import 'package:base/translations/zh-Hans/zh_cn_wallet_page.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';

abstract class AppTranslation {
  static Map<String, Map<String, dynamic>> translations = {
    'zhHans':  {
      "basePage": basePageTranslations,
      "homePage": homePageTranslations,
      "gamePage": gamePageTranslations,
      "walletPage":walletPageTranslations,
      "minePage":minePageTranslations,
      "videoPage":videoPageTranslations
    }
  };

  static Map<String, dynamic>? _basePageLocalData() {
    var zhHans = translations["zhHans"];
    if (zhHans != null) {
      return zhHans["basePage"];
    }
    return null;

  }

  static Map<String, dynamic>?_gamePageLocalData() {

    var zhHans = translations["zhHans"];
    if (zhHans != null) {
      return zhHans["gamePage"];
    }

    return null;
  }

  static Map<String, dynamic>?_walletPageLocalData() {

    var zhHans = translations["zhHans"];
    if (zhHans != null) {
      return zhHans["walletPage"];
    }

    return null;
  }

  static Map<String, dynamic>?_minePageLocalData() {

    var zhHans = translations["zhHans"];
    if (zhHans != null) {
      return zhHans["minePage"];
    }

    return null;
  }

  static Map<String, dynamic>?_videoPageLocalData() {

    var zhHans = translations["zhHans"];
    if (zhHans != null) {
      return zhHans["videoPage"];
    }

    return null;
  }

  static Map<String, dynamic>?_homePageLocalData() {

    var zhHans = translations["zhHans"];
    if (zhHans != null) {
      return zhHans["homePage"];
    }
    return null;
  }


  static String? basePageString(String key) {
    final value = _basePageLocalData();
    if (value != null) {
      return value[key];
    }
    return null;
  }

  static String? gamePageString(String key) {
    final value = _gamePageLocalData();
    if (value != null) {
      return value[key];
    }
    return null;
  }


  static String? walletPageString(String key) {
    final value = _walletPageLocalData();
    if (value != null) {
      return value[key];
    }
    return null;
  }

  static String? minePageString(String key) {
    final value = _minePageLocalData();
    if (value != null) {
      return value[key];
    }
    return null;
  }

  static String? videoPageString(String key) {
    final value = _videoPageLocalData();
    if (value != null) {
      return value[key];
    }
    return '';
  }

  static String? homePageString(String key) {
    final value = _homePageLocalData();
    if (value != null) {
      return value[key];
    }
    return null;
  }
}