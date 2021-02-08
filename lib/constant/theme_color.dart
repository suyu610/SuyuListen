import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///主色调
const Color yellow = Color(0xffffe18c);//#ffe18c
const Color red = Color(0xfffa6064);//#fa6064
const Color blue = Color(0xff789aee);//#789aee
const Color orange = Color(0xffff9360);//#ff9360
const Color green = Color(0xff00e5b9);//#00e5b9

const Color silver = Color(0xffd9f0f1);//#d9f0f1
const Color darkSilver = Color(0xffe7eefb);//#e7eefb
const Color white = Color(0xffffffff);//#ffffff
const Color black = Color(0xff000000);


const listTileGradient = LinearGradient(
  stops: [0.4, 0.83],
  colors: <Color>[
    blue,
    Color(0xff56CCF2),
  ],
);
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

Color primaryTextColor = Color.fromARGB(255, 65, 76, 107);
// Color secondaryTextColor = Color(0xFFE4979E);
// Color titleTextColor = Colors.white;

const kSpacingUnit = 20;
const kDarkPrimaryColor = Color.fromARGB(255, 33, 33, 33);
const kDarkSecondaryColor = Color.fromARGB(255, 55, 55, 55);

const kLightPrimaryColor = Color.fromARGB(255, 255, 255, 255);
const kLightSecondaryColor = Color.fromARGB(255, 242, 245, 252);
const kAccentColor = yellow;

final kTitleTextStyle = TextStyle(
  fontSize: (kSpacingUnit.w * 2.5).sp,
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: (kSpacingUnit.w * 2.3).sp,
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: (kSpacingUnit.w * 2.3).sp,
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final List<MaterialColor> confettiColors = [
  Colors.green,
  Colors.blue,
  Colors.pink,
  Colors.orange,
  Colors.purple
];

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);
