import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/game/follow_bet_model.dart';

import '../../utils/im_msg_utils.dart';

class FollowBet extends StatelessWidget {
  final String betFollowMessage;
  final CustomTheme customTheme;

  final Function(String? followId)? onFollowed;

  const FollowBet({
    Key? key,
    required this.customTheme,
    this.onFollowed,
    required this.betFollowMessage,
  }) : super(key: key);

  FollowBetModel? get model =>
      ImMsgUtils.of().convertFollowBet(betFollowMessage);

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return Container();
    }
    return InkWell(
      onTap: () => onFollowed?.call(model?.followId),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 250, maxHeight: 100),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: customTheme.colors0x000000_40,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Container(
                  height: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: customTheme.colors0x9F44FF,
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                  ),
                  child: Text(
                    '系统',
                    style: TextStyle(
                      fontSize: 11,
                      color: customTheme.colors0xFFFFFF,
                      height: 18 / 11,
                    ),
                  ),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(
                text: '用户',
                style: TextStyle(
                  fontSize: 13,
                  color: customTheme.colors0xFFFFFF,
                ),
              ),
              TextSpan(
                text: model?.nickName ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: customTheme.colors0x3EE8FF,
                ),
              ),
              TextSpan(
                text: '在',
                style: TextStyle(
                  fontSize: 13,
                  color: customTheme.colors0xFFFFFF,
                ),
              ),
              TextSpan(
                text: model?.ticketName ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: customTheme.colors0xFAFF00,
                ),
              ),
              TextSpan(
                text: '玩法中，已成功下注了',
                style: TextStyle(
                  fontSize: 13,
                  color: customTheme.colors0xFFFFFF,
                ),
              ),
              TextSpan(
                text: '${model?.amount ?? ''}',
                style: TextStyle(
                  fontSize: 13,
                  color: customTheme.colors0xFAFF00,
                ),
              ),
              TextSpan(
                text: '元',
                style: TextStyle(
                  fontSize: 13,
                  color: customTheme.colors0xFFFFFF,
                ),
              ),
              WidgetSpan(
                child: Container(
                  width: 40,
                  height: 18,
                  margin: const EdgeInsets.only(left: 4),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: customTheme.colors0xFF4949,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '>',
                          style: TextStyle(
                            fontSize: 11,
                            color: customTheme.colors0xFFFFFF,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: customTheme.colors0xFAFF00,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Text(
                            '跟投',
                            style: TextStyle(
                              fontSize: 11,
                              color: customTheme.colors0x000000,
                              height: 18 / 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
