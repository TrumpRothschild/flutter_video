import 'package:base/themes/custom_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'input_dialog.dart';

class BottomChipPage extends StatefulWidget {
  final CustomTheme customTheme;
  final int chip;

  const BottomChipPage({
    Key? key,
    required this.chip,
    required this.customTheme,
  }) : super(key: key);

  @override
  State<BottomChipPage> createState() => _BottomChipPageState();
}

class _BottomChipPageState extends State<BottomChipPage> {
  int _selectIndex = -1;

  final List<_BetChip> chipList = [
    _BetChip('2', 2),
    _BetChip('5', 5),
    _BetChip('10', 10),
    _BetChip('50', 50),
    _BetChip('100', 100),
    _BetChip('200', 200),
    _BetChip('500', 500),
    _BetChip('自定义', 0),
  ];

  @override
  void initState() {
    _selectIndex = chipList.indexWhere(
      (e) => e.value == widget.chip,
    );
    if (_selectIndex == -1) {
      _selectIndex = chipList.length - 1;
      chipList.last.value = widget.chip;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.customTheme.colors0xFFFFFF,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Text(
              '设置筹码',
              style: TextStyle(
                color: widget.customTheme.colors0x000000,
                fontSize: 16,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: chipList.length,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 72 / 78,
              mainAxisSpacing: 10,
              crossAxisSpacing: 22,
            ),
            itemBuilder: (BuildContext context, int index) {
              bool isSelected = _selectIndex == index;
              return GestureDetector(
                key: ValueKey('$index-${chipList[index].value}'),
                onTap: () async {
                  if (index == chipList.length - 1) {
                    int? cusChip = await showCustomBottomSheet(
                      context,
                      customTheme: widget.customTheme,
                    );
                    if (cusChip == null) {
                      return;
                    }
                    chipList[index].value = cusChip;
                  }
                  _selectIndex = index;
                  setState(() {});
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: [5, if (isSelected) 0 else 4],
                  color: isSelected
                      ? widget.customTheme.colors0x5200FF
                      : widget.customTheme.colors0xD9D9D9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  radius: const Radius.circular(4),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/game_page/live_game/chip_${index + 1}.webp',
                          width: 55,
                          height: 55,
                        ),
                        Text(
                          chipList[index].name,
                          style: TextStyle(
                            color: widget.customTheme.colors0x000000,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_selectIndex < 0 ||
                        _selectIndex > chipList.length - 1) {
                      return;
                    }
                    Get.back(result: chipList[_selectIndex].value);
                  },
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        colors: [
                          widget.customTheme.colors0x6129FF,
                          widget.customTheme.colors0xD96CFF,
                        ],
                      ),
                    ),
                    child: Text(
                      "确定",
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.customTheme.colors0xFFFFFF,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BetChip {
  _BetChip(this.name, this.value);

  final String name;
  int value;
}
