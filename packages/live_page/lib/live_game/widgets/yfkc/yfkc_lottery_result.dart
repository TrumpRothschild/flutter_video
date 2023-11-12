import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:base/commons/utils/extension.dart';

import '../../utils/ticket_function_bean.dart';

class YFKCLotteryResult extends StatelessWidget {
  final GameTicketModel? model;
  final CustomTheme customTheme;

  const YFKCLotteryResult({
    Key? key,
    required this.model,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get ticket =>
      TicketUtils.getResultImageYFKC(model?.lastKjNumber ?? '');

  List<String> get resourceIds => ticket.resourceIds ?? [];

  List<String> get resourceIds2 => ticket.resourceIds2 ?? [];

  String get number => '一分快车 ${model?.lastKjNo}期';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(10).copyWith(top: 5),
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
                .map((item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.5),
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
