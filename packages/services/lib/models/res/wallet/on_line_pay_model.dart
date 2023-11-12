class OnLinePayModel {
  String? code;
  String? orderNo;
  String? url;

  OnLinePayModel({this.code, this.orderNo, this.url});

  OnLinePayModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    orderNo = json['orderNo'].toString();
    url = json['url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['orderNo'] = this.orderNo;
    data['url'] = this.url;
    return data;
  }
}
