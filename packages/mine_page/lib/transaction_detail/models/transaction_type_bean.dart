import 'dart:convert';

TransactionTypeBean transactionTypeFromJson(String str) =>
    TransactionTypeBean.fromJson(json.decode(str));

String transactionTypeToJson(TransactionTypeBean data) =>
    json.encode(data.toJson());

class TransactionTypeBean {
  TransactionTypeBean({
    this.code = -1,
    this.value = '',
    this.billTypes = const [],
  });

  final int code;
  final String value;
  final List<int> billTypes;

  factory TransactionTypeBean.fromJson(Map<String, dynamic> json) =>
      TransactionTypeBean(
        code: json["code"] as int? ?? -1,
        value: json["value"]?.toString() ?? '',
        billTypes: json["billTypes"] == null
            ? []
            : List<int>.from(json["billTypes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "value": value,
        "billTypes": List<dynamic>.from(billTypes.map((x) => x)),
      };
}
