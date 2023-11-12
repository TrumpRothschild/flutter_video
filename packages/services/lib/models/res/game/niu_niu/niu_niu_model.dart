import 'package:base/commons/utils/app_date_utils.dart';

/// id : 0
/// kjBegin : 0
/// kjEnd : 0
/// kjNo : 0
/// kjNumber : ""
/// lastKjNo : 0
/// lastKjNumber : ""
/// sec : 0
/// secReal : 0
/// sfxj : 0
/// ticketTime : 0
/// tid : 0
/// time : 0

class GameTicketModel {
  GameTicketModel({
    this.id,
    this.kjBegin,
    this.kjEnd,
    this.kjNo,
    this.kjNumber,
    this.lastKjNo,
    this.lastKjNumber,
    this.sec,
    this.secReal,
    this.sfxj,
    this.ticketTime,
    this.tid,
    this.time,
  });

  GameTicketModel.fromJson(dynamic json) {
    id = json['id'];
    kjBegin = json['kjBegin'];
    kjEnd = json['kjEnd'];
    kjNo = json['kjNo'];
    kjNumber = json['kjNumber'];
    lastKjNo = json['lastKjNo'];
    lastKjNumber = json['lastKjNumber'];
    sec = json['sec'];
    secReal = json['secReal'];
    sfxj = json['sfxj'];
    ticketTime = json['ticketTime'];
    tid = json['tid'];
    tId = json['tId'];
    time = json['time'];
  }

  num? id;
  dynamic? kjBegin;
  dynamic? kjEnd;
  dynamic kjNo;
  String? kjNumber;
  dynamic lastKjNo;
  String? lastKjNumber;
  int? sec;
  num? secReal;
  num? sfxj;
  num? ticketTime;
  int? tid;
  int? tId;
  dynamic? time;

  String? get year {
    try {
      if (time > 0) {
        return AppDateUtils.longToYear(time * 1000);
      } else {
        if (kjBegin?.isNotEmpty ?? false) {
          return AppDateUtils.stringToStringWithPattern(AppDateUtils.Y, kjBegin!);
        } else {
          return AppDateUtils.longToYear(DateTime.now().millisecondsSinceEpoch);
        }
      }
    } catch (e) {
      print(e);
    }
    return AppDateUtils.longToYear(DateTime.now().millisecondsSinceEpoch);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['kjBegin'] = kjBegin;
    map['kjEnd'] = kjEnd;
    map['kjNo'] = kjNo;
    map['kjNumber'] = kjNumber;
    map['lastKjNo'] = lastKjNo;
    map['lastKjNumber'] = lastKjNumber;
    map['sec'] = sec;
    map['secReal'] = secReal;
    map['sfxj'] = sfxj;
    map['ticketTime'] = ticketTime;
    map['tid'] = tid;
    map['tId'] = tId;
    map['time'] = time;
    return map;
  }
}
