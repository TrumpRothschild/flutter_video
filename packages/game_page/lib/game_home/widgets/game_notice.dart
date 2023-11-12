import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';

import '../game_home_controller.dart';

class GameNotice extends StatelessWidget {
  final VoidCallback? onTransactionTap;

  const GameNotice({Key? key, this.onTransactionTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameHomeController>(
        id: "gameNoticeData",
        builder: (controller) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDimens.w_10)
                .copyWith(bottom: AppDimens.h_5),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: AppDimens.h_32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(AppDimens.w_16)),
                        gradient: LinearGradient(colors: [
                          Color(0xffEDE4FF),
                          Color(0x00F4F0FF),
                        ], stops: [
                          0.0003,
                          0.9923
                        ]),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image(
                              image: AssetImage(
                                Assets.gamePage.notice.path,
                              ),
                              width: 18,
                            ),
                          ),
                          Expanded(
                            child: Marquee(
                                directionMarguee: DirectionMarguee.oneDirection,
                                animationDuration: const Duration(seconds: 10),
                                backDuration: const Duration(seconds: 5),
                                pauseDuration:
                                    const Duration(milliseconds: 100),
                                forwardAnimation:
                                    const Cubic(1.0, 1.0, 1.0, 1.0),
                                autoRepeat: true,
                                child: Wrap(children: [
                                  Text(
                                    controller.marqueeContent.value,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff9F44FF),
                                    ),
                                  ),
                                ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTransactionTap,
                    child: Image(
                      image: AssetImage(
                        Assets.gamePage.rechargeWithdrawRecord.path,
                      ),
                      width: 75,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
