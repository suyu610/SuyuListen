import 'package:flutter/material.dart';

/// ["ab\ncd"] => [Text(ab),Text(cd)]
List<Text> splitWrapStr(String orginStr, TextStyle textStyle) {
  if (orginStr == null) return [Text("加载中..")];
  List<String> splitStr = orginStr.split("\\n");

  return splitStr.map((e) {
    return Text(
      e,
      style: textStyle,
    );
  }).toList();
}
