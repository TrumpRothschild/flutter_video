/// appVersion : ""
/// areaCode : ""
/// captchaKey : ""
/// channelCode : ""
/// countryCode : ""
/// flag : 0
/// imgCode : ""
/// inviteCode : ""
/// mobilePhone : ""
/// password : ""
/// smsCode : ""
/// wifiData : 0

class LoginParam {
  LoginParam({
    //app版本
    String? appVersion,
    //区号, 如+86
    String? areaCode,
    //图片标识 - 登录的第一次不需要输入图形校验码, 第二次就需要输入图形校验码
    String? captchaKey,
    //渠道码
    String? channelCode,
    //国家编号
    String? countryCode,
    //登录模式: 1短信验证码注册或登录 2表示密码登录 3表示注册 默认1
    num? flag,
    //图片验证码 - 登录的第一次不需要输入图形校验码, 第二次就需要输入图形校验码
    String? imgCode,
    //邀请码
    String? inviteCode,
    //注册的手机号
    String? mobilePhone,
    //密码 flag=2,3 必须输入密码
    String? password,
    //手机验证码, 如果是密码登录, 就不需要验证码
    String? smsCode,
    //使用手机wifi还是流量 其他设备为空, 只有手机生效, 0：wifi, 1:流量
    num? wifiData,
  }) {
    _appVersion = appVersion;
    _areaCode = areaCode;
    _captchaKey = captchaKey;
    _channelCode = channelCode;
    _countryCode = countryCode;
    _flag = flag;
    _imgCode = imgCode;
    _inviteCode = inviteCode;
    _mobilePhone = mobilePhone;
    _password = password;
    _smsCode = smsCode;
    _wifiData = wifiData;
  }

  LoginParam.fromJson(dynamic json) {
    _appVersion = json['appVersion'];
    _areaCode = json['areaCode'];
    _captchaKey = json['captchaKey'];
    _channelCode = json['channelCode'];
    _countryCode = json['countryCode'];
    _flag = json['flag'];
    _imgCode = json['imgCode'];
    _inviteCode = json['inviteCode'];
    _mobilePhone = json['mobilePhone'];
    _password = json['password'];
    _smsCode = json['smsCode'];
    _wifiData = json['wifiData'];
  }

  String? _appVersion;
  String? _areaCode;
  String? _captchaKey;
  String? _channelCode;
  String? _countryCode;
  num? _flag;
  String? _imgCode;
  String? _inviteCode;
  String? _mobilePhone;
  String? _password;
  String? _smsCode;
  num? _wifiData;

  LoginParam copyWith({
    String? appVersion,
    String? areaCode,
    String? captchaKey,
    String? channelCode,
    String? countryCode,
    num? flag,
    String? imgCode,
    String? inviteCode,
    String? mobilePhone,
    String? password,
    String? smsCode,
    num? wifiData,
  }) =>
      LoginParam(
        appVersion: appVersion ?? _appVersion,
        areaCode: areaCode ?? _areaCode,
        captchaKey: captchaKey ?? _captchaKey,
        channelCode: channelCode ?? _channelCode,
        countryCode: countryCode ?? _countryCode,
        flag: flag ?? _flag,
        imgCode: imgCode ?? _imgCode,
        inviteCode: inviteCode ?? _inviteCode,
        mobilePhone: mobilePhone ?? _mobilePhone,
        password: password ?? _password,
        smsCode: smsCode ?? _smsCode,
        wifiData: wifiData ?? _wifiData,
      );

  String? get appVersion => _appVersion;

  String? get areaCode => _areaCode;

  String? get captchaKey => _captchaKey;

  String? get channelCode => _channelCode;

  String? get countryCode => _countryCode;

  num? get flag => _flag;

  String? get imgCode => _imgCode;

  String? get inviteCode => _inviteCode;

  String? get mobilePhone => _mobilePhone;

  String? get password => _password;

  String? get smsCode => _smsCode;

  num? get wifiData => _wifiData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appVersion'] = _appVersion;
    map['areaCode'] = _areaCode;
    map['captchaKey'] = _captchaKey;
    map['channelCode'] = _channelCode;
    map['countryCode'] = _countryCode;
    map['flag'] = _flag;
    map['imgCode'] = _imgCode;
    map['inviteCode'] = _inviteCode;
    map['mobilePhone'] = _mobilePhone;
    map['password'] = _password;
    map['smsCode'] = _smsCode;
    map['wifiData'] = _wifiData;
    return map;
  }
}
