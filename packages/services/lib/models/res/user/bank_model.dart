/// bankAccid : 0
/// bankAccountName : ""
/// bankAccountNo : ""
/// bankAddress : ""
/// bankCode : ""
/// bankLogo : ""
/// bankName : ""
/// createTime : ""
/// isDefault : 0

class BankModel {
  BankModel({
    this.bankAccid,
    this.bankAccountName,
    this.bankAccountNo,
    this.bankAddress,
    this.bankCode,
    this.bankLogo,
    this.bankName,
    this.createTime,
    this.isDefault,
  });

  BankModel.fromJson(dynamic json) {
    bankAccid = json['bankAccid'];
    bankAccountName = json['bankAccountName'];
    bankAccountNo = json['bankAccountNo'];
    bankAddress = json['bankAddress'];
    bankCode = json['bankCode'];
    bankLogo = json['bankLogo'];
    bankName = json['bankName'];
    createTime = json['createTime'];
    isDefault = json['isDefault'];
  }

  int? bankAccid;
  String? bankAccountName;
  String? bankAccountNo;
  String? bankAddress;
  String? bankCode;
  String? bankLogo;
  String? bankName;
  dynamic createTime;
  int? isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bankAccid'] = bankAccid;
    map['bankAccountName'] = bankAccountName;
    map['bankAccountNo'] = bankAccountNo;
    map['bankAddress'] = bankAddress;
    map['bankCode'] = bankCode;
    map['bankLogo'] = bankLogo;
    map['bankName'] = bankName;
    map['createTime'] = createTime;
    map['isDefault'] = isDefault;
    return map;
  }
}
