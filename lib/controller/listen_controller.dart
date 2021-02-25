import 'dart:io';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/entity/entities.dart';
import 'package:SuyuListening/entity/lrc_entity.dart';
import 'package:SuyuListening/ui/components/dialog/custom_dialog_box.dart';
import 'package:SuyuListening/utils/storage_util.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:emoji_feedback/emoji_feedback.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:vibration/vibration.dart';

import 'page_controller.dart';

class ListenController extends ChangeNotifier implements MyPageController {
  BuildContext context;
  ArticleEntity articleEntity;

  @override
  Future<bool> initController(
      {ArticleEntity articleEntity, BuildContext context}) async {
    this.articleEntity = articleEntity;
    this.context = context;

    LrcEntity lrcEntity = new LrcEntity();
    lrcEntity.savePath = articleEntity.fileName;
    // 获取歌词
    await lrcEntity.init();
    articleEntity.lrcEntity = lrcEntity;

    // 获取音频
    getAudioExists();
    return true;
  }

  @override
  Future disposeController() async {
    return true;
  }

  var localPath = "";
  Future<String> getAudioExists() async {
    String path = await getAudiosFolderPath();
    localPath = "$path/${articleEntity.fileName}.mp3";
    File file = new File(localPath);
    if (await file.exists()) {
      return localPath;
    } else {
      // 下载
      var url =
          "https://cdns.qdu.life/suyuListen/files/${articleEntity.fileName}" +
              ".mp3";
      Dio dio = new Dio();
      var response = await dio.download(url, localPath,
          options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
          onReceiveProgress: (received, total) {
        if (total != -1) {
        }
      });

      if (response.statusCode == 200) {
        return localPath;
      } else {
        throw Exception("下载失败");
      }
    }
  }

  Color keyboardActionAreaColor = silver;
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
    if (_player == null) {
      _player = AudioPlayer();
    }
    return _player;
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

  AudioPlayer _player;

  playLocal() async {
    if (_player == null) {
      _player = AudioPlayer();
    }
    await getAudioExists();

    await _player.setFilePath(localPath);
    _player.seek(duration);
    _player.play();
  }

  Duration duration = Duration(microseconds: 0);
  pause() async {
    duration = _player.position;
    _player.pause();
  }

  bool isKeyboardVisible = false;

  bool isPlaying = false;
  void onTapPlayButton() {
    if (isPlaying) {
      pause();
    } else {
      playLocal();
    }

    isPlaying = !isPlaying;
    notifyListeners();
  }

  // 完成时候的对话框
  void showCompelete() {
    Dialogs.materialDialog(
        color: Colors.white,
        msg: '今日目标达成!\n他还只完成了57%',
        title: '真棒!',
        animation: 'assets/lotties/cong_example.json',
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title: "这篇文章难度怎么样?",
                      contentWidget: EmojiFeedback(
                        onChange: (index) {
                        },
                      ),
                      text: "提交",
                    );
                  });
            },
            text: '我真棒',
            iconData: Icons.star,
            color: blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}
