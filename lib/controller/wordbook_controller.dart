import 'package:SuyuListening/ui/pages/word_book/first_wordbook_page.dart';

import '../entity/entities.dart';
import '../route/router_helper.dart';
import '../ui/pages/word_book/check_deifinition_dialog.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'page_controller.dart';

enum DefinitinoEnum { ENG, CH, BOTH }

class WordBookController extends ChangeNotifier implements MyPageController {
  WordBookController() {
    initController();
  }
  GlobalKey<FirstWordBookPageState> booklistKey;
  ScrollController scrollController;
  FloatingSearchBarController floatingSearchBarController;
  TextEditingController textEditingController;
  DefinitinoEnum _showDefinitionMode = DefinitinoEnum.BOTH;
  DefinitinoEnum get showDefinitionMode => _showDefinitionMode;
  List<UserWordEntity> wordBookList;
  UserWordEntity currentWordEntity;
  int _pageIndex = 0;
  DateTime _lastTime; //上次滑动的时间
  int get pageIndex => _pageIndex;
  int _currentWordIndexOnTap = -1;

  Future<List<UserWordEntity>> loadWordLisk() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      UserWordEntity(word: "hello", definition: "你好你好你好你好你好你好你好你好"),
      UserWordEntity(word: "abandon", definition: "抛弃抛弃抛弃抛弃抛弃"),
      UserWordEntity(word: "abc", definition: "英语顺序英语顺序英语顺序英语顺序英语顺序"),
      UserWordEntity(word: "hello", definition: "你好"),
      UserWordEntity(word: "abandon", definition: "抛弃"),
      UserWordEntity(word: "abc", definition: "英语顺序"),
      UserWordEntity(word: "hello", definition: "你好"),
      UserWordEntity(word: "abandon", definition: "抛弃"),
      UserWordEntity(word: "abc", definition: "英语顺序")
    ];
  }

  // 在时间内，应该只让他监听一次
  scrollControllerListener() {
    if ((scrollController.position.pixels < -40) &&
        (_lastTime == null ||
            DateTime.now().difference(_lastTime) > Duration(seconds: 1))) {
      _lastTime = DateTime.now();
      if (!floatingSearchBarController.isOpen) {
        floatingSearchBarController.open();
      }
    }
  }

  //当滚动时，收起搜索框
  onUpdateScroll(ScrollMetrics metrics) {
    if (scrollController.position.pixels > 0) {
      if (floatingSearchBarController.isOpen) {
        floatingSearchBarController.close();
      }
    }
  }

  // 检查是否正确
  void checkDefinition(context) {
    if (textEditingController.text ==
        wordBookList[_currentWordIndexOnTap].word) {
      Navigator.pop(context);
      EasyLoading.showSuccess("真棒!\n拼写正确");
      textEditingController.text = "";
      // ignore: invalid_use_of_protected_member
      booklistKey.currentState.setState(() {
        wordBookList[_currentWordIndexOnTap].tempIsCompelete = true;
      });
    } else {
      EasyLoading.showError("拼写错误");
    }
  }

  void onTapListTile(int index, BuildContext context) {
    _currentWordIndexOnTap = index;
    currentWordEntity = wordBookList[index];
    switch (_showDefinitionMode) {
      // 如果是英语模式 ，则出现他的中文意思
      case DefinitinoEnum.ENG:
        EasyLoading.showToast(wordBookList[index].definition);
        break;
      // 如果是中文模式， 则出来一个对话框，让用户写单词
      case DefinitinoEnum.CH:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CheckDefinitionDialogWidget();
            });
        break;
      // 如果是both模式，则跳转到单词详情页
      default:
        RouterHelper.router.navigateTo(context, '/word_detail',
            transition: TransitionType.inFromRight,
            transitionDuration: Duration(milliseconds: 300));
    }
  }

  toggleShowDefinition() {
    // 都显示 -> 只显示中文 -> 只显示英语
    switch (_showDefinitionMode) {
      case DefinitinoEnum.BOTH:
        _showDefinitionMode = DefinitinoEnum.ENG;
        break;
      case DefinitinoEnum.ENG:
        _showDefinitionMode = DefinitinoEnum.CH;
        break;
      default:
        _showDefinitionMode = DefinitinoEnum.BOTH;
    }
    notifyListeners();
  }

  set index(int value) {
    0 == value
        ? floatingSearchBarController.show()
        : floatingSearchBarController.hide();
    _pageIndex = value;
    notifyListeners();
  }

  @override
  Future disposeController() async {
    floatingSearchBarController.dispose();
  }

  @override
  Future initController() async {
    booklistKey = GlobalKey<FirstWordBookPageState>();
    textEditingController = TextEditingController();

    scrollController = new ScrollController();

    scrollController.addListener(() {
      scrollControllerListener();
    });

    // 加载用户单词
    wordBookList = await loadWordLisk();

    floatingSearchBarController = new FloatingSearchBarController();
  }
}
