import 'package:base/commons/widgets/ol_vip.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:live_page/widgets/capsule_container.dart';
import 'package:services/models/res/live/im_chat_bean.dart';
import 'package:services/models/res/live/im_enter_room_bean.dart';

import '../live/live_page.dart';

class ImMsgWidget {
  static ImMsgWidget of() => ImMsgWidget();
  final LiveController _controller = Get.find<LiveController>();

  /// 昵称样式
  TextStyle _nicknameStyle() {
    return TextStyle(
        color: _controller.currentCustomThemeData().colors0x9F44FF,
        fontSize: FontDimens.fontSp13);
  }

  /// 消息内容
  TextStyle _contentStyle() {
    return TextStyle(
        color: _controller.currentCustomThemeData().colors0xFFFFFF,
        fontSize: FontDimens.fontSp13);
  }

  Widget _hSizeBox() => const SizedBox(width: AppDimens.w_5);

  /// 进入直播间消息
  Widget enterRoom(ImEnterRoomBean bean) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OlVip((bean.level ?? 0).toInt()),
        _hSizeBox(),
        Text(bean.nickName ?? "", style: _nicknameStyle()),
        _hSizeBox(),
        Text("进入房间!", style: _contentStyle()),
      ],
    );
  }

  /// 聊天消息
  Widget chat(ImChatBean bean) {
    return CapsuleContainer(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${bean.nickName}:",
              style: TextStyle(
                  color: _controller.currentCustomThemeData().colors0xEF8AFF,
                  fontSize: FontDimens.fontSp13)),
          _hSizeBox(),
          Text("进入房间!", style: _contentStyle()),
        ],
      ),
    );
  }
}
