import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live_end/live_end_page.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/home/home_live_bean.dart';

class LiveCard extends StatelessWidget {
  const LiveCard({
    Key? key,
    this.item,
  }) : super(key: key);

  final HomeLiveBean? item;

  LiveEndController get _controller => Get.find();

  @override
  Widget build(BuildContext context) {
    var textColor = _controller.currentCustomThemeData().colors0xFFFFFF;
    return InkWell(
      onTap: () {
        // 进入直播间
        Get.back(result: item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        alignment: AlignmentDirectional.bottomStart,
        child: Stack(
          children: [
            OLImage(
                imageUrl: item?.studioThumbImage ?? "",
                width: double.infinity,
                height: double.infinity),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 彩票名称
                      Visibility(
                        child: Container(
                          height: 20,
                          width: 100,
                          padding: const EdgeInsets.only(left: 10),
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                Assets.homePage.icHomeTicketBg.path,
                              ),
                            ),
                          ),
                          child: Text(
                            item?.gameName ?? '一分快三',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        visible: true,
                      ),
                      // 收费类型
                      _chargeWidget(
                        _controller,
                        item,
                        textColor,
                      ),
                      // 收费价格
                      _chargeWidget(
                        _controller,
                        item,
                        textColor,
                        type: 2,
                      ),
                    ],
                  ),
                ),
                // 直播标题
                Text(
                  HomeLiveBean().studioTitle ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      child:
                          AssetGenImage(Assets.homePage.icHomeLocal.path).image(
                        width: 10,
                        height: 12,
                      ),
                      visible:
                          GetUtils.isNullOrBlank(item?.countryName) == false,
                    ),
                    Visibility(
                      child: const SizedBox(width: 4),
                      visible:
                          GetUtils.isNullOrBlank(item?.countryName) == false,
                    ),
                    Text(
                      item?.countryName ?? "",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 10,
                      ),
                    ),
                    const Expanded(child: Text("")),
                    AssetGenImage(Assets.homePage.icHomeHeat.path).image(
                      width: 10,
                      height: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '0',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /// 收费组件
  /// type =1 收费类型 2 收费价格
  Widget _chargeWidget(
    GetXBaseController controller,
    HomeLiveBean? item,
    var textColor, {
    int type = 1,
  }) {
    var msg = item?.chargeType == 6
        ? controller.homePageString('charge_time')
        : controller.homePageString('charge_site');
    if (type == 2) {
      msg = item?.chargeType == 6
          ? "${item?.price}${controller.homePageString('diamonds_minute')}"
          : "${item?.price}${controller.homePageString('diamonds_site')}";
    }
    return Visibility(
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          msg,
          style: TextStyle(
            color: textColor,
            fontSize: 11,
          ),
        ),
        decoration: ShapeDecoration(
          color: controller.currentCustomThemeData().colors0x000000_30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      visible: true,
    );
  }
}
