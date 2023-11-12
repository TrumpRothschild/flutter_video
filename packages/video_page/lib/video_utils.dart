class VideoUtils {
  /// 喜欢数上万，则展示x万
  static String formatLikes(int likeNum) {
    if (likeNum > 10000) {
      return "${(likeNum / 10000).toStringAsFixed(1)}万";
    } else {
      return likeNum.toString();
    }
  }

  /// 格式化时间
  static String formatDuration(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = (seconds % 3600) ~/ 60;
    int second = seconds % 60;

    String hourStr = (hour < 10) ? '0$hour' : '$hour';
    String minuteStr = (minute < 10) ? '0$minute' : '$minute';
    String secondStr = (second < 10) ? '0$second' : '$second';

    if (hour == 0) {
      return '00:$minuteStr:$secondStr';
    } else {
      return '$hourStr:$minuteStr:$secondStr';
    }
  }
}
