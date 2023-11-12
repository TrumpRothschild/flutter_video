import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:base/commons/utils/extension.dart';

import '../../utils/ticket_function_bean.dart';

class YFLHCLotteryResult extends StatelessWidget {
  final GameTicketModel? model;
  final CustomTheme customTheme;

  const YFLHCLotteryResult({
    Key? key,
    required this.model,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get ticket => TicketUtils.getResultImageYFLHC(
      model?.lastKjNumber ?? '', model?.year ?? '');

  List<String> get resourceIds => ticket.resourceIds ?? [];

  List<String> get resourceIds2 => ticket.resourceIds2 ?? [];

  String get number => '六合彩 ${model?.lastKjNo}期';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(5).copyWith(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12,
                color: customTheme.colors0xFFDB5C,
              ),
            ),
          ),
          Row(
            children: resourceIds
                .mapIndexed((item, index) => index == resourceIds.length - 2
                    ? AssetGenImage(item).image(
                        height: 8,
                        fit: BoxFit.fitHeight,
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.5),
                        child: AssetGenImage(item).image(
                          height: 20,
                          fit: BoxFit.fitHeight,
                        ),
                      ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
