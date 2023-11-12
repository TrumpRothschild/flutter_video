import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:base/commons/utils/extension.dart';

import '../../utils/ticket_function_bean.dart';

class YFSSCLotteryItem extends StatelessWidget {
  final GameTicketModel? model;
  final bool isLast;
  final CustomTheme customTheme;

  const YFSSCLotteryItem({
    Key? key,
    required this.model,
    this.isLast = false,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get ticket => TicketUtils.getResultImageYFSSC(
      isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

  List<String> get resourceIds => ticket.resourceIds ?? [];

  List<String> get resourceIds2 => ticket.resourceIds2 ?? [];

  String get number => '第${isLast ? model?.lastKjNo : model?.kjNo}期';

  @override
  Widget build(BuildContext context) {
    if (model == null) return Container();
    if (isLast) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: resourceIds
                  .map((e) => Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff6129FF), Color(0xffD96CFF)],
                            stops: [0.03, 0.95],
                          ),
                          shape: CircleBorder(),
                        ),
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 12,
                            color: customTheme.colors0xFFFFFF,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: resourceIds2
                  .mapIndexed((e, index) => e.contains('assets')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.5),
                          child: AssetGenImage(e).image(
                            height: 22,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 2.5),
                          decoration: BoxDecoration(
                            color: customTheme.colors0xFFFFFF,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: 12,
                              color: customTheme.colors0xFF001F,
                            ),
                          ),
                        ))
                  .toList(),
            )
          ],
        ),
      );
    } else {
      return Container(
        height: 76,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: customTheme.colors0x848383))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: resourceIds
                  .map((e) => Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff6129FF), Color(0xffD96CFF)],
                            stops: [0.03, 0.95],
                          ),
                          shape: CircleBorder(),
                        ),
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 12,
                            color: customTheme.colors0xFFFFFF,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 5),
            Row(
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
                  children: resourceIds2
                      .mapIndexed((e, index) => e.contains('assets')
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.5),
                              child: AssetGenImage(e).image(
                                height: 22,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              width: 22,
                              height: 22,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.5),
                              decoration: BoxDecoration(
                                color: customTheme.colors0xFFFFFF,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(2)),
                              ),
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: customTheme.colors0xFF001F,
                                ),
                              ),
                            ))
                      .toList(),
                )
              ],
            ),
          ],
        ),
      );
    }
  }
}
