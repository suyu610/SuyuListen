import 'package:SuyuListening/entity/entities.dart';
import 'package:flutter/material.dart';

import 'page_controller.dart';

class WordDetailController extends ChangeNotifier implements MyPageController {
  final List wordColumnList = ["释义", "英英释义", "词态变化", "词根词缀"];
  List<SimpleWordEntity> _wordMeaninglist;
  PageController _pageController;
  TabController _tabController;
  ScrollController _scrollController;
  PageController _tabPageViewController;

  get wordMeaninglist {
    if (_wordMeaninglist == null) {
      _wordMeaninglist = [];
      _wordMeaninglist.clear();
    }
    return _wordMeaninglist;
  }


  get pageController {
    if (_pageController == null) {
      _pageController = new PageController();
    }
    return _pageController;
  }

  get tabController => _tabController == null
      ? _tabController = new TabController(
          length: wordColumnList.length,
          vsync: ScrollableState(),
        )
      : _tabController;

  get tabPageViewController => _tabPageViewController == null
      ? _tabPageViewController = new PageController()
      : _tabPageViewController;

  get scrollController => _scrollController == null
      ? _scrollController = new ScrollController()
      : _scrollController;

  int currentTabbarIndex = 0;

  onPageChanged(index) {
    print(index);
    _tabController.animateTo(0);
    currentTabbarIndex = 0;
    notifyListeners();
  }

  onTapTabbar(index) {
    _tabPageViewController.animateToPage(index,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
    currentTabbarIndex = index;
    notifyListeners();
  }

  onTabPageViewChange(index) {
    _tabController.animateTo(index);
    currentTabbarIndex = index;
    notifyListeners();
  }

  @override
  Future initController() async {
    return this;
  }

  @override
  Future disposeController() async {}
}
