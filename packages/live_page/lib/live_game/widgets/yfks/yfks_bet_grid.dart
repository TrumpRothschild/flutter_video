import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_detail_model.dart';

class YFKSBetGrid extends StatelessWidget {
  final CustomTheme customTheme;
  final List<Odds> oddsList;
  final List<Odds> selectedOddsList;
  final int typeIndex;
  final Function(Odds odds) onSelectOdds;

  const YFKSBetGrid({
    Key? key,
    required this.customTheme,
    required this.oddsList,
    required this.selectedOddsList,
    required this.typeIndex,
    required this.onSelectOdds,
  }) : super(key: key);

  int get crossAxisCount {
    switch (typeIndex) {
      case 0:
      case 4:
        return 4;
      case 1:
        return 7;
      default:
        return 3;
    }
  }

  double get itemSize {
    switch (typeIndex) {
      case 0:
        return 65;
      case 1:
        return 35;
      default:
        return 51;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: itemSize / (itemSize + 24)),
      children: oddsList.map(
        (odds) {
          final bool isSelected =
              (selectedOddsList.indexWhere((e) => e.id == odds.id) != -1);
          return GestureDetector(
            onTap: () => onSelectOdds(odds),
            child: Column(
              children: [
                Container(
                  width: itemSize,
                  height: itemSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: isSelected
                          ? customTheme.colors0xD96CFF
                          : customTheme.colors0xFFFFFF,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    odds.oddsName ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected
                          ? customTheme.colors0xFFFFFF
                          : customTheme.colors0x000000,
                    ),
                  ),
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
