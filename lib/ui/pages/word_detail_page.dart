import '../../constant/theme_color.dart';
import '../../sample_data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordDetailPage extends StatefulWidget {
  final PlanetInfo planetInfo;

  WordDetailPage({Key key, this.planetInfo}) : super(key: key);

  @override
  _WordDetailPageState createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  PageController _pageController;
  TabController _tabController;
  ScrollController _scrollController;
  PageController _tabPageViewController;
  List wordColumnList = ["释义", "词态变化", "英英释义", "例句", "词根词缀"];
  int currentTabbarIndex = 0;
  @override
  void initState() {
    _scrollController = ScrollController();
    _pageController = PageController();
    _tabPageViewController = PageController();
    _tabController = TabController(
      length: wordColumnList.length,
      vsync: ScrollableState(),
    );
    super.initState();
  }

  onTapTabbar(index) {
    _tabPageViewController.animateToPage(index,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
    currentTabbarIndex = index;
    setState(() {});
    print(index);
  }

  onTabPageViewChange(index) {
    _tabController.animateTo(index);
    currentTabbarIndex = index;
    setState(() {});
    print(index);
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
        child: PageView.builder(
            itemCount: planets.length,
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                controller: _scrollController,
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
                                icon: Icon(Icons.arrow_back_ios,
                                    color: Colors.black),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Text(
                                "还需要学习10，复习10",
                                style: TextStyle(color: Color(0xffd2d3d5)),
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.close, color: Color(0xffd2d3d5)),
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
                                  tag: planets[index].name,
                                  child: Text(
                                    planets[index].name,
                                    style: TextStyle(
                                      fontFamily: 'Avenir',
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
                                      color: Color(0xfffeeffd)),
                                  child: Row(
                                    children: [
                                      Icon(
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
                                  "英 / ˈjʊərənəs /",
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
                                  "美 / ˈjʊrənəs /",
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
                      tabs: wordColumnList.map((f) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              f,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: f == wordColumnList[currentTabbarIndex]
                                      ? blue
                                      : Color(0xffbcb8c0)),
                            ),
                          ),
                        );
                      }).toList(),
                      onTap: onTapTabbar,
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      indicatorWeight: 0.6,
                      indicatorColor: blue,
                    ),
                    Container(
                      width: double.infinity,
                      height: 600.h,
                      child: PageView.builder(
                          itemCount: wordColumnList.length,
                          controller: _tabPageViewController,
                          physics: BouncingScrollPhysics(),
                          onPageChanged: onTabPageViewChange,
                          itemBuilder: (context, index) {
                            return Padding(
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
                                    wordColumnList[index],
                                    style: TextStyle(
                                        color: primaryTextColor,
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  )),
                            );
                          }),
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
                              style:
                                  TextStyle(color: Colors.grey.withAlpha(200)),
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
                              style:
                                  TextStyle(color: Colors.grey.withAlpha(200)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
