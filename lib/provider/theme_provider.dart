import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme;

  ThemeProvider(this._currentTheme);

  ThemeData getTheme() => _currentTheme;

  void changeTheme(ThemeData themeData) {
    _currentTheme = themeData;
    notifyListeners();
  }

  GlobalKey<InnerDrawerState> innerDrawerKey;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
}
