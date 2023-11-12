import 'package:base/commons/utils/app_date_utils.dart';

/// balanceIncome : 0
/// balanceOutcome : 0
/// detailList : [{"amount":0,"billType":0,"changeTypeName":"","createTime":"","id":0,"orderNO":"","orderStatus":0,"projectName":"","transactionTypeName":""}]
/// goldIncome : 0
/// goldOutcome : 0
/// silverIncome : 0
/// silverOutcome : 0

class GameTransactionModel {
  GameTransactionModel({
    this.balanceIncome,
    this.balanceOutcome,
    this.detailList,
    this.goldIncome,
    this.goldOutcome,
    this.silverIncome,
    this.silverOutcome,
  });

  GameTransactionModel.fromJson(dynamic json) {
    balanceIncome = json['balanceIncome'];
    balanceOutcome = json['balanceOutcome'];
    if (json['detailList'] != null) {
      detailList = [];
      json['detailList'].forEach((v) {
        detailList?.add(DetailList.fromJson(v));
      });
    }
    goldIncome = json['goldIncome'];
    goldOutcome = json['goldOutcome'];
    silverIncome = json['silverIncome'];
    silverOutcome = json['silverOutcome'];
  }

  num? balanceIncome;
  num? balanceOutcome;
  List<DetailList>? detailList;
  num? goldIncome;
  num? goldOutcome;
  num? silverIncome;
  num? silverOutcome;

  GameTransactionModel copyWith({
    num? balanceIncome,
    num? balanceOutcome,
    List<DetailList>? detailList,
    num? goldIncome,
    num? goldOutcome,
    num? silverIncome,
    num? silverOutcome,
  }) =>
      GameTransactionModel(
        balanceIncome: balanceIncome ?? this.balanceIncome,
        balanceOutcome: balanceOutcome ?? this.balanceOutcome,
        detailList: detailList ?? this.detailList,
        goldIncome: goldIncome ?? this.goldIncome,
        goldOutcome: goldOutcome ?? this.goldOutcome,
        silverIncome: silverIncome ?? this.silverIncome,
        silverOutcome: silverOutcome ?? this.silverOutcome,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balanceIncome'] = balanceIncome;
    map['balanceOutcome'] = balanceOutcome;
    if (detailList != null) {
      map['detailList'] = detailList?.map((v) => v.toJson()).toList();
    }
    map['goldIncome'] = goldIncome;
    map['goldOutcome'] = goldOutcome;
    map['silverIncome'] = silverIncome;
    map['silverOutcome'] = silverOutcome;
    return map;
  }
}

/// amount : 0
/// billType : 0
/// changeTypeName : ""
/// createTime : ""
/// id : 0
/// orderNO : ""
/// orderStatus : 0
/// projectName : ""
/// transactionTypeName : ""

class DetailList {
  DetailList({
    this.amount,
    this.billType,
    this.changeTypeName,
    this.createTime,
    this.id,
    this.orderNO,
    this.orderStatus,
    this.projectName,
    this.transactionTypeName,
  });

  DetailList.fromJson(dynamic json) {
    amount = json['amount'];
    billType = json['billType'];
    changeTypeName = json['changeTypeName'];
    createTime = json['createTime']?.toString().isNotEmpty == true
        ? DateTime.parse(json['createTime'])
        : null;
    id = json['id'];
    orderNO = json['orderNO'];
    orderStatus = json['orderStatus'];
    projectName = json['projectName'];
    transactionTypeName = json['transactionTypeName'];
  }

  double? amount;

  /// 变动货币 1余额,2金币,3钻石
  int? billType;
  String? changeTypeName;
  DateTime? createTime;
  int? id;
  String? orderNO;
  int? orderStatus;
  String? projectName;
  String? transactionTypeName;

  String get valideAmount {
    if (amount == null) return '';
    switch (billType) {
      case 1:
      case 2:
        return amount?.toStringAsFixed(2) ?? '';
      case 3:
        return amount?.toStringAsFixed(0) ?? '';
      default:
        return '$amount';
    }
  }

  String get createTimeFormatter {
    if (createTime == null) return '';
    return AppDateUtils.formatYmdthms(createTime!.toLocal());
  }

  bool get canCancel => orderStatus == 1 || orderStatus == 5;

  String get billTypeName {
    switch (billType) {
      case 1:
        return '余额';
      case 2:
        return '金币';
      case 3:
        return '钻石';
    }
    return '';
  }

  String get stateName {
    //1处理中，2成功，3失败，4取消，5申请中，6超时，7撒单
    switch (orderStatus) {
      case 1:
        return '处理中';
      case 2:
        return '成功';
      case 3:
        return '失败';
      case 4:
        return '取消';
      case 5:
        return '申请中';
      case 6:
        return '超时';
      case 7:
        return '撒单';
    }
    return '';
  }

  int get stateColor {
    //1处理中，2成功，3失败，4取消，5申请中，6超时，7撒单
    switch (orderStatus) {
      case 1:
        return 0xFFFF855F;
      case 2:
        return 0xFF9F44FF;
      case 3:
        return 0xFF979797;
      case 4:
        return 0xFF979797;
      case 5:
        return 0xFF979797;
      case 6:
        return 0xFF979797;
      case 7:
        return 0xFF979797;
    }
    return 0xFF979797;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['billType'] = billType;
    map['changeTypeName'] = changeTypeName;
    map['createTime'] = createTime?.toIso8601String();
    map['id'] = id;
    map['orderNO'] = orderNO;
    map['orderStatus'] = orderStatus;
    map['projectName'] = projectName;
    map['transactionTypeName'] = transactionTypeName;
    return map;
  }
}
