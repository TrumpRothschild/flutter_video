import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circular_menu.dart';
import 'circular_menu_item.dart';

class DraggableCircularMenu extends StatelessWidget {
  final Widget backgroundWidget;

  final List<CircularMenuItem> items;

  const DraggableCircularMenu({
    Key? key,
    required this.backgroundWidget,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      alignment: Alignment.bottomCenter,
      backgroundWidget: backgroundWidget,
      toggleButtonOnPressed: () {},
      items: items,
    );
  }
}
