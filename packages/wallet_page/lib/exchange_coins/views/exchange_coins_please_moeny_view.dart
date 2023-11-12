import 'package:base/assets.gen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/wallet/diamond_model.dart';

import '../exchange_coins_controller.dart';

class ExchangeCoinsPleaseMoney extends StatelessWidget {
  final ExchangeCoinsController controller = Get.find();

  ExchangeCoinsPleaseMoney({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 68,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: controller.ways.length,
          itemBuilder: (BuildContext context, int index) {
            return item(controller.ways[index]);
          });
    });
  }

  item(DiamondModel data) {
    return InkWell(
      onTap: () {
        controller.exchange(data);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: controller.currentCustomThemeData().colors0x7032FF,
              width: 0.5), // 边色与边宽度
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "${data.option ?? ""}${controller.exType.value == 0 ? "金币" : "钻"}",
                  style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x7032FF,
                    fontSize: FontDimens.fontSp20,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.walletPage.exMoney.path,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "${data.platformGoldNum ?? 0}${"元"}",
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0xFFFFFF,
                      fontSize: FontDimens.fontSp16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
