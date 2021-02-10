import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/controller/wordbook_controller.dart';
import 'package:SuyuListening/ui/pages/word_book/second_wordbook_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import '../../../entity/entities.dart';
import '../../../entity/search_model.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'first_wordbook_page.dart';

class WordBookPage extends StatefulWidget {
  WordBookPage({Key key}) : super(key: key);

  @override
  _WordBookPageState createState() => _WordBookPageState();
}

class _WordBookPageState extends State<WordBookPage> {
  WordBookController cFalse;
  WordBookController cTrue;
  @override
  void initState() {
    cFalse = Provider.of<WordBookController>(context, listen: false);
    cTrue = Provider.of<WordBookController>(context, listen: false);

    cFalse.initController();
    cFalse.scrollController.addListener(() {
      cFalse.scrollControllerListener();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          title: Text(
            "单词本",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: FutureBuilder(
                future: Provider.of<WordBookController>(context, listen: false)
                    .loadWordList(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return buildSearchBar();
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

  Widget buildSearchBar() {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            cFalse.floatingSearchBarController.open();
          },
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    return Consumer<SearchModel>(
      builder: (context, model, _) => FloatingSearchBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyBackButton: false,
        controller: cFalse.floatingSearchBarController,
        clearQueryOnClose: true,
        hint: '',
        iconColor: Colors.black,
        hintStyle: TextStyle(color: Colors.white),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        openAxisAlignment: 0.0,
        leadingActions: [
          OutlineButton.icon(
            onPressed: () {
              cFalse.toggleShowDefinition();
            },
            label: Row(children: [
              AnimatedOpacity(
                opacity: Provider.of<WordBookController>(context, listen: true)
                            .showDefinitionMode !=
                        DefinitinoEnum.ENG
                    ? 1.0
                    : 0.2,
                duration: Duration(milliseconds: 500),
                child: Text(
                  "中",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              AnimatedOpacity(
                opacity: Provider.of<WordBookController>(context, listen: true)
                            .showDefinitionMode !=
                        DefinitinoEnum.CH
                    ? 1.0
                    : 0.2,
                duration: Duration(milliseconds: 500),
                child: Text(
                  "英",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
            icon: Icon(
              Ionicons.swap_vertical_sharp,
              color: Colors.black,
              size: 34.sp,
            ),
            borderSide: BorderSide(width: 1, color: black.withOpacity(0.3)),
          ),
          OutlineButton.icon(
            onPressed: () {
              // cFalse.toggleShowDefinition();
            },
            // label: Text(""),
            label: Text(
                "共有${Provider.of<WordBookController>(context, listen: true).wordBookList.length}个"),
            icon: Icon(
              Ionicons.bar_chart_outline,
              color: Colors.black,
              size: 34.sp,
            ),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
        ],
        height: 100.h,
        maxWidth: 500,
        borderRadius: BorderRadius.zero,
        actions: actions,
        margins: EdgeInsets.only(right: 0, left: 0, top: 0.h, bottom: 0),
        padding:
            EdgeInsets.only(right: 10.w, left: 10.w, top: 10.h, bottom: 10.h),
        progress: model.isLoading,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: model.onQueryChanged,
        scrollPadding: EdgeInsets.all(20.w),
        transition: CircularFloatingSearchBarTransition(),
        builder: (context, _) => buildSearchBody(model),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: IndexedStack(
            index: Provider.of<WordBookController>(context, listen: true)
                .pageIndex,
            children: [
              // 第一页
              new FirstWordBookPage(),
              // 第二页
              SecondWordBookPage(),
            ],
          ),
        ),
        buildBottomNavigationBar(),
      ],
    );
  }

  Widget buildBottomNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BottomNavigationBar(
        onTap: (value) => cFalse.index = value,
        currentIndex:
            Provider.of<WordBookController>(context, listen: true).pageIndex,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: silver,
        selectedItemColor: blue,
        selectedFontSize: 11.5,
        unselectedFontSize: 11.5,
        unselectedItemColor: Colors.black.withOpacity(0.4),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '单词本',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.game_controller),
            label: '测试',
          ),
        ],
      ),
    );
  }

// 搜索框
  Widget buildSearchBody(SearchModel model) {
    return Material(
      color: Colors.white,
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8),
      child: ImplicitlyAnimatedList<SimpleWordEntity>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        items: model.suggestions.toList(),
        areItemsTheSame: (a, b) => a == b,
        itemBuilder: (context, animation, word, i) {
          return SizeFadeTransition(
            animation: animation,
            child: buildSearchItem(context, word),
          );
        },
        updateItemBuilder: (context, animation, place) {
          return FadeTransition(
            opacity: animation,
            child: buildSearchItem(context, place),
          );
        },
      ),
    );
  }

  // 搜索项
  Widget buildSearchItem(BuildContext context, SimpleWordEntity word) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final model = Provider.of<SearchModel>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            FloatingSearchBar.of(context).close();
            FocusScope.of(context).requestFocus(FocusNode());
            Future.delayed(
              const Duration(milliseconds: 500),
              () => model.clear(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: model.suggestions == history
                        ? const Icon(Icons.bolt, key: Key('history'))
                        : const Icon(Icons.golf_course, key: Key('place')),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word.word,
                        style: textTheme.subtitle1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        word.translation,
                        style: textTheme.bodyText2
                            .copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                model.suggestions != history
                    ? GestureDetector(
                        onTap: () {
                          if (word.word == "Not Found" &&
                              word.translation == "未搜索到") {
                          } else {
                            cTrue.addToWordBook(word);
                          }
                        },
                        child: Icon(Icons.add),
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: Icon(Ionicons.trash_outline),
                      ),
              ],
            ),
          ),
        ),
        if (model.suggestions.isNotEmpty && word != model.suggestions.last)
          const Divider(height: 0),
      ],
    );
  }
}
