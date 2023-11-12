import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:base/commons/utils/extension.dart';

import '../../utils/ticket_function_bean.dart';

class YFKSLotteryResult extends StatelessWidget {
  final GameTicketModel? model;
  final CustomTheme customTheme;

  const YFKSLotteryResult({
    Key? key,
    required this.model,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get ticket =>
      TicketUtils.getResultImageYFKS(model?.lastKjNumber ?? '');

  List<String> get resourceIds => ticket.resourceIds ?? [];

  List<String> get resourceIds2 => ticket.resourceIds2 ?? [];

  String get number => '一分快三 ${model?.lastKjNo}期';

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
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: resourceIds
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.5),
                          child: AssetGenImage(e).image(
                            height: 24,
                            fit: BoxFit.fitHeight,
                          ),
                        ))
                    .toList(),
              ),
              Row(
                children: resourceIds2
                    .mapIndexed((e, index) => index == 0
                        ? Container(
                            width: 20,
                            height: 20,
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
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.5),
                            child: AssetGenImage(e).image(
                              height: 20,
                              fit: BoxFit.fitHeight,
                            ),
                          ))
                    .toList(),
              )
            ],
          )
        ],
      ),
    );
  }
}
