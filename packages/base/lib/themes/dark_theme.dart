import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'ping_fang_sc_medium',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  backgroundColor: Colors.black,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    unselectedItemColor: Colors.white,
    selectedItemColor: Colors.redAccent,
    elevation: 0,
  ),
  highlightColor: Colors.transparent,
  splashColor: const Color.fromRGBO(0, 0, 0, 0),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    elevation: 0,
    centerTitle: true,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  ),
);


// CustomTheme dartCustomTheme = CustomTheme(
//   colors0x000000: HexColor('#000000'),
//   colors0xD8D8D8: HexColor('#D8D8D8'),
//   colors0xF10000: HexColor('#F10000'),
//   colors0x000000_50: HexColor('#000000').withAlpha(128),
//   colors0x000000_30: HexColor('#000000').withAlpha(76),
//   colors0xFFFFFF_40: HexColor('#FFFFFF').withAlpha(102),
//   colors0xDEDEDE: HexColor('#DEDEDE'),
//   colors0x9F44FF: HexColor('#9F44FF'),
//   colors0xFB000F: HexColor('#FB000F'),
//   colors0xB1B1B1: HexColor('#B1B1B1'),
//   colors0xC1A7FF: HexColor('#C1A7FF'),
//   colors0x8D8D8D: HexColor('#8D8D8D'),
//   colors0x7032FF: HexColor('#7032FF'),
//   colors0xD7D7D7: HexColor('#D7D7D7'),
//   colors0x6129FF: HexColor('#6129FF'),
//   colors0xD96CFF: HexColor('#D96CFF'),
// );

