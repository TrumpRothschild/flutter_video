import 'package:base/commons/widgets/ol_vip.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live/live_page.dart';
import 'package:services/models/res/live/live_online_list_bean.dart';
import 'package:services/models/res/live/live_top50_user_bean.dart';

import '../../widgets/common_image.dart';

class OnlineUserList extends StatelessWidget {
  final LiveController _controller = Get.find<LiveController>();
  final LiveTop50UserBean? _top50User;

  OnlineUserList(this._top50User, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<LiveOnlineListBean> userList = _top50User?.list ?? [];
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimens.h_10, horizontal: AppDimens.w_26),
      decoration: BoxDecoration(
        color: _controller.currentCustomThemeData().colors0x000000_30,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimens.w_30),
        ),
      ),
      constraints: BoxConstraints(
          maxHeight: AppDimens.h_400 + MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppDimens.h_10),
            child: Center(
              child: Text(
                '在线用户（${_top50User?.onlineNum ?? 0}）',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: FontDimens.fontSp16,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.separated(
              itemCount: userList.length,
              padding: const EdgeInsets.symmetric(vertical: AppDimens.h_10),
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: _controller.currentCustomThemeData().colors0x000000_10,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final user = userList[index];
                return ListTile(
                  onTap: (){
                    // 获取用户信息
                    _controller.getUserDetailInfo(user.userId, flag: 1);
                  },
                  dense: true,
                  contentPadding:const EdgeInsets.all(0),
                  leading: ClipOval(
                    child: CommonImage(
                      width: AppDimens.w_40,
                      height: AppDimens.w_40,
                      imageUrl: user.avatar,
                    ),
                  ),
                  title: Text(
                    user.nickName??"",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: FontDimens.fontSp14,
                    ),
                  ),
                  subtitle: Row(
                    children: [OlVip((user.level??0).toInt())],
                  ),
                );
              },
            ),
          ),
          Center(
            child: Text(
              '--- 只显示前50个在线用户 ---',
              style: TextStyle(
                color: _controller.currentCustomThemeData().colors0xFFFFFF_50,
                fontSize: FontDimens.fontSp12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
