import 'package:SuyuListening/constant/theme_color.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

class ListenProvider with ChangeNotifier {
  Color keyboardActionAreaColor = silver;
  AudioPlayer player;
  bool showCheckText = false;
  String checkText = "";

  void switchShowCheckText() {
    showCheckText = !showCheckText;
    notifyListeners();
  }

  ConfettiController _confettiController;

  ConfettiController get confettiController {
    return _confettiController ??
        (_confettiController =
            ConfettiController(duration: const Duration(seconds: 3)));
  }

  int progress = 0;
  void setProgress(int progressValue) {
    progress = progressValue;
    notifyListeners();
  }

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

  void success() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
    confettiController.play();
    notifyListeners();
  }

  void editing() {
    keyboardActionAreaColor = silver;
    notifyListeners();
  }

  void setCheckText(String text) {
    this.checkText = text;

    notifyListeners();
  }
}
