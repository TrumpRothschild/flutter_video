import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_detail_model.dart';

class BRNNBetGrid extends StatelessWidget {
  final CustomTheme customTheme;
  final List<Odds> oddsList;
  final List<Odds> selectedOddsList;
  final int typeIndex;
  final Function(Odds odds) onSelectOdds;

  const BRNNBetGrid({
    Key? key,
    required this.customTheme,
    required this.oddsList,
    required this.selectedOddsList,
    required this.typeIndex,
    required this.onSelectOdds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmall = typeIndex != 0 && typeIndex != 1;

    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSmall ? 6 : 2,
        childAspectRatio: isSmall ? 40 / 36 : 65 / 65,
      ),
      children: oddsList.map(
        (odds) {
          final bool isSelected =
              (selectedOddsList.indexWhere((e) => e.id == odds.id) != -1);
          return GestureDetector(
            onTap: () => onSelectOdds(odds),
            child: Column(
              children: [
                Container(
                  width: isSmall ? 40 : 65,
                  height: isSmall ? 36 : 65,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: isSelected
                          ? customTheme.colors0xD96CFF
                          : customTheme.colors0xFFFFFF,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    odds.oddsName ?? '',
                    style: TextStyle(
                      fontSize: isSmall ? 14 : 16,
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
    return const SizedBox.shrink();
  }
}
