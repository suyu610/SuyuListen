import 'package:flutter/material.dart';

/// ["ab\ncd"] => [Text(ab),Text(cd)]
List<Text> splitWrapStr(
    String orginStr, TextStyle textStyle, TextAlign textAlign) {
  if (orginStr == null) return [Text("加载中..")];
  List<String> splitStr = orginStr.split("\\n");

  return splitStr.map((e) {
    return Text(
      e,
      style: textStyle,
      textAlign: textAlign,
    );
  }).toList();
}

String wordTagSwitch(String tag) {
  switch (tag) {
    case "ky":
      return "考研";
      break;
    case "gk":
      return "高考";
      break;
    case "ielts":
      return "雅思";
      break;

    default:
      return tag;
  }
}
