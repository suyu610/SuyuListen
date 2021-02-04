import '../../constant/theme_color.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

var themeSwitcher = ThemeSwitcher(
  clipper: ThemeSwitcherCircleClipper(),
  builder: (context) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 200),
      crossFadeState: ThemeProvider.of(context).brightness == Brightness.dark
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: GestureDetector(
        onTap: () => {
          ThemeSwitcher.of(context)
              .changeTheme(theme: lightTheme, reverseAnimation: true),
        },
        child: Icon(
          LineAwesomeIcons.sun,
          size: (kSpacingUnit.w * 4).sp,
        ),
      ),
      secondChild: GestureDetector(
        onTap: () => ThemeSwitcher.of(context).changeTheme(theme: darkTheme),
        child: Icon(
          LineAwesomeIcons.moon,
          size: ScreenUtil().setSp(kSpacingUnit.w * 4),
        ),
      ),
    );
  },
);
