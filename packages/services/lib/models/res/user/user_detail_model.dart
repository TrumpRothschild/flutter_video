///我的用户详细信息
class UserDetailModel {
  String? registerCountryCode;
  String? birthday;
  String? nickName;
  int? focusNum;
  String? registerArea;
  int? sex;
  String? personalSignature;
  String? accno;
  int? maritalStatus;
  bool? isOpenLive;
  String? mobilePhone;
  int? userType; // 0-普通用户 、1-游客用户、2-主播、3-家族长
  String? occupationCode;
  String? occupationName;
  int? userLevel;
  String? userAccount;
  int? fansNum;
  String? registerAreaCode;
  int? id;
  int? userId;
  bool? isLoginPassword;
  bool? nickNameStatus;
  String? firepower;
  bool? isPayPassword;
  String? avatar;
  String? hometown;

  String get gender {
    switch (sex) {
      case 1:
        return '男';
      case 2:
        return '女';
      default:
        return '保密';
    }
  }

  String get emotion {
    switch (maritalStatus) {
      case 1:
        return '单身';
      case 2:
        return '恋爱';
      case 3:
        return '已婚';
      default:
        return '保密';
    }
  }

  UserDetailModel(
      {registerCountryCode,
      birthday,
      nickName,
      focusNum,
      registerArea,
      sex,
      personalSignature,
      accno,
      maritalStatus,
      isOpenLive,
      mobilePhone,
      userType,
      occupationCode,
      occupationName,
      userLevel,
      userAccount,
      fansNum,
      registerAreaCode,
      id,
      userId,
      isLoginPassword,
      nickNameStatus,
      firepower,
      isPayPassword,
      avatar,
      hometown});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    registerCountryCode = json['registerCountryCode'].toString();
    birthday = json['birthday'].toString();
    nickName = json['nickName'].toString();
    focusNum = int.parse(json['focusNum'].toString());
    registerArea = json['registerArea'];
    sex = json['sex'];
    personalSignature = json['personalSignature'].toString() == "null" ? null : json['personalSignature'].toString();
    accno = json['accno'].toString() == "null" ? null : json['accno'].toString();
    maritalStatus = int.parse(json['maritalStatus'].toString() == "null" ? "0" : json['maritalStatus'].toString());
    isOpenLive = json['isOpenLive'];
    mobilePhone = json['mobilePhone'].toString() == "null" ? null : json['mobilePhone'].toString();
    userType = int.parse(json['userType'].toString());
    occupationCode = json['occupationCode'];
    occupationName = json['occupationName'];
    userLevel = json['userLevel'];
    userAccount = json['userAccount'];
    fansNum = json['fansNum'];
    registerAreaCode = json['registerAreaCode'];
    id = json['id'];
    userId = json['userId'];
    isLoginPassword = json['isLoginPassword'];
    nickNameStatus = json['nickNameStatus'];
    firepower = json['firepower'];
    isPayPassword = json['isPayPassword'];
    avatar = json['avatar'];
    hometown = json['hometown'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['registerCountryCode'] = registerCountryCode;
    data['birthday'] = birthday;
    data['nickName'] = nickName;
    data['focusNum'] = focusNum;
    data['registerArea'] = registerArea;
    data['sex'] = sex;
    data['personalSignature'] = personalSignature;
    data['accno'] = accno;
    data['maritalStatus'] = maritalStatus;
    data['isOpenLive'] = isOpenLive;
    data['mobilePhone'] = mobilePhone;
    data['userType'] = userType;
    data['occupationCode'] = occupationCode;
    data['occupationName'] = occupationName;
    data['userLevel'] = userLevel;
    data['userAccount'] = userAccount;
    data['fansNum'] = fansNum;
    data['registerAreaCode'] = registerAreaCode;
    data['id'] = id;
    data['isLoginPassword'] = isLoginPassword;
    data['nickNameStatus'] = nickNameStatus;
    data['firepower'] = firepower;
    data['isPayPassword'] = isPayPassword;
    data['avatar'] = avatar;
    data['hometown'] = hometown;
    return data;
  }
}
