import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class KeyProvider with ChangeNotifier {
  GlobalKey<InnerDrawerState> innerDrawerKey;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
}
