import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:game_page/game_home/game_home_controller.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';

class GameListWidget extends StatelessWidget {
  const GameListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameHomeController>(
        id: "gameListData",
        builder: (controller) {
          var data = controller.gameListData;
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 6,
              childAspectRatio: 140 / 90,
            ),
            itemCount: data.length,
            padding:
                const EdgeInsets.symmetric(vertical: 10).copyWith(left: 10),
            itemBuilder: (ctx, index) {
              var item = data[index];
              return GestureDetector(
                onTap: () => controller.onTapItem(item),
                child: OLImage(
                  imageUrl: item.iconUrl ?? '',
                  placeholderPath: Assets.gamePage.gameDefaultImage.path,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          );
        });
  }
}
