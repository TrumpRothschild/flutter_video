import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/gift_list/widgets/gift_swiper.dart';
import 'package:services/models/res/live/live_gift_bean.dart';
import 'package:services/models/res/live/live_send_gift_bean.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';
import 'package:services/provider/common_provider.dart';
import 'package:services/provider/live_provider.dart';

import 'widgets/gift_footer.dart';
import 'widgets/gift_tab.dart';

part 'gift_list_controller.dart';

class GiftListPage extends GetView<GiftListController> {
  const GiftListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Container(
        decoration: BoxDecoration(
          color: controller.currentCustomThemeData().colors0x000000_40,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        constraints: BoxConstraints(
            maxHeight: 360 + MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: GiftTab(),
            ),
            Expanded(
              child: GiftSwiper(
                giftList: state ?? [],
                callback: (LiveGiftBean bean) {
                  /// 选中礼物
                  OLEasyLoading.showToast(bean.giftName ?? "-");
                  controller.curGiftData.value = bean;
                },
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => GiftFooter(
                  controller.userWalletData.value,
                )),
          ],
        )));
  }
}
