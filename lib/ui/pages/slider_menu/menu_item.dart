import 'package:SuyuListening/config/global.dart';

import '../../../constant/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MenuItem extends StatelessWidget {
  MenuItem({this.title, this.icon, this.tapAction, Key key}) : super(key: key);
  String title;
  IconData icon;
  Function tapAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        tapAction(),
        Global.innerDrawerKey.currentState
            .toggle(direction: InnerDrawerDirection.start),
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Padding(
          padding: EdgeInsets.only(top: 22.h, bottom: 22.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30.sp,
              ),
              SizedBox(width: 60.w),
              SizedBox(
                width: 140.w,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: kTitleTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
