import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live/live_page.dart';
import 'package:live_page/widgets/common_image.dart';
import 'package:services/provider/live_provider.dart';

import 'widgets/exit_room_action_row.dart';
import 'widgets/exit_room_header.dart';

part 'exit_room_dialog_controller.dart';

class ExitRoomDialogPage extends GetView<ExitRoomDialogController> {
  const ExitRoomDialogPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExitRoomDialogController>(
      init: ExitRoomDialogController(),
      builder: (controller) => Center(
        child: SizedBox(
          width: 300,
          height: 240,
          child: Stack(
            children: [
              Assets.livePage.exitRoomDialogBg.image(
                width: 300,
                height: 240,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const ExitRoomHeader(),
                  Column(
                    children: [
                      ClipOval(
                        child: CommonImage(
                          width: 75,
                          height: 75,
                          imageUrl: controller.anchor?.avatar ?? '',
                        ),
                      ),
                      if ((controller.anchor?.userId ?? 0) > 0 &&
                          controller.anchor?.isFocus == false) ...const [
                        SizedBox(height: 6),
                        Text(
                          '关注主播不迷路~',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                  ExitRoomActionRow(
                    exit: controller.exit,
                    followThenExit: ((controller.anchor?.userId ?? 0) > 0 &&
                            controller.anchor?.isFocus == false)
                        ? controller.followThenExit
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
