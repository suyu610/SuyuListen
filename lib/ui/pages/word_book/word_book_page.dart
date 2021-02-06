import 'dart:math';

import 'package:SuyuListening/constant/theme_color.dart';
import '../../../entity/entities.dart';
import '../../../entity/search_model.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class WordBookPage extends StatefulWidget {
  WordBookPage({Key key}) : super(key: key);

  @override
  _WordBookPageState createState() => _WordBookPageState();
}

class _WordBookPageState extends State<WordBookPage> {
  List<SimpleWordEntity> wordList;
  final controller = FloatingSearchBarController();

  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = min(value, 2);
    _index == 0 ? controller.show() : controller.hide();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildSearchBar(),
    );
  }

  Widget buildSearchBar() {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Consumer<SearchModel>(
      builder: (context, model, _) => FloatingSearchBar(
        automaticallyImplyBackButton: false,
        controller: controller,
        clearQueryOnClose: true,
        hint: '搜索单词...',
        iconColor: Colors.grey,
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        maxWidth: isPortrait ? 600 : 500,
        actions: actions,
        progress: model.isLoading,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: model.onQueryChanged,
        scrollPadding: EdgeInsets.only(top: 10.w),
        transition: CircularFloatingSearchBarTransition(),
        builder: (context, _) => buildExpandableBody(model),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: IndexedStack(
            index: min(index, 2),
            children: const [
              // 第一页
              FirstWordBookPage(),

              // 第二页
              SecondWordBookPage(), // 第三页
              Text("他的单词"),
            ],
          ),
        ),
        buildBottomNavigationBar(),
      ],
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

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) => index = value,
      currentIndex: index,
      elevation: 16,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      selectedFontSize: 11.5,
      unselectedFontSize: 11.5,
      unselectedItemColor: const Color(0xFF4d4d4d),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          label: '单词本',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          label: '测试',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          label: '他的',
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class SecondWordBookPage extends StatelessWidget {
  const SecondWordBookPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: silver,
        ),
        buildBackground(),
      ],
    );
  }

  Widget buildBackground() {
    return Image.asset(
      'assets/earth.png',
      fit: BoxFit.contain,
    );
  }
}

class FirstWordBookPage extends StatelessWidget {
  const FirstWordBookPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingSearchAppBar(
      title: const Text('单词本'),
      elevation: 0,
      liftOnScrollElevation: 0,
      transitionDuration: const Duration(milliseconds: 800),
      colorOnScroll: yellow,
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: 100,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}
