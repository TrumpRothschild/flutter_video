import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base_page/ad/ol_ad_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/game/game_banner_bean.dart';

import '../game_home_controller.dart';

class GameBanner extends StatelessWidget {
  const GameBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameHomeController>(
        id: "gameBannerData",
        builder: (controller) {
      var items = controller.bannerList;
      return Container(
        padding: const EdgeInsets.all(AppDimens.w_10),
        child: CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 2.2,
              autoPlay: items.length > 1,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              autoPlayInterval: const Duration(seconds: 10),
              pauseAutoPlayInFiniteScroll: true,
              enableInfiniteScroll: items.length > 1),
          items: items.map(
            (item) {
              return InkWell(
                onTap: () async {
                  OLAdController.shared.clickGameBanner(item.type ?? 0,
                      int.parse(item.skipModel ?? "0"), item.skipUrl ?? "", "");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.w_8),
                  child: OLImage(
                    placeholderPath: Assets.videoPage.videoDefaultBanner.path,
                    imageUrl: item.advImg ?? "",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      );
    });
  }
}
