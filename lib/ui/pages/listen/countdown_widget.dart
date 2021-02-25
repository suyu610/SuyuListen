import '../../../constant/theme_color.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountdownWidget extends StatefulWidget {
  CountdownWidget({Key key}) : super(key: key);

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  CountDownController _timerController;
  @override
  void initState() {
    _timerController = CountDownController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: (BorderSide(width: 1, color: Colors.black.withAlpha(0)))),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _timerController.start();
              },
              child: CircularCountDownTimer(
                duration: 100,
                controller: _timerController,
                width: 200.w,
                height: 200.h,
                color: Colors.white.withAlpha(40),
                fillColor: yellow,
                autoStart: true,
                backgroundColor: Colors.transparent,
                strokeWidth: 15.0.w,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                    fontSize: 33.0.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.MM_SS,
                isReverse: false,
                isReverseAnimation: false,
                isTimerTextShown: true,
                onStart: () {
                },
                onComplete: () {
                },
              ),
            ),
            Text(
              "今日学习时间",
              style: TextStyle(
                color: Colors.white.withAlpha(80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
