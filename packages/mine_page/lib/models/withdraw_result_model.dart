// To parse this JSON data, do
//
//     final withdrawResultModel = withdrawResultModelFromJson(jsonString);

import 'dart:convert';

WithdrawResultModel withdrawResultModelFromJson(String str) =>
    WithdrawResultModel.fromJson(json.decode(str));

String withdrawResultModelToJson(WithdrawResultModel data) =>
    json.encode(data.toJson());

class WithdrawResultModel {
  WithdrawResultModel({
    this.bankName = '',
    this.bankNo = '',
    this.bankTail = '',
    this.cause = '',
    this.channel = 0,
    this.endTime,
    this.orderStatus = -1,
    this.startTime,
    this.withdrawAmt = 0,
    this.withdrawFee = 0,
    this.withdrawNo = '',
  });

  final String bankName;
  final String bankNo;
  // 到账银行卡尾号
  final String bankTail;
  // 取消、失败 原因
  final String cause;

  // 提现渠道 1银行卡
  final int channel;
  // 预期到账,打款,失败,取消时间
  final DateTime? endTime;
  // 提现订单状态: 1处理中,2完成,3失败,4取消,5申请中,6超时,7用户撤销
  final int orderStatus;
  final DateTime? startTime;
  final num withdrawAmt;
  final num withdrawFee;
  // 提现订单号
  final String withdrawNo;

  String get asteriskBankNo {
    if (bankNo.length < 15 || bankNo.length > 19) return bankNo;
    return bankNo.substring(0, 4) +
        '**** **** ****' +
        bankNo.substring(bankNo.length - 4);
  }

  factory WithdrawResultModel.fromJson(Map<String, dynamic> json) =>
      WithdrawResultModel(
        bankName: json["bankName"]?.toString() ?? '',
        bankNo: json["bankNo"]?.toString() ?? '',
        bankTail: json["bankTail"]?.toString() ?? '',
        cause: json["cause"]?.toString() ?? '',
        channel: json["channel"] as int? ?? -1,
        endTime: (json["endTime"]?.toString().isNotEmpty == true)
            ? DateTime.parse(json["endTime"])
            : null,
        orderStatus: json["orderStatus"] as int? ?? -1,
        startTime: (json["startTime"]?.toString().isNotEmpty == true)
            ? DateTime.parse(json["startTime"])
            : null,
        withdrawAmt: json["withdrawAmt"] as num? ?? 0,
        withdrawFee: json["withdrawFee"] as num? ?? 0,
        withdrawNo: json["withdrawNo"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "bankNo": bankNo,
        "bankTail": bankTail,
        "cause": cause,
        "channel": channel,
        "endTime": endTime,
        "orderStatus": orderStatus,
        "startTime": startTime,
        "withdrawAmt": withdrawAmt,
        "withdrawFee": withdrawFee,
        "withdrawNo": withdrawNo,
      };
}
