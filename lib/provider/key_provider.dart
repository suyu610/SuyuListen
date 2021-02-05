import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class KeyProvider with ChangeNotifier {
  final FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
  GlobalKey<InnerDrawerState> innerDrawerKey;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isFocusMode = false;

  void switchFocusMode() {
    isFocusMode = !isFocusMode;
    notifyListeners();
  }
}
