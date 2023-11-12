import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live/live_page.dart';
import 'package:services/image/ol_image.dart';

class LiveGameCountDown extends GetView<LiveController> {
  final String gameIcon;

  const LiveGameCountDown({
    Key? key,
    required this.gameIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<LiveController>();
    return Obx(
      () => logic.ticketCountDown.isEmpty
          ? const SizedBox.shrink()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OLImage(
                  imageUrl: gameIcon,
                  width: 65,
                  height: 65,
                ),
                Text(
                  logic.ticketCountDown.value,
                  style: TextStyle(
                    fontSize: 14,
                    color: logic.currentCustomThemeData().colors0xFFFFFF,
                  ),
                ),
              ],
            ),
    );
  }
}
