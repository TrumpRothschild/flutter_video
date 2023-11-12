import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/live/anchor_card_bean.dart';

class CardProgress extends StatelessWidget {
  const CardProgress({
    Key? key,
    required this.anchorCard,
  }) : super(key: key);

  final AnchorCardBean anchorCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 6),
          const Text(
            '获取名片进度',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const Text(
            '赠送礼物达到要求即可获取',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Assets.livePage.cardProgressCrown.image(
                width: 35,
                height: 30,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Assets.livePage.cardProgressBegin.image(
                    width: 15,
                    height: 15,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: anchorCard.currentAmount / anchorCard.maxLimit,
                          color: Colors.white,
                          minHeight: 5,
                          backgroundColor: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  Assets.livePage.cardProgressEnd.image(
                    width: 15,
                    height: 15,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                '${anchorCard.currentAmount}/${anchorCard.cardLimit}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
        ],
      ),
    );
  }
}
