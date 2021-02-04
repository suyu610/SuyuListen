//  flutter系统库
import 'package:flutter/material.dart';
// 第三方库
import 'package:flip_card/flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
// 自己的
import 'article.dart';
import '../../../model/entities.dart';
import '../../../net/translation_api.dart';
import '../../components/divider_with_text.dart';

class FirstPageWidget extends StatefulWidget {
  const FirstPageWidget({
    this.list,
    Key key,
  }) : super(key: key);
  final List<ArticleEntity> list;
  @override
  _FirstPageWidgetState createState() => _FirstPageWidgetState();
}

class _FirstPageWidgetState extends State<FirstPageWidget> {
  int currentMonth = new DateTime.now().month;
  bool isMeMode = true;
  List<SimpleWordEntity> searchWordList;
  bool isSearchBarFocus = false;
  FloatingSearchBarController floatingSearchBarController;

  @override
  void initState() {
    searchWordList = List<SimpleWordEntity>();
    floatingSearchBarController = FloatingSearchBarController();
    super.initState();
  }

  @override
  void deactivate() async {
    super.deactivate();
  }

  void searchBarFocusChange(bool focus) {
    isSearchBarFocus = focus;
    setState(() {});
  }

  void handleCalendarChanged(int date) {
    currentMonth = date;
    setState(() {});
  }

  searchUpdate(String prefix) async {
    prefix = prefix.trim();
    if (prefix != "") {
      searchWordList = await getSimpleWordListByPrefix(prefix, 20);
    } else {
      searchWordList = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: 1334.h,
      child: Stack(
        children: [
          Column(
            children: [
              // 学习进度的日历
              studyRecordCalendar(
                  context, handleCalendarChanged, isMeMode, currentMonth),
              DividerWithText("今日文章"),

              // 今日文章的主体
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10),
                child: Container(
                  height: 300.h,
                  width: double.infinity,
                  child: FlipCard(
                      direction: FlipDirection.VERTICAL,
                      speed: 300,
                      front:
                          TodayArticleFrontWidget(model: new ArticleEntity()),
                      back: TodayArticleBackWidget()),
                ),
              ),
            ],
          ),

          // 右下角图示
          studyRecordLegend(context),
          // 搜索
          buildFloatingSearchBar(
              floatingSearchBarController,
              isSearchBarFocus,
              searchBarFocusChange,
              searchUpdate,
              searchWordList),
        ],
      ),
    );
  }
}
