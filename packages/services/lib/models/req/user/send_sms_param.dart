/// areaCode : ""
/// captchaKey : ""
/// imgCode : ""
/// phone : ""
/// sendType : 0

class SendSmsParam {
  SendSmsParam({
      String? areaCode, 
      String? captchaKey, 
      String? imgCode, 
      String? phone,
    //[必填]验证码类型：1-注册且登录 对应前端的/registerAndLogin接口、2-更新密码,重置/找回登录密、3-绑定手机、4-找回支付密码,重置支付密码,忘记支付密码、5-提现、6-绑定银行卡、 7-登录 /login 接口
      num? sendType,}){
    _areaCode = areaCode;
    _captchaKey = captchaKey;
    _imgCode = imgCode;
    _phone = phone;
    _sendType = sendType;
}

  SendSmsParam.fromJson(dynamic json) {
    _areaCode = json['areaCode'];
    _captchaKey = json['captchaKey'];
    _imgCode = json['imgCode'];
    _phone = json['phone'];
    _sendType = json['sendType'];
  }
  String? _areaCode;
  String? _captchaKey;
  String? _imgCode;
  String? _phone;
  num? _sendType;
SendSmsParam copyWith({  String? areaCode,
  String? captchaKey,
  String? imgCode,
  String? phone,
  num? sendType,
}) => SendSmsParam(  areaCode: areaCode ?? _areaCode,
  captchaKey: captchaKey ?? _captchaKey,
  imgCode: imgCode ?? _imgCode,
  phone: phone ?? _phone,
  sendType: sendType ?? _sendType,
);
  String? get areaCode => _areaCode;
  String? get captchaKey => _captchaKey;
  String? get imgCode => _imgCode;
  String? get phone => _phone;
  num? get sendType => _sendType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['areaCode'] = _areaCode;
    map['captchaKey'] = _captchaKey;
    map['imgCode'] = _imgCode;
    map['phone'] = _phone;
    map['sendType'] = _sendType;
    return map;
  }

}