import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:mine_page/mine_wallet/widgets/stadium_border_button.dart';
import 'package:services/models/res/wallet/user_game_wallet_bean.dart';
import 'package:base/app_config.dart';

class GameItem extends StatelessWidget {
  const GameItem({
    Key? key,
    required this.customTheme,
    required this.toGameTransferIn,
    required this.toGameRollOut,
    required this.gameWallet,
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback toGameTransferIn;
  final VoidCallback toGameRollOut;
  final UserGameWalletBean gameWallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0).copyWith(top: 10),
      child: AspectRatio(
        aspectRatio: 323 / 66,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Assets.minePage.gameBg.image(fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gameWallet.name,
                          style: TextStyle(
                            color: customTheme.colors0xFFFFFF,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${gameWallet.amount}',
                          style: TextStyle(
                            color: customTheme.colors0xFFFFFF,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                 AppConfig.isVideo ? Container() : FittedBox(
                    child: Row(
                      children: [
                        StadiumBorderButton(
                          constraints:
                              const BoxConstraints(minWidth: 71, minHeight: 24),
                          customTheme: customTheme,
                          title: '转入',
                          onTap: toGameTransferIn,
                        ),
                        const SizedBox(width: 17),
                        StadiumBorderButton(
                          constraints:
                              const BoxConstraints(minWidth: 71, minHeight: 24),
                          customTheme: customTheme,
                          title: '转出',
                          onTap: toGameRollOut,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
