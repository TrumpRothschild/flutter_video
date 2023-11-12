import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/extension.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_detail_model.dart';

class YXXBetGrid extends StatelessWidget {
  final CustomTheme customTheme;
  final List<Odds> oddsList;
  final List<Odds> selectedOddsList;
  final int typeIndex;
  final Function(Odds odds) onSelectOdds;

  const YXXBetGrid({
    Key? key,
    required this.customTheme,
    required this.oddsList,
    required this.selectedOddsList,
    required this.typeIndex,
    required this.onSelectOdds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: oddsList.mapIndexed(
        (odds, i) {
          final bool isSelected =
              (selectedOddsList.indexWhere((e) => e.id == odds.id) != -1);
          return GestureDetector(
            onTap: () => onSelectOdds(odds),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSelected
                                ? customTheme.colors0x9F44FF
                                : Colors.transparent,
                            width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            TicketUtils.getYXXResultImage(odds.oddsName ?? '')
                                .map(
                                  (item) => AssetGenImage(item).image(
                                    height: typeIndex == 2?35:45,
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${odds.odds ?? ''}',
                  style: TextStyle(
                    fontSize: 14,
                    color: customTheme.colors0xFFFFFF,
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}

class YXXItem extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String assetImg;

  const YXXItem({
    Key? key,
    required this.bgColor,
    required this.textColor,
    required this.assetImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: AssetGenImage(assetImg).image(
        height: 40,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
