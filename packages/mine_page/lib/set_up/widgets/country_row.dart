import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class CountryRow extends StatelessWidget {
  const CountryRow({
    Key? key,
    required this.customTheme,
    required this.countryName,
  }) : super(key: key);

  final CustomTheme customTheme;
  final String countryName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '国家和地区',
          style: TextStyle(
            color: customTheme.colors0x000000,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          countryName,
          style: TextStyle(
            color: customTheme.colors0x000000,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 13),
        Icon(
          Icons.navigate_next,
          color: customTheme.colors0xDCDCDC,
          size: 22,
        )
      ],
    );
  }
}
