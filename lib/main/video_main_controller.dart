import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_keep_alive_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_page/game_home/game_home_page.dart';
import 'package:video_page/mine/mine_page.dart';
import 'package:video_page/video_home/video_home_page.dart';
import 'package:wallet_page/wallet_root/wallet_root_page.dart';

import 'base_main_controller.dart';

/// 视频主页controller
class VideoMainController extends BaseMainController {
  @override
  List<Widget> getTabItemPages() {
    List<Widget> list = [];
    list.add(const OlKeepAliveWidget(child: VideoHomePage()));
    list.add(const OlKeepAliveWidget(child: GameHomePage()));
    list.add(OlKeepAliveWidget(child: WalletRootPage(showLeading: false)));
    list.add(const OlKeepAliveWidget(child: MinePage()));
    return list;
  }

  @override
  void mainTabItems() {
    tabItems.add(TabItem(
      basePageString("tab_video"),
      Assets.rootPage.images.tabVideoNormal.path,
      Assets.rootPage.animations.videoLottie,
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
