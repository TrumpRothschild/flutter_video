import 'dart:ui';
import 'package:flutter/material.dart';

class StringUtil {

  // 邮箱判断
  static bool isEmail(String? input) {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    if (input == null || input.isEmpty) return false;
    return  RegExp(regexEmail).hasMatch(input);
  }

  // 纯数字
  static const String DIGIT_REGEX = "[0-9]+";

  // 含有数字
  static const String CONTAIN_DIGIT_REGEX = ".*[0-9].*";

  // 纯字母
  static const String LETTER_REGEX = "[a-zA-Z]+";

  // 包含字母
  static const String SMALL_CONTAIN_LETTER_REGEX = ".*[a-z].*";

  // 包含字母
  static const String BIG_CONTAIN_LETTER_REGEX = ".*[A-Z].*";

  // 包含字母
  static const String CONTAIN_LETTER_REGEX = ".*[a-zA-Z].*";

  // 纯中文
  static const String CHINESE_REGEX = "[\u4e00-\u9fa5]";

  // 仅仅包含字母和数字
  static const String LETTER_DIGIT_REGEX = "^[a-z0-9A-Z]+\$";
  static const String CHINESE_LETTER_REGEX = "([\u4e00-\u9fa5]+|[a-zA-Z]+)";
  static const String CHINESE_LETTER_DIGIT_REGEX =
      "^[a-z0-9A-Z\u4e00-\u9fa5]+\$";

  // 纯数字
  static bool isOnly(String? input) {
    if (input == null || input.isEmpty) return false;
    return RegExp(DIGIT_REGEX).hasMatch(input);
  }

  // 含有数字
  static bool hasDigit(String? input) {
    if (input == null || input.isEmpty) return false;
    return RegExp(CONTAIN_DIGIT_REGEX).hasMatch(input);
  }

  // 是否包含中文
  static bool isChinese(String? input) {
    if (input == null || input.isEmpty) return false;
    return  RegExp(CHINESE_REGEX).hasMatch(input);
  }

  ///value: 文本内容；fontSize : 文字的大小；fontWeight：文字权重；maxWidth：文本框的最大宽度；maxLines：文本支持最大多少行
  static Size boundingTextSize(String text, TextStyle style,  {int maxLines = 2^31, double maxWidth = double.infinity}) {
    if (text == null || text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: text, style: style), maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

}
