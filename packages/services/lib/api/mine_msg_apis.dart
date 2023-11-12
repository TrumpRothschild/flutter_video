import 'package:services/api/apis.dart';
import 'package:services/http.dart';

class MineMsgApis {
  static MineMsgApis get of => MineMsgApis();

  /// 最新系统消息和邮件消息
  getLatestNews() async {
    return await HttpUtil().post(
      Apis.getLatestNews,
    );
  }

  getUnReadMsgNum() async {
    return await HttpUtil().post(
      Apis.getUnReadMsgNum,
    );
  }

  /// 最新系统消息和邮件消息
  getMessageList({
    required int msgType,
    required int pageNum,
    int pageSize = 20,
  }) async {
    return await HttpUtil().post(Apis.messageList, data: {
      "msgType": msgType,
      "pageNum": pageNum,
      "pageSize": pageSize,
    });
  }

  /// 标记消息已读
  readMessage({
    required List<int> ids,
  }) async {
    return await HttpUtil().post(
      Apis.readMessage,
      data: {
        'ids': ids,
      },
    );
  }

  /// 一键已读
  readAllMessage() async {
    return await HttpUtil().post(
      Apis.readAllMessage,
    );
  }

  /// 一键清空
  emptyMessage({
    required int msgType,
  }) async {
    return await HttpUtil().post(Apis.emptyMessage, data: {
      'msgType': msgType,
    });
  }
}
