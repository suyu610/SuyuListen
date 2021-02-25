import 'package:SuyuListening/entity/entities.dart';
import 'package:SuyuListening/net/translation_api.dart';
import 'package:SuyuListening/route/router_helper.dart';
import 'package:SuyuListening/utils/format_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';

import '../../../constant/theme_color.dart';
import '../../../sample_data/data.dart';
import '../../components/buttons/fancy_button.dart';
import '../listen/listen_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class ArticleDetailPage extends StatefulWidget {
  final ArticleEntity articleEntity;
  const ArticleDetailPage({
    this.articleEntity,
    Key key,
  }) : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool wordIsTap = false;
  bool wordIsBookmark = false;
  AudioPlayer player;
  List<GlobalKey<FlipCardState>> cardKeys = [];
  int currentIndex = 0;
  List<SimpleWordEntity> wordlist;
  var _futureBuilderFuture;

  Future<List<SimpleWordEntity>> getWordList() async {
    wordlist =
        await getSimpleWordList(widget.articleEntity.wordlist.split(";"));

    return wordlist;
  }

  @override
  void initState() {
    player = AudioPlayer();
    cardKeys =
        List.generate(planets.length, (i) => new GlobalKey<FlipCardState>());
    _futureBuilderFuture = getWordList();
    super.initState();
  }

  // 点击播放音频
  void tapPlayAudioButton(String word) async {
    await player.setAudioSource(AudioSource.uri(
        Uri.parse("https://dict.youdao.com/dictvoice?audio=$word&type=2)")));
    player.play();
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
                              '赛前热身',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: 44.sp,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Ionicons.book_outline,
                            color: Colors.white,
                            size: 32.sp,
                          ),
                          onPressed: () {
                            RouterHelper.router
                                .navigateTo(context, "/word_book");
                          },
                        ),
                      ],
                    ),
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
                            "待学习",
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
                            "待复习",
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
                            "已掌握",
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
              FutureBuilder(
                future: _futureBuilderFuture,
                builder: _buildFuture,
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
                          titleColor: Colors.black,
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
                    return ListenPage(articleEntity: widget.articleEntity);
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

  Widget _buildFuture(
      BuildContext context, AsyncSnapshot<List<SimpleWordEntity>> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return new Text('Press button to start'); //如果_calculation未执行则提示：请点击开始
      case ConnectionState.waiting:
        return Container(
          height: 600.h,
          child: SpinKitWanderingCubes(
            color: Colors.white,
            size: 30.0,
          ),
        );
      //如果_calculation正在执行则提示：加载中
      default:
        if (snapshot.hasError) //若_calculation执行出现异常
          return new Text('Error: ${snapshot.error}');
        else //若_calculation执行正常完成
          return Container(
            height: 600.h,
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 32),
            child: Swiper(
              onIndexChanged: (index) => onIndexchanged(index),
              itemCount: snapshot.data.length,
              itemWidth: MediaQuery.of(context).size.width - 2 * 55,
              layout: SwiperLayout.STACK,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 50.h),
                                  Text(
                                    wordlist[index].word,
                                    style: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: 74.sp,
                                      color: const Color(0xff47455f),
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(height: 20.h),
                                  // 音标
                                  Container(
                                    height: 120.h,
                                    child: Text(
                                      "/ ${wordlist[index].phonetic} /",
                                      style: TextStyle(
                                        fontFamily: 'SFProText',
                                        fontSize: 30.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),

                                  //标签
                                  Row(
                                      children: wordlist[index].tag == ""
                                          ? [
                                              Container(
                                                height: 50.h,
                                              )
                                            ]
                                          : wordlist[index]
                                              .tag
                                              .split(" ")
                                              .map((element) {
                                              return Container(
                                                  height: 50.h,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Text(
                                                      wordTagSwitch(element),
                                                      style: TextStyle(
                                                        fontFamily: 'SFProText',
                                                        fontSize: 24.sp,
                                                        color: Colors.grey[300],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ));
                                            }).toList()),
                                  SizedBox(height: 10.h),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return Center(
                                                  child: SpinKitHourGlass(
                                                      color: white));
                                            },
                                          );

                                          // 关闭上面的弹窗
                                          Navigator.pop(context);
                                          return RouterHelper.router.navigateTo(
                                            context,
                                            "/word_detail?wordList=abandon,abortion,caption",
                                            transition: TransitionType.fadeIn,
                                            transitionDuration:
                                                Duration(milliseconds: 300),
                                          );
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
                                                fontFamily: 'SFProText',
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
                                          padding: const EdgeInsets.all(12.0),
                                          child: Icon(Icons.headset_mic_rounded,
                                              size: 44.sp, color: Colors.black),
                                        ),
                                        onTap: () {
                                          tapPlayAudioButton(
                                              wordlist[index].word);
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
                          tag: wordlist[index].word,
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
                          //右下角的数字
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              fontFamily: 'SFProText',
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
                                Text(
                                  wordlist[index].word,
                                  style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: 40.sp,
                                    color: const Color(0xff47455f),
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(height: 30.h),
                                // 详细
                                Container(
                                  width: double.infinity,
                                  height: 180.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: splitWrapStr(
                                        wordlist[index].translation,
                                        TextStyle(
                                          fontFamily: 'SFProText',
                                          fontSize: 30.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        TextAlign.left),
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
          );
    }
  }
}
