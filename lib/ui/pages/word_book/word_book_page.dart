import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/controller/wordbook_controller.dart';
import 'package:SuyuListening/ui/pages/word_book/second_wordbook_page.dart';
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
  WordBookController wordBookController;

  @override
  void initState() {
    wordBookController =
        Provider.of<WordBookController>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    wordBookController.disposeController();
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
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: buildSearchBar()),
    );
  }

  Widget buildSearchBar() {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            wordBookController.floatingSearchBarController.open();
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
        controller: Provider.of<WordBookController>(context, listen: false)
            .floatingSearchBarController,
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
              Provider.of<WordBookController>(context, listen: false)
                  .toggleShowDefinition();
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
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          )
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
        builder: (context, _) => buildExpandableBody(model),
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
            index: Provider.of<WordBookController>(context, listen: true).index,
            children: [
              // 第一页
              new FirstWordBookPage(
                  wordBookController.floatingSearchBarController),
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
        onTap: (value) => wordBookController.index = value,
        currentIndex:
            Provider.of<WordBookController>(context, listen: true).index,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: silver,
        selectedItemColor: Colors.black,
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

  Widget buildExpandableBody(SearchModel model) {
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
            child: buildItem(context, word),
          );
        },
        updateItemBuilder: (context, animation, place) {
          return FadeTransition(
            opacity: animation,
            child: buildItem(context, place),
          );
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, SimpleWordEntity word) {
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
