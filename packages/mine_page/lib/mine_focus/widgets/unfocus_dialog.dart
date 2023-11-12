import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnfocusDialog extends StatelessWidget {
  const UnfocusDialog({
    Key? key,
    required this.customTheme,
    required this.onUnfocus,
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback onUnfocus;

  @override
  Widget build(BuildContext context) {
    // Row：约束 Container 宽度
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: customTheme.colors0xFAFAFC,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 14),
              Assets.minePage.unfocusCry.image(
                width: 121,
                height: 94,
              ),
              const SizedBox(height: 8),
              Text(
                '真的不喜欢我了吗？',
                style: TextStyle(
                  color: customTheme.colors0x000000,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 17),
              Container(
                color: customTheme.colors0xD1D1D1,
                width: 260,
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              const SizedBox(height: 9),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: Get.back,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        '算了吧',
                        style: TextStyle(
                          color: customTheme.colors0x000000,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: customTheme.colors0xD1D1D1,
                    width: 1,
                    height: 26,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  InkWell(
                    onTap: onUnfocus,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        '确 定',
                        style: TextStyle(
                          color: customTheme.colors0x000000,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
