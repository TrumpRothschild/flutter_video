import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/image/ol_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'game_home_controller.dart';
import 'widgets/game_banner.dart';
import 'widgets/game_list.dart';
import 'widgets/game_notice.dart';
import 'widgets/game_user_info.dart';

/// Game
class GameHomePage extends GetBaseView<GameHomeController> {
  const GameHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const GameBanner(),
            GameNotice(
              onTransactionTap: controller.toTransactionPage,
            ),
            const GameUserInfo(),
            Expanded(child: _buildGameBody())
          ],
        ),
      ),
    );
  }

  Widget _buildGameBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _gameTab(),
          Expanded(
            child: _gameList(),
          ),
        ],
      ),
    );
  }

  Widget _gameTab() {
    return GetBuilder<GameHomeController>(
        id: "gameTabData",
        builder: (controller) {
          var data = controller.gameTabData;
          return Column(
              children: data.asMap().entries.map((e) {
            var index = e.key;
            var item = e.value;
            return InkWell(
                onTap: () {
                  controller.updateGameList(index);
                },
                child: Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          controller.selectedIndex.value == index
                              ? Assets.gamePage.icGameSelectedBg.path
                              : Assets.gamePage.icGameUnselectedBg.path,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OLImage(
                          imageUrl: item.iconUrl ?? '',
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.name ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            color: controller.selectedIndex.value == index
                                ? controller
                                    .currentCustomThemeData()
                                    .colors0xFFFFFF
                                : controller
                                    .currentCustomThemeData()
                                    .colors0x5A3AB5,
                            // color: controller.currentCustomThemeData().colors0xFFFFFF,
                          ),
                        )
                      ],
                    )));
          }).toList());
        });
  }

  Widget _gameList() {
    return Stack(
      children: [
        const GameListWidget(),
        Positioned(
          top: 10,
          right: 1,
          child: InkWell(
            onTap: () async {
              String url = UserManagerCache.shared.getNewOnlineUrl();
              await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image(
                image: AssetImage(
                  Assets.rootPage.images.navKf.path,
                ),
                width: 40,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        )
      ],
    );
  }
}
