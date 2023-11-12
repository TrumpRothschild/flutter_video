// ignore: avoid_print
import 'ticket_function_bean.dart';

class TicketUtils {
  static int getTicketId(String? gameCode) {
    if (gameCode != null && gameCode.isNotEmpty) {
      try {
        List<String> items = gameCode.split("_");
        return int.parse(items[items.length - 1]);
      } catch (e) {
        print(e);
      }
    }
    return -1;
  }

  static String? getGameTypeByCode(String? code) {
    if (code != null && code.isNotEmpty) {
      List<String> result = code.split('_');
      return result[result.length - 1];
    }
    return null;
  }

  static String getTicketName(String? gameCode) {
    int ticketId = getTicketId(gameCode);
    switch (ticketId) {
      case 1:
        return '百人牛牛';
      case 2:
        return '鱼虾蟹';
      case 3:
        return '龙虎斗';
      case 4:
        return '百家乐';
      case 5:
        return '一分快三';
      case 6:
        return '一分时时彩';
      case 7:
        return '一分六合彩';
      case 8:
        return '一分快车';
      default:
        return '';
    }
  }

  static String getTicketNameById(num? ticketId) {
    switch (ticketId) {
      case 1:
        return '百人牛牛';
      case 2:
        return '鱼虾蟹';
      case 3:
        return '龙虎斗';
      case 4:
        return '百家乐';
      case 5:
        return '一分快三';
      case 6:
        return '一分时时彩';
      case 7:
        return '一分六合彩';
      case 8:
        return '一分快车';
      default:
        return '';
    }
  }

  static String getYXXNameByODDS(String? odds) {
    StringBuffer sb = StringBuffer("");
    if (odds?.isNotEmpty ?? false) {
      List<String> result = odds!.split(",");
      for (String s in result) {
        if (sb.isNotEmpty) {
          sb.write(",");
        }
        if (s == "1") {
          sb.write("鱼");
        } else if (s == "2") {
          sb.write("虾");
        } else if (s == "3") {
          sb.write("葫芦");
        } else if (s == "4") {
          sb.write("金钱");
        } else if (s == "5") {
          sb.write("蟹");
        } else if (s == "6") {
          sb.write("鸡");
        }
      }
    }
    return sb.toString();
  }

  static String getCountDownTime(int? time) {
    if (time == null || time <= 0) {
      return "00:00";
    }
    int m = time ~/ 60;
    int s = time % 60;
    return (m > 9 ? m.toString() : "0$m") +
        ":" +
        (s > 9 ? s.toString() : "0$s");
  }

  static int getPoints(String? result) {
    if (result != null && result.isNotEmpty) {
      int item = int.parse(result);
      if (item < 0 || item > 54) {
        return 0;
      } else if (item > 0 && item < 11) {
        return item;
      } else if (item > 13 && item < 24) {
        return item - 13;
      } else if (item > 26 && item < 37) {
        return item - 26;
      } else if (item > 39 && item < 50) {
        return item - 39;
      } else {
        return 10;
      }
    }
    return 0;
  }

  static int getRealPoints(String? result) {
    if (result != null && result.isNotEmpty) {
      int item = int.parse(result);
      if (item < 0 || item > 54) {
        return 0;
      } else if (item > 0 && item < 14) {
        return item;
      } else if (item > 13 && item < 27) {
        return item - 13;
      } else if (item > 26 && item < 40) {
        return item - 26;
      } else if (item > 39 && item < 53) {
        return item - 39;
      }
    }
    return 0;
  }

  static TicketFunctionBean getResultImage(int type, String lastKjNumber) {
    TicketFunctionBean item = TicketFunctionBean();
    List<String> items1 = [];
    List<String> items2 = [];
    List<int> items3 = [];
    if (type != 0 && type != 1) {
      type = 0;
    }
    try {
      List<String> result = lastKjNumber.split(",");
      int start = 0;
      int end = 5;
      if (type == 1) {
        start = 6;
        end = 11;
      }
      for (int i = start; i < end; i++) {
        items1.add(result[i]);
        items2.add('assets/game_page/live_game/card_${result[i]}.png');
        items3.add(getPoints(result[i]));
      }
      start = 5;
      if (type == 1) {
        start = 11;
      }
      int win = int.parse(result[result.length - 1]);
      if (win == 2) {
        item.winType = 2;
      } else if (win == 0) {
        if (type == 0) {
          item.winType = 1;
        } else {
          item.winType = 0;
        }
      } else {
        if (type == 0) {
          item.winType = 0;
        } else {
          item.winType = 1;
        }
      }
      item.results = items1;
      item.pointData = items3;
      item.resourceIds = items2;
      String statusName = result[start].split("-")[0];
      item.statusName = statusName;
      item.statusNameResourceId = getBNRRResultImage(statusName);
      if (statusName.startsWith("炸")) {
        // TODO
      } else if (statusName.startsWith("金牛") || statusName.startsWith("牛牛")) {
        // TODO
      }
    } catch (e) {
      print(e);
    }
    return item;
  }

  static String getBNRRResultImage(String statusName) {
    if (statusName.isNotEmpty) {
      if (statusName == "炸") {
        return 'assets/game_page/live_game/card_n_14.png';
      } else if (statusName == "银牛") {
        return 'assets/game_page/live_game/card_n_13.png';
      } else if (statusName == "牛牛") {
        return 'assets/game_page/live_game/card_n_12.png';
      } else if (statusName == "金牛") {
        return 'assets/game_page/live_game/card_n_11.png';
      } else if (statusName == "金色牛") {
        return 'assets/game_page/live_game/card_n_10.png';
      } else if (statusName == "无牛") {
        return 'assets/game_page/live_game/card_n_0.png';
      } else if (statusName.contains("牛")) {
        String position = statusName.replaceFirst("牛", "");
        return 'assets/game_page/live_game/card_n_$position.png';
      }
    }
    return 'assets/game_page/live_game/card_n_0.png';
  }

  static List<String> getLHDResultImage(String lastKjNumber) {
    List<String> items = List.generate(
        2, (index) => 'assets/game_page/live_game/card_default.png');

    List<String> result = lastKjNumber.split(",");
    if (result.length == 2) {
      for (int i = 0; i < result.length && i < items.length; i++) {
        items[i] = 'assets/game_page/live_game/card_${result[i]}.png';
      }
    }
    return items;
  }

  static int getLHDResultPoint(int type, String lastKjNumber) {
    try {
      List<String> result = lastKjNumber.split(",");
      if (0 == type) {
        return getRealPoints(result[0]);
      } else {
        return getRealPoints(result[1]);
      }
    } catch (e) {
      print(e.toString());
    }

    return 0;
  }

  static TicketFunctionBean getBJLResultImage(int type, String lastKjNumber) {
    TicketFunctionBean item = TicketFunctionBean();
    List<String> items = [];
    try {
      List<String> result = lastKjNumber.split(",");
      if (0 == type) {
        items.add('assets/game_page/live_game/card_${result[0]}.png');
        items.add('assets/game_page/live_game/card_${result[1]}.png');
        if ('0' != result[2]) {
          items.add('assets/game_page/live_game/card_${result[2]}.png');
        }
        item.statusName = result[3] + '点';
        item.bjlPoint = int.parse(result[3]);
        item.statusNameResourceId =
            'assets/game_page/live_game/card_b_${result[3]}.png';
      } else {
        items.add('assets/game_page/live_game/card_${result[4]}.png');
        items.add('assets/game_page/live_game/card_${result[5]}.png');
        if ('0' != result[6]) {
          items.add('assets/game_page/live_game/card_${result[6]}.png');
        }
        item.statusName = result[7] + '点';
        item.bjlPoint = int.parse(result[7]);
        item.statusNameResourceId =
            'assets/game_page/live_game/card_b_${result[7]}.png';
      }
      item.resourceIds = items;
    } catch (e) {
      print(e);
    }
    return item;
  }

  static TicketFunctionBean getResultImageYFKS(String lastKjNumber) {
    TicketFunctionBean item = TicketFunctionBean();
    List<String> result = lastKjNumber.split(",");
    List<String> items = [];
    List<String> items2 = [];
    int sum = 0;
    for (String s in result) {
      items.add('assets/game_page/live_game/dice_$s.webp');
      sum += int.parse(s);
    }
    item.resourceIds = items;
    items2.add('$sum');
    if (sum % 2 == 0) {
      items2.add('assets/game_page/live_game/dice_double.png');
    } else {
      items2.add('assets/game_page/live_game/dice_single.png');
    }
    if (sum > 10) {
      items2.add('assets/game_page/live_game/dice_big.png');
    } else {
      items2.add('assets/game_page/live_game/dice_small.png');
    }
    item.resourceIds2 = items2;
    return item;
  }

  static TicketFunctionBean getResultImageYFKC(String lastKjNumber) {
    TicketFunctionBean item = TicketFunctionBean();
    List<String> result = lastKjNumber.split(",");
    List<String> items = [];
    List<String> items2 = [];
    int sum = 0;
    for (String s in result) {
      items.add('assets/game_page/live_game/yfkc_$s.png');
    }
    item.resourceIds = items;
    int t1 = int.parse(result[0]);
    int t5 = int.parse(result[1]);
    sum = t1 + t5;
    items2.add('$sum');
    if (sum >= 12) {
      items2.add('assets/game_page/live_game/ssc_big.png');
    } else {
      items2.add('assets/game_page/live_game/ssc_small.png');
    }
    if (sum % 2 == 0) {
      items2.add('assets/game_page/live_game/ssc_double.png');
    } else {
      items2.add('assets/game_page/live_game/ssc_single.png');
    }
    item.resourceIds2 = items2;
    return item;
  }

  static TicketFunctionBean getResultImageYFSSC(String lastKjNumber) {
    TicketFunctionBean item = TicketFunctionBean();
    List<String> items = [];
    List<String> items2 = [];
    int sum = 0;
    List<String> result = lastKjNumber.split(',');
    for (var s in result) {
      items.add(s);
      sum += int.parse(s);
    }
    item.resourceIds = items;
    items2.add('$sum');
    if (sum >= 23) {
      items2.add('assets/game_page/live_game/ssc_big.png');
    } else {
      items2.add('assets/game_page/live_game/ssc_small.png');
    }
    if (sum % 2 == 0) {
      items2.add('assets/game_page/live_game/ssc_double.png');
    } else {
      items2.add('assets/game_page/live_game/ssc_single.png');
    }
    int t1 = int.parse(result[0]);
    int t5 = int.parse(result[4]);
    if (t1 == t5) {
      items2.add('和');
    } else if (t1 > t5) {
      items2.add('assets/game_page/live_game/ssc_dragon.png');
    } else {
      items2.add('assets/game_page/live_game/ssc_tiger.png');
    }
    item.resourceIds2 = items2;
    return item;
  }

  static List<String> getYXXResultImage(String lastKjNumber) {
    List<String> items = [];
    try {
      List<String> result = lastKjNumber.split(",");
      for (String s in result) {
        items.add('assets/game_page/live_game/yxx_$s.webp');
      }
    } catch (e) {
      print(e);
    }
    return items;
  }

  static TicketFunctionBean getResultImageYFLHC(
      String lastKjNumber, String year) {
    TicketFunctionBean item = TicketFunctionBean();
    List<String> result = lastKjNumber.split(",");
    List<String> items = [];
    List<String> items2 = [];
    for (String s in result) {
      items.add('assets/game_page/live_game/lhc_$s.webp');
    }
    if (items.isNotEmpty) {
      items.insert(
          result.length - 1, 'assets/game_page/live_game/lhc_add.webp');
    }

    item.resourceIds = items;
    int sum = int.parse(result[result.length - 1]);
    items2.add(result[result.length - 1]);
    if (sum == 49) {
      items2.add("退");
    } else if (sum >= 25) {
      items2.add('assets/game_page/live_game/ssc_big.png');
    } else {
      items2.add('assets/game_page/live_game/ssc_small.png');
    }
    if (sum == 49) {
      items2.add("退");
    } else if (sum % 2 == 0) {
      items2.add('assets/game_page/live_game/ssc_double.png');
    } else {
      items2.add('assets/game_page/live_game/ssc_single.png');
    }

    items2.add(getResourceIdBySize(sum));
    items2.add(getSXbySize(sum, year));
    item.resourceIds2 = items2;
    return item;
  }

  static String getResourceIdBySize(int size) {
    String type = 'assets/game_page/live_game/lhc_green.webp';
    switch (size) {
      case 1:
      case 2:
      case 7:
      case 8:
      case 12:
      case 13:
      case 18:
      case 19:
      case 23:
      case 24:
      case 29:
      case 30:
      case 34:
      case 35:
      case 40:
      case 45:
      case 46:
        type = 'assets/game_page/live_game/lhc_red.webp';
        break;
      case 3:
      case 4:
      case 9:
      case 10:
      case 14:
      case 15:
      case 20:
      case 25:
      case 26:
      case 31:
      case 36:
      case 37:
      case 41:
      case 42:
      case 47:
      case 48:
        type = 'assets/game_page/live_game/lhc_blue.webp';
        break;
    }
    return type;
  }

  static String getSXbySize(int lastKjNo, String year) {
    int index = 0;
    if (lastKjNo == 1 ||
        lastKjNo == 13 ||
        lastKjNo == 25 ||
        lastKjNo == 37 ||
        lastKjNo == 49) {
      index = 0;
    } else if (lastKjNo == 12 ||
        lastKjNo == 24 ||
        lastKjNo == 36 ||
        lastKjNo == 48) {
      index = 1;
    } else if (lastKjNo == 11 ||
        lastKjNo == 23 ||
        lastKjNo == 35 ||
        lastKjNo == 47) {
      index = 2;
    } else if (lastKjNo == 10 ||
        lastKjNo == 22 ||
        lastKjNo == 34 ||
        lastKjNo == 46) {
      index = 3;
    } else if (lastKjNo == 9 ||
        lastKjNo == 21 ||
        lastKjNo == 33 ||
        lastKjNo == 45) {
      index = 4;
    } else if (lastKjNo == 8 ||
        lastKjNo == 20 ||
        lastKjNo == 32 ||
        lastKjNo == 44) {
      index = 5;
    } else if (lastKjNo == 7 ||
        lastKjNo == 19 ||
        lastKjNo == 31 ||
        lastKjNo == 43) {
      index = 6;
    } else if (lastKjNo == 6 ||
        lastKjNo == 18 ||
        lastKjNo == 30 ||
        lastKjNo == 42) {
      index = 7;
    } else if (lastKjNo == 5 ||
        lastKjNo == 17 ||
        lastKjNo == 29 ||
        lastKjNo == 41) {
      index = 8;
    } else if (lastKjNo == 4 ||
        lastKjNo == 16 ||
        lastKjNo == 28 ||
        lastKjNo == 40) {
      index = 9;
    } else if (lastKjNo == 3 ||
        lastKjNo == 15 ||
        lastKjNo == 27 ||
        lastKjNo == 39) {
      index = 10;
    } else if (lastKjNo == 2 ||
        lastKjNo == 14 ||
        lastKjNo == 26 ||
        lastKjNo == 38) {
      index = 11;
    }
    List<String>? newYears = getZodiacByYear(year);
    if (null == newYears) {
      return "-";
    }
    return newYears[index];
  }

  static List<String>? getZodiacByYear(String year) {
    int tmpYear = int.tryParse(year) ?? DateTime.now().year;
    if (tmpYear < 1900) {
      print("==未知年==");
      return null;
    }
    int start = 1900;
    List<String> years = [
      "鼠",
      "牛",
      "虎",
      "兔",
      "龙",
      "蛇",
      "马",
      "羊",
      "猴",
      "鸡",
      "狗",
      "猪"
    ];
    int curIndex = (tmpYear - start) % years.length;
    // 当年生肖的顺序
    int length = years.length;
    if (curIndex == 0) {
      return years;
    }
    List<String> tmpYears = years.sublist(0, curIndex);
    List<String> newYears = List.filled(length, "");
    int index = 0;
    for (int i = 0; i < years.length; i++) {
      if (curIndex + i > length - 1) {
        break;
      }
      newYears[index] = years[curIndex + i];
      index++;
    }
    for (String tmp in tmpYears) {
      newYears[index] = tmp;
      index++;
    }
    return newYears;
  }
}
