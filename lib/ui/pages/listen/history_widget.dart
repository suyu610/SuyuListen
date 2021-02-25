// ignore: camel_case_types
import 'package:SuyuListening/constant/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryWidget extends StatefulWidget {
  HistoryWidget({Key key}) : super(key: key);
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

// ignore: camel_case_types
class _HistoryWidgetState extends State<HistoryWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  ScrollController historyController;
  List<String> historySentenceList = [
    "Technology Report",
    "This is America",
    "Science in the News",
    "Health Report",
    "Education Report",
    "Economics Report",
    "American Mosaic",
    "In the News",
    "American Stories"
  ];
  bool isKeyboardVisible = false;
  @override
  void initState() {
    // ThemeSwitcher.of(context).changeTheme(theme: lightTheme);
    // ThemeSwitcher.of(context)
    //     .changeTheme(theme: lightTheme, reverseAnimation: true);
    historyController = ScrollController();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        isKeyboardVisible = visible;
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
    return AnimatedContainer(
      curve: Curves.easeIn,
      color: Colors.transparent,
      height: isKeyboardVisible ? 150.h : 250.h,
      duration: Duration(milliseconds: 300),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              // border: Border.all(width: 2),
              color: silver,
              borderRadius: BorderRadius.circular(10)),
          child: ListView.builder(
            controller: historyController,
            itemCount: historySentenceList.length,
            physics: BouncingScrollPhysics(),
            //范围内进行包裹（内容多高ListView就多高）
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                historySentenceList[index],
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 28.sp),
              );
            },
          ),
        ),
      ),
    );
  }
}
