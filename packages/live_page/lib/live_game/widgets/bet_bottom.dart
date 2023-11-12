import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BetBottom extends StatelessWidget {
  const BetBottom({
    Key? key,
    required this.customTheme,
    required this.changeChip,
    required this.chip,
    required this.onBet,
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback? changeChip;
  final int chip;
  final VoidCallback? onBet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "金币 ",
                  style: TextStyle(
                    fontSize: 14,
                    color: customTheme.colors0xFFFFFF,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontSize: 14,
                      color: customTheme.colors0xFFEF62,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  Assets.gamePage.liveGame.refresh,
                ),
              ],
            ),
          ),
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
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
          GestureDetector(
            onTap: changeChip,
            child: Row(
              children: [
                AssetGenImage(Assets.gamePage.liveGame.chip.path)
                    .image(height: 22, fit: BoxFit.fitHeight),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 2),
                  child: Text(
                    '$chip',
                    style: TextStyle(
                      fontSize: 14,
                      color: customTheme.colors0xFFEF62,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  Assets.gamePage.liveGame.arrowUp,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onBet,
            child: Container(
              height: 26,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [
                    customTheme.colors0x6129FF,
                    customTheme.colors0xD96CFF,
                  ],
                ),
              ),
              child: Text(
                "下注",
                style: TextStyle(
                  fontSize: 14,
                  color: customTheme.colors0xFFFFFF,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
