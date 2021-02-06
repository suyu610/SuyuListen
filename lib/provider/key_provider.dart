import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class KeyProvider with ChangeNotifier {
  // final FloatingSearchBarController floatingSearchBarController =
  //     FloatingSearchBarController();

  bool isFocusMode = false;

  void switchFocusMode() {
    isFocusMode = !isFocusMode;
    notifyListeners();
  }
}
