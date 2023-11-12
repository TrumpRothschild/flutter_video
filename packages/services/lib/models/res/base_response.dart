class BaseResponse {
  late int? code;
  late dynamic data;
  late String? msg;
  late dynamic timestamp;

  BaseResponse.fromJson(dynamic json) {
    code = json['code'];
    data = json['data'];
    msg = json['msg'];
    timestamp = json['timestamp'];
  }
}
