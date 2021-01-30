import 'package:flutter/cupertino.dart';

class ListenProvider with ChangeNotifier {
  bool showCheckText = false;
  String checkText = "";

  void switchShowCheckText() {
    showCheckText = !showCheckText;
    notifyListeners();
  }

  void setShowCheckText() {
    showCheckText = true;
    notifyListeners();
  }
    void setHiddenCheckText() {
    showCheckText = false;
    notifyListeners();
  }

  void setCheckText(String text) {
    this.checkText = text;
    notifyListeners();
  }
}
