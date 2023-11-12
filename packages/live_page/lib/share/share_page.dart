import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/share/widgets/share_swiper.dart';

import 'widgets/share_footer.dart';

part 'share_binding.dart';
part 'share_controller.dart';

class LiveSharePage extends GetView<ShareController> {
  const LiveSharePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const Spacer(flex: 54),
          ShareSwiper(
            imageList: const [],
            onIndexChanged: controller.onIndexChanged,
          ),
          const Spacer(flex: 90),
          ShareFooter(
            onCopyLink: controller.onCopyLink,
            onSaveQRCode: controller.onSaveQRCode,
          ),
          const Spacer(flex: 130),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.navigate_before,
          color: Colors.black,
        ),
      ),
      elevation: 1,
      title: const Text(
        '推广素材',
        style: TextStyle(
          color: Color(0xFF333333),
          fontSize: 16,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              OLEasyLoading.showToast('客服');
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Assets.livePage.navKf.image(
                width: 26,
                height: 26,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
