import '../../../constant/theme_color.dart';
import '../../../sample_data/data.dart';
import '../../../ui/components/buttons/fancy_button.dart';
import '../../../ui/pages/listen.dart';
import '../../../ui/pages/word_detail_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flip_card/flip_card.dart';
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
  bool wordIsTap = false;
  bool wordIsBookmark = false;
  List<GlobalKey<FlipCardState>> cardKeys = [];
  int currentIndex = 0;
  @override
  void initState() {
    cardKeys =
        List.generate(planets.length, (i) => new GlobalKey<FlipCardState>());

    super.initState();
  }

  void onIndexchanged(index) {
    currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ), // status bar brightness,

      backgroundColor: blue,
      body: Container(
        decoration: BoxDecoration(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                child: Icon(
                                  Ionicons.chevron_back_outline,
                                  color: Colors.white,
                                ),
                                onTap: () => Navigator.pop(context)),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              'Word List',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 64.sp,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Ionicons.water,
                            color: Colors.white,
                            size: 32.sp,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    // DropdownButton(
                    //   isExpanded: false,
                    //   dropdownColor: Colors.black,
                    //   style: new TextStyle(color: Colors.red),
                    //   items: [
                    //     DropdownMenuItem(
                    //       child: Text(
                    //         'Mor Space Missions Planned',
                    //         overflow: TextOverflow.ellipsis,
                    //         style: TextStyle(
                    //           fontFamily: 'Avenir',
                    //           fontSize: 32.sp,
                    //           color: const Color(0x7cdbf1ff),
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //     DropdownMenuItem(
                    //       child: Text(
                    //         'Major Space Missions Planned1',
                    //         style: TextStyle(
                    //           fontFamily: 'Avenir',
                    //           fontSize: 32.sp,
                    //           color: const Color(0x7cdbf1ff),
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //     DropdownMenuItem(
                    //       child: Text(
                    //         'Major Space Missions Planned2',
                    //         style: TextStyle(
                    //           fontFamily: 'Avenir',
                    //           fontSize: 32.sp,
                    //           color: const Color(0x7cdbf1ff),
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //     DropdownMenuItem(
                    //       child: Text(
                    //         'Major Space Missions Planned3',
                    //         style: TextStyle(
                    //           fontFamily: 'Avenir',
                    //           fontSize: 32.sp,
                    //           color: const Color(0x7cdbf1ff),
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ],
                    //   onChanged: (value) {},
                    //   icon: Padding(
                    //     padding: const EdgeInsets.only(left: 16.0),
                    //     child: Icon(
                    //       Ionicons.chevron_down_outline,
                    //       color: const Color(0x7cdbf1ff),
                    //     ),
                    //   ),
                    //   underline: SizedBox(),
                    // ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180.w,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 25.w,
                            height: 25.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: silver,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Learning",
                            style: TextStyle(
                              color: Color(0x7cdbf1ff),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "2",
                            style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 25.w,
                            height: 25.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffff6324).withAlpha(220),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Reviewing",
                            style: TextStyle(color: Color(0x7cdbf1ff)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "10",
                            style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 25.w,
                            height: 25.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: yellow,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Mastered",
                            style: TextStyle(color: Color(0x7cdbf1ff)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "3",
                            style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Container(
                height: 600.h,
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 32),
                child: Swiper(
                  onIndexChanged: (index) => onIndexchanged(index),
                  itemCount: planets.length,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 55,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        activeSize: 5,
                        size: 5,
                        space: 5.w,
                        color: Colors.transparent,
                        activeColor: Colors.transparent),
                  ),
                  itemBuilder: (context, index) {
                    return FlipCard(
                      key: cardKeys[index],
                      speed: 350,
                      direction: FlipDirection.VERTICAL,
                      front: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 60.h,
                              ),
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 50.h),
                                      GestureDetector(
                                        onTap: () {
                                          print("播放音频手势");
                                        },
                                        child: Text(
                                          planets[index].name,
                                          style: TextStyle(
                                            fontFamily: 'Avenir',
                                            fontSize: 74.sp,
                                            color: const Color(0xff47455f),
                                            fontWeight: FontWeight.w900,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      SizedBox(height: 40.h),
                                      // 音标
                                      Container(
                                        height: 140.h,
                                        child: Text(
                                          "英 / ˈjʊərənəs /    美 / ˈjʊrənəs /",
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontFamily: 'Avenir',
                                            fontSize: 30.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder:
                                                        (context, a, b) =>
                                                            WordDetailPage(
                                                      planetInfo:
                                                          planets[index],
                                                    ),
                                                  ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: blue),
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
                                          SizedBox(
                                            width: 80.w,
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Icon(
                                                  Icons.headset_mic_rounded,
                                                  size: 44.sp,
                                                  color: Colors.black),
                                            ),
                                            onTap: () {
                                              EasyLoading.showToast("播放音频");
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //顶部头像
                          Positioned(
                            top: 10.h,
                            right: 0.w,
                            child: Hero(
                              tag: planets[index].position,
                              child: Image(
                                width: 220.w,
                                fit: BoxFit.fill,
                                image: AssetImage(planets[index].iconImage),
                              ),
                            ),
                          ),
                          //数字
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              margin: EdgeInsets.only(top: 200.h, left: 390.w),
                              child: Text(
                                planets[index].position.toString(),
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 200.sp,
                                  color: primaryTextColor.withOpacity(0.04),
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                      back: Stack(children: [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 60.h,
                            ),
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
                                    SizedBox(height: 50.h),
                                    GestureDetector(
                                      onTap: () {
                                        print("播放音频手势");
                                      },
                                      child: Text(
                                        planets[index].name,
                                        style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: 40.sp,
                                          color: const Color(0xff47455f),
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                    // 详细
                                    Container(
                                      width: double.infinity,
                                      height: 180.h,
                                      child: Text(
                                        "n.火花;火星;电火花;(指品质或感情)一星，丝毫，一丁点\n\nv.引发;触发;冒火花;飞火星;产生电火花",
                                        maxLines: 6,
                                        style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: 30.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 90.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    );
                  },
                ),
              ),

              //控制区域
              Container(
                // height: 0.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 180.w,
                      height: 100.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FancyButton(
                          onPress: () async {},
                          label: "简单",
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                          // gradient: kInActiveButtonGradient
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180.w,
                      height: 100.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FancyButton(
                          onPress: () async {
                            setState(() {
                              wordIsTap = !wordIsTap;
                              cardKeys[currentIndex].currentState.toggleCard();
                            });
                          },
                          icon: Icon(
                              !wordIsTap
                                  ? Ionicons.eye_off
                                  : IconData(0xe68b,
                                      fontFamily: "appIconFonts"),
                              color: Colors.black),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180.w,
                      height: 100.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FancyButton(
                          onPress: () async {
                            setState(() {
                              wordIsBookmark = !wordIsBookmark;
                            });
                          },
                          icon: Icon(
                              wordIsBookmark
                                  ? Icons.bookmark
                                  : Ionicons.bookmark_outline,
                              color: Colors.black),
                          gradient: wordIsBookmark
                              ? kActiveButtonGradient
                              : LinearGradient(
                                  colors: <Color>[
                                    Colors.white,
                                    Colors.white,
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 20.h),
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
                    confirmBtnColor: yellow,
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
                                          color: blue,
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
                        color: yellow,
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
