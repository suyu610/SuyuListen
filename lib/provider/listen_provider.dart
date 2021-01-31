import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class ListenProvider with ChangeNotifier {
  bool showCheckText = false;
  String checkText = "";

  void switchShowCheckText() {
    showCheckText = !showCheckText;
    notifyListeners();
  }

  int progress = 0;
  void setProgress(int progressValue) {
    progress = progressValue;
    notifyListeners();
  }

  AudioPlayer player;
  AudioPlayer getPlayerInstance() {
    if (player == null) {
      player = AudioPlayer();
    }
    return player;
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
