import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:base/commons/utils/extension.dart';

import '../../utils/ticket_function_bean.dart';

class YFSSCLotteryResult extends StatelessWidget {
  final GameTicketModel? model;
  final CustomTheme customTheme;

  const YFSSCLotteryResult({
    Key? key,
    required this.model,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get ticket =>
      TicketUtils.getResultImageYFSSC(model?.lastKjNumber ?? '');

  List<String> get resourceIds => ticket.resourceIds ?? [];

  String get number => '时时彩 ${model?.lastKjNo}期';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
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
                .map((item) => Container(
                      width: 20,
                      height: 20,
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
                        item,
                        style: TextStyle(
                          fontSize: 12,
                          color: customTheme.colors0xFFFFFF,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
