import 'dart:io';

import 'package:SuyuListening/utils/storage_util.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ionicons/ionicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../provider/listen_provider.dart';
import 'package:flutter/material.dart';

class ControllerAreaWidget extends StatefulWidget {
  ControllerAreaWidget({Key key}) : super(key: key);

  @override
  _ControllerAreaWidgetState createState() => _ControllerAreaWidgetState();
}

Future<void> download() async {
  String audiosDir = await getAudiosFolderPath();
  createFolder(audiosDir);
  print("==============");
  print(audiosDir);
  print("==============");
  // ignore: unused_local_variable
  final taskId = await FlutterDownloader.enqueue(
    url:
        'https://files.21voa.com/202101/technology-problems-linked-to-higher-stress-levels-in-workers.mp3',
    savedDir: audiosDir,
    showNotification:
        true, // show download progress in status bar (for Android)
    openFileFromNotification:
        true, // click on notification to open downloaded file (for Android)
  );
}

class _ControllerAreaWidgetState extends State<ControllerAreaWidget>
    with SingleTickerProviderStateMixin {
  AudioPlayer _player;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print(visible);
        isKeyboardVisible = visible;
        if (!visible) {
          _animationController.forward();
        } else {
          _animationController.animateBack(0);
        }
        setState(() {});
      },
    );
    _player =
        Provider.of<ListenProvider>(context, listen: false).getPlayerInstance();
    super.initState();
  }

  String localFilePath = "";

  Future _loadFile() async {
    String audioPath = await getAudiosFolderPath();
    final file = File(
        '$audioPath/technology-problems-linked-to-higher-stress-levels-in-workers.mp3');
    if (await file.exists()) {
      setState(() {
        localFilePath = file.path;
      });
    } else {
      download();
      print("文件不存在");
    }
  }

  playLocal() async {
    await _loadFile();
    await _player.setFilePath(localFilePath);
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
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return // 控制区域
        AnimatedContainer(
      curve: Curves.easeIn,
      height: isKeyboardVisible ? 0.h : 125.h,
      duration: Duration(milliseconds: 300),
      child: Offstage(
        offstage: isKeyboardVisible,
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: 750.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.repeat,
                    color: Colors.white,
                  ),
                  Text(
                    "重复单句",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.skip_previous_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    "上一句",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              GestureDetector(
                onTap: onTapPlayButton,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isPlaying ? Ionicons.pause_circle : Ionicons.play_circle,
                      color: Colors.white,
                      size: 106.sp,
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.skip_next_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    "下一句",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.rocket_outline,
                    color: Colors.white,
                  ),
                  Text(
                    "倍速",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
