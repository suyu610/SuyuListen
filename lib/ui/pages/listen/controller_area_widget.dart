import 'package:SuyuListening/controller/listen_controller.dart';
import 'package:ionicons/ionicons.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

class ControllerAreaWidget extends StatefulWidget {
  ControllerAreaWidget({Key key}) : super(key: key);

  @override
  _ControllerAreaWidgetState createState() => _ControllerAreaWidgetState();
}

class _ControllerAreaWidgetState extends State<ControllerAreaWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        Provider.of<ListenController>(context, listen: false)
            .isKeyboardVisible = visible;
        if (!visible) {
          _animationController.forward();
        } else {
          _animationController.animateBack(0);
        }
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return // 控制区域
        AnimatedContainer(
      curve: Curves.easeIn,
      height:
          Provider.of<ListenController>(context, listen: true).isKeyboardVisible
              ? 0.h
              : 125.h,
      duration: Duration(milliseconds: 300),
      child: Offstage(
        offstage: Provider.of<ListenController>(context, listen: true)
            .isKeyboardVisible,
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
                onTap: Provider.of<ListenController>(context, listen: false)
                    .onTapPlayButton,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Provider.of<ListenController>(context, listen: true).isPlaying
                          ? Ionicons.pause_circle
                          : Ionicons.play_circle,
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
