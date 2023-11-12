import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/im_msg_widget.dart';
import '../live_page.dart';

/// 进入直播间消息
class LiveMessageEnter extends StatelessWidget {
  LiveMessageEnter({Key? key}) : super(key: key);

  final LiveController _controller = Get.find<LiveController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppDimens.w_40,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10)
            .copyWith(bottom: AppDimens.h_5, top: AppDimens.h_16),
        child: Obx(() {
          var beans = _controller.msgEnterRoom;
          if (beans.isNotEmpty) {
            return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  //范围内进行包裹（内容多高ListView就多高）
                  shrinkWrap: true,
                  //禁止滚动
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ImMsgWidget.of().enterRoom(beans[index]);
                  },
                  itemCount: beans.length,
                ));
          } else {
            return const SizedBox();
          }
        }));
  }
}
