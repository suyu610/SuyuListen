import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/sample_data/data.dart';
import 'package:SuyuListening/ui/pages/listen.dart';
import 'package:SuyuListening/ui/pages/word_detail_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ), // status bar brightness,

      backgroundColor: gradientStartColor,
      body: Container(
        decoration: BoxDecoration(
          color: gradientStartColor,
          // gradient: LinearGradient(
          //     colors: [gradientStartColor, gradientEndColor],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     stops: [1.0, 1.0])
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        GestureDetector(
                            child: Icon(
                              Ionicons.chevron_back_outline,
                              color: Colors.white,
                            ),
                            onTap: () => Navigator.pop(context)),
                        SizedBox(
                          width: 30.w,
                        ),
                        Text(
                          'Word List',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 64.sp,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.black,
                      style: new TextStyle(color: Colors.red),
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Major Space Missions Planned',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 32.sp,
                              color: const Color(0x7cdbf1ff),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Major Space Missions Planned1',
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 32.sp,
                              color: const Color(0x7cdbf1ff),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Major Space Missions Planned2',
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 32.sp,
                              color: const Color(0x7cdbf1ff),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Major Space Missions Planned3',
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 32.sp,
                              color: const Color(0x7cdbf1ff),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(
                          Ionicons.chevron_down_outline,
                          color: const Color(0x7cdbf1ff),
                        ),
                      ),
                      underline: SizedBox(),
                    ),
                  ],
                ),
              ),
              Container(
                height: 830.h,
                padding: const EdgeInsets.only(left: 32),
                child: Swiper(
                  itemCount: planets.length,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 55,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        // activeSize: 28.w,
                        space: 16.w,
                        activeColor: ThemeColors.colorTheme),
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 120.h),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 200.h),
                                    GestureDetector(
                                      onTap: () {
                                        print("播放音频手势");
                                      },
                                      child: Row(
                                        children: [
                                          Hero(
                                            tag: planets[index].name,
                                            child: Text(
                                              planets[index].name,
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 74.sp,
                                                color: const Color(0xff47455f),
                                                fontWeight: FontWeight.w900,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Icon(
                                          //     Icons.headset_mic_rounded,
                                          //     size: 46.sp,
                                          //     color: const Color(0xff47455f),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      '抛弃;放弃;放纵;抛弃;放弃;放纵;抛弃;\n放弃;放纵;抛弃;放弃;放纵;\n抛弃;放弃;放纵;抛弃;放弃;放纵',
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontFamily: 'Avenir',
                                        fontSize: 30.sp,
                                        color: primaryTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Icon(Icons.bookmark_border,
                                                size: 44.sp,
                                                color: Colors.black),
                                          ),
                                          onTap: () {
                                            EasyLoading.showToast("已收藏");
                                          },
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Icon(
                                                Icons.headset_mic_rounded,
                                                size: 44.sp,
                                                color: Colors.black),
                                          ),
                                          onTap: () {
                                            EasyLoading.showToast("播放音频");
                                          },
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: gradientStartColor),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  bottom: 10.0,
                                                  left: 20,
                                                  right: 20),
                                              child: Text(
                                                '详细',
                                                style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize: 30.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Hero(
                          tag: planets[index].position,
                          child: Image.asset(planets[index].iconImage),
                        ),
                        Hero(
                          tag: index.toString() + "name",
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) =>
                                      WordDetailPage(
                                    planetInfo: planets[index],
                                  ),
                                ),
                              )
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 300.h, left: 320.w),
                              child: Text(
                                planets[index].position.toString(),
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 200,
                                  color: primaryTextColor.withOpacity(0.08),
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.0),
          ),
          color: Colors.white,
        ),
        // padding: const EdgeInsets.all(10),
        child: Container(
            height: 130.h,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () => CoolAlert.show(
                    context: context,
                    type: CoolAlertType.confirm,
                    backgroundColor: Colors.transparent,
                    confirmBtnColor: ThemeColors.colorTheme,
                    confirmBtnTextStyle: TextStyle(color: Colors.black),
                    lottieAsset: "assets/lotties/money.json",
                    confirmBtnText: "确定",
                    cancelBtnText: "取消",
                    cancelBtnTextStyle: TextStyle(color: Colors.black),
                    title: "花 1 个积分，来查看文章简介?",
                    onConfirmBtnTap: () => {
                          Navigator.pop(context),
                          showMaterialModalBottomSheet(
                            expand: false,
                            context: context,
                            bounce: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              height: 400,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(36.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "这篇文章包含了巴拉巴拉",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Container(
                                      width: 300,
                                      padding: const EdgeInsets.all(18.0),
                                      margin: const EdgeInsets.all(18.0),
                                      decoration: BoxDecoration(
                                          color: gradientStartColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                                offset: Offset(5, 1),
                                                color: Colors.black12)
                                          ]),
                                      child: Text(
                                        "开始!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        }),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                              color: Colors.black12))),
                  width: 200.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_sharp,
                        size: 34.sp,
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      // Text("查看文章简介"),
                      RatingBar(
                        rating: 3,
                        icon: Icon(
                          Icons.star,
                          size: 30.sp,
                          color: Colors.grey.shade300,
                        ),
                        color: gradientEndColor,
                        starCount: 5,
                        spacing: 1.0.w,
                        size: 30.w,
                        isIndicator: true,
                        allowHalfRating: true,
                        onRatingCallback:
                            (double value, ValueNotifier<bool> isIndicator) {
                          print('Number of stars-->  $value');
                          //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                          isIndicator.value = true;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ListenPage();
                  }))
                },
                child: Container(
                  width: 505.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        // child: Icon(
                        //   Ionicons.star_outline,
                        //   size: 34.sp,
                        // ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        "开始测试",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ])),
      ),
    );
  }
}
