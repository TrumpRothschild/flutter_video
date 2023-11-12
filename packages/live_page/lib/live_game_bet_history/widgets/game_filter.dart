import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/game/game_type_model.dart';

class GameFilter extends StatefulWidget {
  const GameFilter({
    Key? key,
    required this.types,
    required this.selectedIndex,
    required this.customTheme,
  }) : super(key: key);

  final List<GameTypeModel?> types;
  final int selectedIndex;
  final CustomTheme customTheme;

  @override
  State<GameFilter> createState() => _GameFilterState();
}

class _GameFilterState extends State<GameFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.customTheme.colors0xF5F5F5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: widget.customTheme.colors0xE6E6E6)),
            ),
            child: Text(
              '选择彩种类型',
              style: TextStyle(
                color: widget.customTheme.colors0x000000,
                fontSize: 16,
              ),
            ),
          ),
          Flexible(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                  .copyWith(bottom: 20 + MediaQuery.of(context).padding.bottom),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 114 / 37,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: widget.types.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.types[index];
                return InkWell(
                  onTap: () => Get.back(result: index),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == index
                          ? null
                          : widget.customTheme.colors0xFFFFFF,
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.selectedIndex == index ? 20 : 5),
                      ),
                      border: Border.all(
                        color: widget.selectedIndex == index
                            ? Colors.transparent
                            : widget.customTheme.colors0xD9D9D9,
                      ),
                      gradient: widget.selectedIndex == index
                          ? LinearGradient(
                              colors: [
                                widget.customTheme.colors0x6129FF,
                                widget.customTheme.colors0xD96CFF,
                              ],
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        item?.name ?? '',
                        style: TextStyle(
                          color: widget.selectedIndex == index
                              ? widget.customTheme.colors0xFFFFFF
                              : widget.customTheme.colors0x838383,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
