import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wallet_root_controller.dart';

class WalletRootPleaseChannel extends StatelessWidget {
  final WalletRootController controller = Get.find();
  final List balance;

  WalletRootPleaseChannel({
    Key? key,
    required this.balance,
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
              : controller.ways[controller.seleWays.value].payChannelVOList
                      ?.length ??
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
        controller.seleMoeny.value = 0;
        controller.seleTongDao.value = index;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width(16)),
          /*image: index == controller.seleTongDao.value
              ? DecorationImage(
                  image: AssetImage(
                    Assets.walletPage.xuanZhong.path,
                  ),
                )
              : null,*/
          gradient: index == controller.seleTongDao.value ? LinearGradient(
                begin: Alignment.bottomCenter,
                end:Alignment.topCenter,
                colors: [
                  Color(0x5fF7F4FE),
                  Color(0x007032FF)
                ]) : null,
          border: index == controller.seleTongDao.value ? Border.all(
              color: controller.currentCustomThemeData().colors0x7032FF,
              width: 0.5) : Border.all(
              color: controller.currentCustomThemeData().colors0xD9D9D9,
              width: 0.5), // 边色与边宽度
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                controller.ways[controller.seleWays.value].payChannelVOList?[index]
                    ?.channelName ??
                    "",
                style: TextStyle(
                  color: index == controller.seleTongDao.value
                      ? controller.currentCustomThemeData().colors0x7032FF
                      : controller.currentCustomThemeData().colors0x666666,
                  fontSize: FontDimens.fontSp14,
                ),
              ),
            ),
            index == controller.seleTongDao.value ? Positioned(
              right: -0.5,
              bottom: 0,
              child: Assets.walletPage.xuanZhong.image(
                  width: width(46),
                  height: width(34)
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}
