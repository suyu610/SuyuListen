import 'package:flutter/material.dart';

class ThemeColors {
  ///主色调，按钮，特殊需要强调和突出的文字
  static Color colorTheme = Color.fromRGBO(254, 212, 91, 1);
  // static Color colorTheme = Color(0xff00a7f0);

  ///主色调渐变用色，个别按钮和状态，从colorBtnLeft变化到colorBtnRight
  static Color colorBtnLeft = Color.fromRGBO(255, 251, 156, 51);
  static Color colorBtnRight = Color.fromRGBO(255, 252, 191, 50);

  ///提示性文字，状态信息，按钮等
  static Color colorRed = Color.fromRGBO(255, 226, 36, 39);

  ///功能性较强的文字，内页标题等
  static Color color333333 = Color.fromRGBO(255, 51, 51, 51);

  ///正文，副标题以及可点击区域的主要文字和图标
  static Color color666666 = Color.fromRGBO(255, 102, 102, 102);

  ///弱化信息，提示性文字信息，不可点击状态
  static Color color999999 = Color.fromRGBO(255, 153, 153, 153);

  ///弱化信息，提示性文字信息
  static Color colorDDDDDD = Color.fromARGB(255, 221, 221, 221);

  ///背景区域划分，分割线
  static Color colorF6F6F8 = Color.fromARGB(255, 246, 246, 248);

  ///纯白色
  static Color colorWhite = Color.fromARGB(255, 255, 255, 255);

  ///纯黑色
  static Color colorBlack = Color.fromARGB(255, 0, 0, 0);
}

Color primaryTextColor = Color(0xFF414C6B);
Color secondaryTextColor = Color(0xFFE4979E);
Color titleTextColor = Colors.white;
Color contentTextColor = Color(0xff868686);
Color gradientEndColor = ThemeColors.colorTheme; //Color(0xFF0050AC);
Color gradientStartColor = Color(0xFF00a7f0); //Color(0xFF9354B9);
Color navigationColor = gradientStartColor;
Color mBackgroundColor = Color(0xFFFFFFFF);

Color mPrimaryColor = Color(0xFFB98068);

Color mPrimaryTextColor = Color(0xFF8C746A);

Color mSecondTextColor = Color(0xFFB98068);

Color mSecondColor = Color(0xFFC28E79);

Color mFacebookColor = Color(0xFF4277BC);

Color mTitleTextColor = Color(0xFF2D140D);

List<String> coffeeNames = [
  'Espresso',
  'Cappuccino',
  'Macciato',
  'Mocha',
  'Latte',
];
