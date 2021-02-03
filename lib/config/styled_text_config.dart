import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

Map<String, TextStyle> styledTextConfig = {
  "bold": boldStyle,
  'miss': missStyle,
  'trans': transStyle,
  'normal': normalStyle,
  'error': errorStyle,
};

TextStyle boldStyle = TextStyle(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.sp);

TextStyle missStyle = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    decorationThickness: 1,
    decorationColor: Colors.red.withAlpha(150),
    decorationStyle: TextDecorationStyle.solid,
    color: Colors.transparent);

TextStyle transStyle = TextStyle(
    fontSize: 30.sp,
    decorationThickness: 1,
    decorationStyle: TextDecorationStyle.solid,
    color: Colors.black);

TextStyle normalStyle = TextStyle(
    fontSize: 30.sp, fontWeight: FontWeight.normal, color: Colors.black);

TextStyle errorStyle = TextStyle(
    fontSize: 30.sp,
    decoration: TextDecoration.lineThrough,
    decorationThickness: 2,
    decorationColor: Colors.red.withAlpha(150),
    decorationStyle: TextDecorationStyle.solid,
    color: Colors.black);
