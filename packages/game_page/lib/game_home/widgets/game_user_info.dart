import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/number_util.dart';
import 'package:flutter/material.dart';
import 'package:game_page/game_home/game_home_controller.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GameUserInfo extends StatefulWidget {
  const GameUserInfo({Key? key}) : super(key: key);

  @override
  State<GameUserInfo> createState() => _GameUserInfoState();
}

class _GameUserInfoState extends State<GameUserInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFFFFFF),
                Color(0xffF5ECFF),
              ],
              stops: [
                0,
                1
              ]),
        ),
        child: Row(
          children: [
            Expanded(
              child: _userBalance(),
            ),
            Container(
              width: 1,
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color(0xffEAD7FF),
            ),
            _ImageButton(
              name: '存款',
              iconPath: Assets.gamePage.iconCGame.path,
              onTap: () {
                Get.toNamed(AppRoutes.walletRoot, arguments: {
                  'accountType': 2,
                });
              },
            ),
            const SizedBox(width: 16),
            _ImageButton(
              name: '取款',
              iconPath: Assets.gamePage.iconQGame.path,
              onTap: () {
                Get.toNamed(AppRoutes.withdraw);
              },
            ),
            const SizedBox(width: 16),
            _ImageButton(
              name: '优惠',
              iconPath: Assets.gamePage.iconYouhuiGame.path,
              onTap: () {
                Get.toNamed(AppRoutes.activityCenter);
              },
            ),
            const SizedBox(width: 16),
            _ImageButton(
              name: '游戏记录',
              iconPath: Assets.gamePage.iconYxjlGame.path,
              onTap: () {
                Get.toNamed(AppRoutes.gameRecord);
              },
            ),
          ],
        ));
  }

  Widget _userBalance() {
    return GetBuilder<GameHomeController>(
        id: "userWalletData",
        builder: (controller) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _animationController.reset();
              _animationController.forward();
              controller.getUserWallet();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  UserManagerCache.shared.getUserDetail()?.nickName ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff808080),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "¥ ${NumberUtil.formatNum(double.parse(controller.amount.value), 2)}",
                      minFontSize: 8,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff333333),
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(width: 4),
                    RotationTransition(
                      alignment: Alignment.center,
                      turns: _animationController,
                      child: Image.asset(
                        Assets.gamePage.iconRefresh.path,
                        width: 18,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

class _ImageButton extends StatelessWidget {
  final String name;
  final String iconPath;
  final VoidCallback? onTap;

  const _ImageButton({
    Key? key,
    required this.name,
    required this.iconPath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 38,
            height: 38,
          ),
          const SizedBox(height: 1),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff333333),
            ),
          ),
        ],
      ),
    );
  }
}
