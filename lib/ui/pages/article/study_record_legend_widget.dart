import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/provider/key_provider.dart';
import 'package:SuyuListening/route/router_helper.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///右下角的图示

Widget studyRecordLegend(context) => Positioned(
      right: 0.w,
      top: 600.h,
      child: Row(
        children: [
          // 学习进度细节
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Ionicons.receipt_outline,
              color: Colors.black.withAlpha(70),
              size: 28.sp,
            ),
            onPressed: () =>
                {RouterHelper.router.navigateTo(context, "/records_detail")},
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Ionicons.information_circle_outline,
              color: Colors.black.withAlpha(70),
              size: 34.sp,
            ),
            onPressed: () => {
              showMaterialModalBottomSheet(
                expand: false,
                context: context,
                bounce: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Container(
                  height: 600.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(36.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "学习进度的图示",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Material(
                              color: Color(0xffe74c3c),
                              shape: SuperellipseShape(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                              child: Container(
                                height: 60.h,
                                width: 60.h,
                                child: Center(
                                  child: Icon(
                                      IconData(0xe6ec,
                                          fontFamily: "appIconFonts"),
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Text(
                              "x 5",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(width: 250.w, child: Text("学习进度 < 30%")),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Material(
                              color: blue.withAlpha(100),
                              shape: SuperellipseShape(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                              child: Container(
                                height: 60.h,
                                width: 60.h,
                                child: Center(
                                  child: Text(
                                    "x",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "x 15",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(width: 250.w, child: Text("学习进度 > 30%")),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Material(
                              color: blue.withAlpha(180),
                              shape: SuperellipseShape(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                              child: Container(
                                height: 60.h,
                                width: 60.h,
                                child: Center(
                                  child: Text(
                                    "x",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "x 5",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(width: 250.w, child: Text("学习进度 > 60%")),
                          ],
                        ),

                        ///他的标志
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Badge(
                              badgeColor: Colors.white,
                              elevation: 0,
                              badgeContent: Icon(
                                Icons.star,
                                size: 20.sp,
                              ),
                              child: Material(
                                color: blue,
                                shape: SuperellipseShape(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                child: Container(
                                  height: 60.h,
                                  width: 60.h,
                                  child: Center(
                                    child: Icon(
                                      Icons.star,
                                      // IconData(0xe600, fontFamily: "appIconFonts"),
                                      color: colorWhite,
                                      size: 34.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "x 6",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                                width: 250.w, child: Text("全部学完\n右上角表示他已学完")),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 70.h,
                            width: 300,
                            padding: const EdgeInsets.all(10.0),
                            // margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "知道了",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            },
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Ionicons.search_outline,
              color: Colors.black.withAlpha(70),
              size: 30.sp,
            ),
            onPressed: () => {
              Provider.of<KeyProvider>(context, listen: false)
                  .floatingSearchBarController
                  .open()
            },
          ),
        ],
      ),
    );
