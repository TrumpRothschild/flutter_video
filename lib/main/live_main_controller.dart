import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_keep_alive_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_page/game_home/game_home_page.dart';
import 'package:home_page/view/home_page.dart';
import 'package:mine_page/mine_root/mine_root_page.dart';
import 'package:wallet_page/wallet_root/wallet_root_page.dart';

import 'base_main_controller.dart';

/// 直播主页controller
class LiveMainController extends BaseMainController {
  @override
  List<Widget> getTabItemPages() {
    List<Widget> list = [];
    list.add(const OlKeepAliveWidget(child: HomePage()));
    list.add(const OlKeepAliveWidget(child: GameHomePage()));
    list.add(OlKeepAliveWidget(child: WalletRootPage(showLeading: false)));
    list.add(OlKeepAliveWidget(child: MineRootPage()));
    return list;
  }

  @override
  void mainTabItems() {
    tabItems.add(TabItem(
      basePageString("tab_home"),
      Assets.rootPage.images.tabHomeNormal.path,
      Assets.rootPage.animations.homeLottie,
    ));

    tabItems.add(TabItem(
      basePageString("tab_game"),
      Assets.rootPage.images.tabGameNormal.path,
      Assets.rootPage.animations.gameLottie,
    ));
    tabItems.add(TabItem(
      basePageString("tab_wallet"),
      Assets.rootPage.images.tabPayNormal.path,
      Assets.rootPage.animations.walletLottie,
    ));
    tabItems.add(TabItem(
      basePageString("tab_mine"),
      Assets.rootPage.images.tabMyNormal.path,
      Assets.rootPage.animations.mineLottie,
    ));
  }
}
