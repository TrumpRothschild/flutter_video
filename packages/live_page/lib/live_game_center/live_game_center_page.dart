import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/live_game_page.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/game/game_tab_model.dart';
import 'package:services/models/res/game/live_game_model.dart';
import 'package:services/provider/live_provider.dart';

part 'live_game_center_controller.dart';

class LiveGameCenterPage extends GetView<LiveGameCenterController> {
  final List<GameTabModel?> gameTabs;

  const LiveGameCenterPage({
    Key? key,
    required this.gameTabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiveGameCenterController(gameTabs));
    final CustomTheme customTheme = controller.currentCustomThemeData();

    return GetBuilder<LiveGameCenterController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: controller.currentCustomThemeData().colors0x000000_40,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
              maxHeight: 350 + MediaQuery.of(context).padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: List.generate(
                    gameTabs.length,
                    (index) => Expanded(
                      child: InkWell(
                        onTap: () => controller.onTab(index),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            gradient: controller.tabIndex == index
                                ? LinearGradient(
                                    colors: [
                                      customTheme.colors0x6129FF,
                                      customTheme.colors0xD96CFF,
                                    ],
                                  )
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              gameTabs[index]?.name ?? '',
                              style: TextStyle(
                                color: customTheme.colors0xFFFFFF,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GridView(
                        padding: const EdgeInsets.all(15),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        children: controller.games
                            .map(
                              (e) => GestureDetector(
                                onTap: ()=>controller.onItemTap(e),
                                child: OLImage(
                                  imageUrl: e?.iconUrl ?? '',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SafeArea(
                      minimum: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: customTheme.colors0x000000_20,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "金币：",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: customTheme.colors0xFFFFFF,
                                    ),
                                  ),
                                  Text(
                                    "1247.00",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: customTheme.colors0xFFE601,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    customTheme.colors0x6129FF,
                                    customTheme.colors0xD96CFF,
                                  ],
                                ),
                              ),
                              child: Text(
                                "充值",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: customTheme.colors0xFFFFFF,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
