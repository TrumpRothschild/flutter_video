import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:base/commons/utils/extension.dart';

import '../../utils/ticket_function_bean.dart';

class YXXLotteryItem extends StatelessWidget {
  final GameTicketModel? model;
  final bool isLast;
  final CustomTheme customTheme;

  const YXXLotteryItem({
    Key? key,
    required this.model,
    this.isLast = false,
    required this.customTheme,
  }) : super(key: key);

  List<String> get resourceIds => TicketUtils.getYXXResultImage(
      isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

  String get number => '第${isLast ? model?.lastKjNo : model?.kjNo}期';

  @override
  Widget build(BuildContext context) {
    if (model == null) return Container();
    if (isLast) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: resourceIds
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: AssetGenImage(item).image(
                  height: 35,
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
            .toList(),
      );
    } else {
      return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: customTheme.colors0x848383))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 14,
                color: customTheme.colors0xFFFFFF,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: resourceIds
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.5),
                      child: AssetGenImage(item).image(
                  height: 35,
                  fit: BoxFit.fitHeight,
                ),
                    ),
              )
                  .toList(),
            )
          ],
        ),
      );
    }
  }
}
