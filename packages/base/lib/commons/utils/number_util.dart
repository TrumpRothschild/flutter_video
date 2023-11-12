
class NumberUtil {

  /// target  要转换的数字
  /// postion 要保留的位数
  /// isCrop  true 直接裁剪 false 四舍五入
  static String formatNum(num target, int position, {bool isCrop = false}) {
    String t = target.toString();
    // 如果要保留的长度小于等于0 直接返回当前字符串
    if (position < 0) {
      return t;
    }
    if (t.contains(".")) {
      String t1 = t.split(".").last;
      if (t1.length >= position) {
        if (isCrop) {
          // 直接裁剪
          return t.substring(0, t.length - (t1.length - position));
        } else {
          // 四舍五入
          return target.toStringAsFixed(position);
        }
      } else {
        // 不够位数的补相应个数的0
        String t2 = "";
        for (int i = 0; i < position - t1.length; i++) {
          t2 += "0";
        }
        return t + t2;
      }
    } else {
      // 不含小数的部分补点和相应的0
      String t3 = position > 0 ? "." : "";
      for (int i = 0; i < position; i++) {
        t3 += "0";
      }
      return t + t3;
    }
  }
}