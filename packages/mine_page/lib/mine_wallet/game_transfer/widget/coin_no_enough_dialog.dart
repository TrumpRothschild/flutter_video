import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinNoEnoughDialog extends StatelessWidget {
  const CoinNoEnoughDialog({
    Key? key,
    required this.customTheme,
    required this.toEarn,
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback toEarn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: customTheme.colors0xFFFFFF,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  children: [
                    Text(
                      '抱歉，您的可提现金币不足！',
                      style: TextStyle(
                        color: customTheme.colors0x000000,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '最低1金币起才能提现哦~',
                      style: TextStyle(
                        color: customTheme.colors0xA0A0A0,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              InkWell(
                onTap: toEarn,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [
                        customTheme.colors0x6129FF,
                        customTheme.colors0xD96CFF,
                      ],
                    ),
                  ),
                  child: Text(
                    '马上去赚钱',
                    style: TextStyle(
                      color: customTheme.colors0xFFFFFF,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: Get.back,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 49, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: customTheme.colors0x9F44FF,
                    ),
                  ),
                  child: Text(
                    '知道啦',
                    style: TextStyle(
                      color: customTheme.colors0x9F44FF,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
            ],
          ),
        ),
      ],
    );
  }
}
