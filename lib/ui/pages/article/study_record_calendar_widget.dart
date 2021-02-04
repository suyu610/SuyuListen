import 'dart:math';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/ui/components/dialog/popup.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget studyRecordCalendar(
        context, handleCalendarChanged, isMeMode, currentMonth) =>
    Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: CalendarCarousel<Event>(
        pageSnapping: false,
        locale: ('zh'),
        headerTextStyle: ThemeProvider.of(context).brightness == Brightness.dark
            ? TextStyle(color: Colors.white.withAlpha(50))
            : TextStyle(color: Colors.black.withAlpha(50)),
        weekdayTextStyle:
            ThemeProvider.of(context).brightness == Brightness.dark
                ? TextStyle(color: Colors.white.withAlpha(50))
                : TextStyle(color: Colors.black.withAlpha(50)),

        iconColor: ThemeProvider.of(context).brightness == Brightness.dark
            ? Colors.white.withAlpha(50)
            : Colors.black.withAlpha(50),

        isScrollable: false,
        headerMargin: EdgeInsets.all(0),
        weekFormat: false,
        onCalendarChanged: (date) => handleCalendarChanged(date.month),
        headerText: isMeMode
            ? "我的 " + currentMonth.toString() + "月 学习进度"
            : "他的 " + currentMonth.toString() + "月 学习进度",
        showOnlyCurrentMonthDate: true,
        markedDateCustomShapeBorder:
            CircleBorder(side: BorderSide(color: Colors.black)),
        // thisMonthDayBorderColor: Colors.black,
        selectedDayButtonColor: Colors.black,
        selectedDayBorderColor: Colors.transparent,
        dayButtonColor: Colors.transparent,
        selectedDayTextStyle: TextStyle(
          color: Colors.black,
        ),
        todayBorderColor: Colors.transparent,
        todayButtonColor: Colors.transparent,

        customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
          if (day.isAfter(DateTime.now())) {
            return Material(
              color: Colors.black.withAlpha(10),
              shape: SuperellipseShape(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: Container(
                height: 90.h,
                width: 90.h,
              ),
            );
          } else if (day.day == 10 || day.day == 25 || day.day == 18) {
            return GestureDetector(
              onTap: () {
                showPopup(context, () => Navigator.pop(context),
                    title: ("${day.month}月${day.day}日"),
                    buttonTitle: "关闭",
                    imageUrl: "assets/images/popup/fail.JPG",
                    buttonColor: Color(0xffe74c3c),
                    describe: "一点也没学习!!");
              },
              child: Badge(
                badgeColor: Theme.of(context).backgroundColor,
                elevation: 0,
                badgeContent: Icon(
                  Icons.star,
                  size: 20.sp,
                ),
                child: Material(
                  color: Colors.red,
                  shape: SuperellipseShape(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: Container(
                      height: 90.h,
                      width: 90.h,
                      child: Icon(
                          IconData(
                            0xe6ec,
                            fontFamily: "appIconFonts",
                          ),
                          color: Colors.white)),
                ),
              ),
            );
          } else if (isToday ||
              day.day == 18 ||
              day.day == 13 ||
              day.day == 7) {
            return GestureDetector(
              onTap: () {
                showPopup(context, () => Navigator.pop(context),
                    buttonTitle: "关闭",
                    title: ("${day.month}月${day.day}日"),
                    buttonColor: blue,
                    describe: "学习时长为${Random().nextInt(4)}小时\n完成进度:20%");
              },
              child: Badge(
                badgeContent: Icon(
                  Icons.star,
                  size: 20.sp,
                ),
                elevation: 0,
                badgeColor: Theme.of(context).backgroundColor,
                child: Material(
                  color: blue,
                  shape: SuperellipseShape(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: Container(
                    height: 90.h,
                    width: 90.h,
                    child: Center(
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 34.sp,
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (day.day == 1 || day.day == 5 || day.day == 19) {
            return GestureDetector(
              onTap: () {
                showPopup(context, () => Navigator.pop(context),
                    buttonTitle: "关闭",
                    title: ("${day.month}月${day.day}日"),
                    buttonColor: blue.withAlpha(180),
                    describe: "学习时长为${Random().nextInt(4)}小时\n完成进度:40%");
              },
              child: Material(
                color: blue.withAlpha(180),
                shape: SuperellipseShape(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                child: Container(
                  height: 90.h,
                  width: 90.h,
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                showPopup(context, () => Navigator.pop(context),
                    title: ("${day.month}月${day.day}日"),
                    buttonColor: blue.withAlpha(100),
                    buttonTitle: "关闭",
                    describe: "学习时长为${Random().nextInt(4)}小时\n完成进度:24%");
              },
              child: Material(
                color: blue.withAlpha(100),
                shape: SuperellipseShape(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                child: Container(
                  height: 90.h,
                  width: 90.h,
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          }
        },
        // weekDayMargin: EdgeInsets.zero,
        markedDateIconMargin: 0,
        height: 675.0.h,
        // selectedDateTime: _currentDate,
        daysHaveCircularBorder: false,
      ),
    );
