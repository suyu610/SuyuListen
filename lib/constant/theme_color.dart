import 'package:flutter/material.dart';

///主色调，按钮，特殊需要强调和突出的文字
const Color yellow = Color.fromRGBO(254, 212, 91, 1);
// const Color colorTheme = Color(0xff00a7f0);

///提示性文字，状态信息，按钮等
const Color colorRed = Color.fromRGBO(255, 226, 36, 39);

///功能性较强的文字，内页标题等
const Color color333333 = Color.fromRGBO(255, 51, 51, 51);

const Color silver = Color(0xfff2f5fc);
const Color purple = Color(0xff3c1361);
const Color darkSilver = Color(0xffe7eefb);
const kActiveButtonGradient = LinearGradient(
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  colors: <Color>[
    Color(0xffffc03d),
    Color(0xffffd03d),
    yellow,
  ],
);

const kInActiveButtonGradient = LinearGradient(
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  colors: <Color>[
    Color(0xffe7eefb),
    Color(0xfff2f5fc),
  ],
);

///正文，副标题以及可点击区域的主要文字和图标
const Color subTitleColor = Color(0xffc2c2c3);

///弱化信息，提示性文字信息，不可点击状态
const Color color999999 = Color.fromRGBO(255, 153, 153, 153);

///弱化信息，提示性文字信息
const Color colorDDDDDD = Color.fromARGB(255, 221, 221, 221);

///背景区域划分，分割线
const Color colorF6F6F8 = Color.fromARGB(255, 246, 246, 248);

///纯白色
const Color colorWhite = Color.fromARGB(255, 255, 255, 255);

const Color blue = Color(0xFF00a7f0);

///纯黑色
const Color colorBlack = Color.fromARGB(255, 0, 0, 0);

Color primaryTextColor = Color(0xFF414C6B);
Color secondaryTextColor = Color(0xFFE4979E);
Color titleTextColor = Colors.white;
Color contentTextColor = Color(0xff868686);
Color mBackgroundColor = Color(0xFFFFFFFF);

List<String> coffeeNames = [
  'Espresso',
  'Cappuccino',
  'Macciato',
  'Mocha',
  'Latte',
];
