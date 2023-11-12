class PublicConfig {
  PublicConfig({
    required this.balanceUnit,
    required this.countryCode,
    required this.czExchange,
    required this.exchange,
    required this.freeWatch,
    required this.gamblingSwitchAll,
    required this.goldUnit,
    required this.onlineServiceUrl,
    required this.potato,
    required this.shareLink,
    required this.shareLinkParamName,
    required this.silverBeanUnit,
    required this.telegram,
    required this.txExchange,
    required this.userAdvancedLevel,
  });

  String balanceUnit;
  String countryCode;
  String czExchange;
  String exchange;
  int freeWatch;
  int gamblingSwitchAll;
  String goldUnit;
  String onlineServiceUrl;
  String potato;
  String shareLink;
  String shareLinkParamName;
  String silverBeanUnit;
  String telegram;
  String txExchange;
  int userAdvancedLevel;

  factory PublicConfig.fromJson(Map<String, dynamic> json) => PublicConfig(
    balanceUnit: json["balanceUnit"],
    countryCode: json["countryCode"],
    czExchange: json["czExchange"],
    exchange: json["exchange"],
    freeWatch: json["freeWatch"],
    gamblingSwitchAll: json["gamblingSwitchAll"],
    goldUnit: json["goldUnit"],
    onlineServiceUrl: json["onlineServiceUrl"],
    potato: json["potato"],
    shareLink: json["shareLink"],
    shareLinkParamName: json["shareLinkParamName"],
    silverBeanUnit: json["silverBeanUnit"],
    telegram: json["telegram"],
    txExchange: json["txExchange"],
    userAdvancedLevel: json["userAdvancedLevel"],
  );

  Map<String, dynamic> toJson() => {
    "balanceUnit": balanceUnit,
    "countryCode": countryCode,
    "czExchange": czExchange,
    "exchange": exchange,
    "freeWatch": freeWatch,
    "gamblingSwitchAll": gamblingSwitchAll,
    "goldUnit": goldUnit,
    "onlineServiceUrl": onlineServiceUrl,
    "potato": potato,
    "shareLink": shareLink,
    "shareLinkParamName": shareLinkParamName,
    "silverBeanUnit": silverBeanUnit,
    "telegram": telegram,
    "txExchange": txExchange,
    "userAdvancedLevel": userAdvancedLevel,
  };
}