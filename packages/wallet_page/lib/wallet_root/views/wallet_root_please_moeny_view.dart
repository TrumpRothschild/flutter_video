import 'package:base/commons/utils/screen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wallet_root_controller.dart';

class WalletRootPleaseMoney extends StatelessWidget {
  final WalletRootController controller = Get.find();
  final List balance;

  final VoidCallback onRecharge;

  WalletRootPleaseMoney({
    Key? key,
    required this.balance,
    required this.onRecharge,
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
            mainAxisExtent: 36,
            mainAxisSpacing: 6,
            crossAxisSpacing: 11,
          ),
          itemCount: controller.ways.isEmpty
              ? 0
              : controller.ways[controller.seleWays.value]
                      .payChannelVOList?[controller.seleTongDao.value]
                      .moneysLength() ??
                  0,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              return item(index);
            });
            // return Card(
            //   color: Colors.amber,
            //   child: Center(child: Text('$index')),
            // );
          });
    });
  }

  item(int index) {
    return InkWell(
      onTap: () {
        controller.seleMoeny.value = index;
        onRecharge.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width(16)),

          border: Border.all(
              color: controller.currentCustomThemeData().colors0x7032FF,
              width: 0.5), // 边色与边宽度
        ),
        child: Center(
          child: Text(
            controller.ways[controller.seleWays.value]
                    .payChannelVOList?[controller.seleTongDao.value]
                    .moneys()[index] ??
                "",
            style: TextStyle(
              color: controller.currentCustomThemeData().colors0x7032FF,
              fontSize: FontDimens.fontSp14,
            ),
          ),
        ),
      ),
    );
  }
}
