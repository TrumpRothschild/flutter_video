import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';

import '../wallet_root_controller.dart';

class WalletRootChannel extends StatelessWidget {
  final WalletRootController controller = Get.find();
  final List balance;

  WalletRootChannel({
    Key? key,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10),
      height: 80,
      child: Obx(
        () {
          return ListView.builder(
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: controller.ways.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                return item(index);
              });
            },
          );
        },
      ),
    );
  }

  item(int index) {
    return InkWell(
      onTap: () {
        controller.seleTongDao.value = 0;
        controller.seleMoeny.value = 0;
        controller.seleWays.value = index;
      },
      child: Container(
        width: 89,
        decoration: BoxDecoration(
          border: Border.all(
              color: controller.currentCustomThemeData().colors0xD9D9D9,
              width: 0.5), // 边色与边宽度
          image: index == controller.seleWays.value
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    Assets.walletPage.payMoneyBankBackground.path,
                  ),
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OLImage(
              imageUrl: controller.ways[index].iconUrl ?? "",
              width: 32,
              height: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              controller.ways[index].payTypeName ?? "",
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0x333333,
                fontSize: FontDimens.fontSp14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
