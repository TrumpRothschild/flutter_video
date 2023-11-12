import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanchNoEnoughDialog extends StatelessWidget {
  const BalanchNoEnoughDialog({
    Key? key,
    required this.customTheme,
    required this.onRecharge,
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback onRecharge;

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
              const SizedBox(height: 27),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Text(
                  '钱包金币不足，是否前往充值？',
                  style: TextStyle(
                    color: customTheme.colors0x000000,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 23),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: customTheme.colors0xDEDEDE ?? Colors.transparent,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: Get.back,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 44, vertical: 10),
                        child: Text(
                          '取消',
                          style: TextStyle(
                            color: customTheme.colors0xADADAD,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                      child: VerticalDivider(
                        width: 1,
                        color: customTheme.colors0xDEDEDE,
                      ),
                    ),
                    InkWell(
                      onTap: onRecharge,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 44, vertical: 10),
                        child: Text(
                          '去充值',
                          style: TextStyle(
                            color: customTheme.colors0x000000,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
