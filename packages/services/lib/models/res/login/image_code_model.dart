import 'dart:convert';

class ImageCodeModel {
  String? captchaKey;
  String? img64Code;
  String? imgCode;

  String get validImg64Code {
    if (img64Code?.isEmpty == true) return '';
    final strs = img64Code!.split(',');
    if (strs.isEmpty) return '';
    if (strs.length == 1) return strs[0];

    return strs[1];
  }

  imageUrl() {
    var tmp = img64Code ?? "";
    tmp = tmp.replaceAll("%3B", "\\");
    tmp = tmp.replaceAll("%2B", "\n");
    tmp = tmp.replaceAll("%2b", "\r");
    tmp = tmp.replaceAll("\n", "");
    tmp = tmp.replaceAll("\r", "");
    tmp = tmp.replaceAll("\\", "");
    return base64Decode(tmp);
  }

  ImageCodeModel({this.captchaKey, this.img64Code, this.imgCode});

  ImageCodeModel.fromJson(Map<String, dynamic> json) {
    captchaKey = json['captchaKey'];
    img64Code = json['img64Code'];
    imgCode = json['imgCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['captchaKey'] = captchaKey;
    data['img64Code'] = img64Code;
    data['imgCode'] = imgCode;
    return data;
  }
}
