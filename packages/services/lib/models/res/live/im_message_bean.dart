import 'dart:convert';

import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

/// code : 200
/// body : {"id":null,"chatType":6,"targetId":"t_4","operatorType":18,"sendTime":"2023-03-08 16:00:09","content":"{\"kjBegin\":1678262409,\"lastKjNo\":202303080960,\"kjEnd\":1678262469,\"tId\":4,\"sfxj\":0,\"sec\":60,\"secReal\":60,\"kjNo\":202303080961,\"ticketTime\":60,\"lastKjNumber\":\"40,9,12,0,47,6,0,4\",\"time\":1678262409}","bannedEndTime":null}
/// sendTime : 1678262409030
/// receiptTime : 1678262409030
/// msgId : "9915a74c481f41a3aee3ac4d81b847c5"
/// errorMsg : null
/// receive : false

class ImMessageBean {
  ImMessageBean({
    this.code,
    this.body,
    this.sendTime,
    this.receiptTime,
    this.msgId,
    this.errorMsg,
    this.receive,
  });

  factory ImMessageBean.fromJsonStr(String jsonString) {
    try {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return ImMessageBean(
        code: jsonMap['code'],
        body: ImMessageBody.fromJson(jsonMap['body']),
        sendTime: jsonMap['sendTime'],
        receiptTime: jsonMap['receiptTime'],
        msgId: jsonMap['msgId'],
        errorMsg: jsonMap['errorMsg'],
        receive: jsonMap['receive'],
      );
    } catch (e) {
      return ImMessageBean();
    }
  }

  num? code;
  ImMessageBody? body;
  num? sendTime;
  num? receiptTime;
  String? msgId;
  dynamic errorMsg;
  bool? receive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (body != null) {
      map['body'] = body?.toJson();
    }
    map['sendTime'] = sendTime;
    map['receiptTime'] = receiptTime;
    map['msgId'] = msgId;
    map['errorMsg'] = errorMsg;
    map['receive'] = receive;
    return map;
  }
}

/// id : null
/// chatType : 6
/// targetId : "t_4"
/// operatorType : 18
/// sendTime : "2023-03-08 16:00:09"
/// content : "{\"kjBegin\":1678262409,\"lastKjNo\":202303080960,\"kjEnd\":1678262469,\"tId\":4,\"sfxj\":0,\"sec\":60,\"secReal\":60,\"kjNo\":202303080961,\"ticketTime\":60,\"lastKjNumber\":\"40,9,12,0,47,6,0,4\",\"time\":1678262409}"
/// bannedEndTime : null

class ImMessageBody {
  ImMessageBody({
    this.id,
    this.chatType,
    this.targetId,
    this.operatorType,
    this.sendTime,
    this.content,
    this.bannedEndTime,
  });

  factory ImMessageBody.fromJson(Map<String, dynamic> jsonMap) {
      return ImMessageBody(
        id: jsonMap['id'],
        chatType: jsonMap['chatType'],
        targetId: jsonMap['targetId'],
        operatorType: jsonMap['operatorType'],
        sendTime: jsonMap['sendTime'],
        bannedEndTime: jsonMap['bannedEndTime'],
        content: jsonMap['content'],
      );
  }

  dynamic id;
  num? chatType;
  String? targetId;
  num? operatorType;
  String? sendTime;
  String? content;
  dynamic bannedEndTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['chatType'] = chatType;
    map['targetId'] = targetId;
    map['operatorType'] = operatorType;
    map['sendTime'] = sendTime;
    map['content'] = content;
    map['bannedEndTime'] = bannedEndTime;
    return map;
  }
}
