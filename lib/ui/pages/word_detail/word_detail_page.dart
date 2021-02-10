import 'package:SuyuListening/controller/word_detail_controller.dart';
import 'package:SuyuListening/entity/entities.dart';
import 'package:SuyuListening/net/translation_api.dart';
import 'package:SuyuListening/utils/format_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../constant/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 三种模式
/// 一种为查看单个单词
/// 另一种为查看一个列表的单词
/// 另一种为查看用户的单词本
class WordDetailPage extends StatefulWidget {
  final List<String> wordList;
  WordDetailPage({Key key, this.wordList}) : super(key: key);

  @override
  _WordDetailPageState createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  WordDetailController cFalse;
  WordDetailController cTrue;

  @override
  void initState() {
    cFalse = Provider.of<WordDetailController>(context, listen: false);
    cTrue = Provider.of<WordDetailController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: silver,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: FutureBuilder(
                future: getSimpleWordList(widget.wordList),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SimpleWordEntity>> snapshot) {
                  if (snapshot.hasData) {
                    List<SimpleWordEntity> wordList = snapshot.data;
                    return pageView(wordList);
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitFadingCircle(
                          color: Colors.black,
                          size: 30.0,
                        ),
                        Text("加载中"),
                      ],
                    );
                  }
                })));
  }

  Widget pageView(wordList) => PageView.builder(
      onPageChanged: cFalse.onPageChanged,
      itemCount: wordList.length,
      controller: cFalse.pageController,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          controller: cFalse.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //顶部
              Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          "当前第${index + 1}个,共有${wordList.length}个",
                          style: TextStyle(color: Color(0xffd2d3d5)),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Color(0xffd2d3d5)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )),
              // 第二栏
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Hero(
                            tag: wordList[index].word,
                            child: Text(
                              wordList[index].word,
                              style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: 70.sp,
                                color: primaryTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                right: 8, left: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xfffeeffd)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: blue,
                                ),
                                Text(
                                  "单词本",
                                  style: TextStyle(fontSize: 28.sp),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "英 / ${wordList[index].phonetic} /",
                            style: TextStyle(color: Color(0xffbcc0bd)),
                          ),
                          Icon(
                            Icons.volume_down,
                            color: blue,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "美 /  /",
                            style: TextStyle(color: Color(0xffbcc0bd)),
                          ),
                          Icon(
                            Icons.volume_down,
                            color: blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // 第三栏
              TabBar(
                tabs: cTrue.wordColumnList.map((f) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        f,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: f == wordList[cTrue.currentTabbarIndex]
                                ? blue
                                : Color(0xffbcb8c0)),
                      ),
                    ),
                  );
                }).toList(),
                onTap: cFalse.onTapTabbar,
                controller: cFalse.tabController,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                indicatorWeight: 1,
                indicatorColor: blue,
              ),
              Container(
                width: double.infinity,
                height: 600.h,
                child: PageView(
                  controller: cFalse.tabPageViewController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: cFalse.onTabPageViewChange,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                          padding: const EdgeInsets.all(18.0),
                          height: 600.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                  Text(
                                    cFalse.wordColumnList[0],
                                    style: TextStyle(
                                        color: primaryTextColor,
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: 10.h),
                                ] +
                                splitWrapStr(wordList[index].translation,
                                    TextStyle(fontSize: 28.sp)),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                          padding: const EdgeInsets.all(18.0),
                          height: 600.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Text(
                            cFalse.wordColumnList[1],
                            style: TextStyle(
                                color: primaryTextColor,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                          padding: const EdgeInsets.all(18.0),
                          height: 600.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Text(
                            cFalse.wordColumnList[2],
                            style: TextStyle(
                                color: primaryTextColor,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                          padding: const EdgeInsets.all(18.0),
                          height: 600.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Text(
                            cFalse.wordColumnList[3],
                            style: TextStyle(
                                color: primaryTextColor,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )),
                    ),
                  ],
                ),
              ),
              // 第三栏
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  // height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "例句",
                        style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "1.If you abandon a place, thing, or person, you leave the place, thing, or person permanently or for a long time, especially when you should not do so.",
                        style: TextStyle(fontSize: 28.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "如果你抛弃了一个地方、一件事或一个人，你就会永久或长久地离开这个地方、一件事或一个人，尤其是当你不应该这样做的时候。",
                        style: TextStyle(color: Colors.grey.withAlpha(200)),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "2. Logic had prevailed and he had abandoned the idea.",
                        style: TextStyle(fontSize: 28.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "最终理智占了上风，他打消了那个念头。",
                        style: TextStyle(color: Colors.grey.withAlpha(200)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
