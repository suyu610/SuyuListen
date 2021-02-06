import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class KeyProvider with ChangeNotifier {
  bool isFocusMode = false;

  void switchFocusMode() {
    isFocusMode = !isFocusMode;
    notifyListeners();
  }
}
