import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

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
  AudioPlayer player;

  ScrollController _scrollController;
  FloatingSearchBarController _floatingSearchBarController;
  TextEditingController textEditingController;
  DefinitinoEnum _showDefinitionMode = DefinitinoEnum.BOTH;
  DefinitinoEnum get showDefinitionMode => _showDefinitionMode;
  List<UserWordEntity> _wordBookList;
  UserWordEntity currentWordEntity;
  int _pageIndex = 0;
  DateTime _lastTime; //上次滑动的时间
  int get pageIndex => _pageIndex;
  int _currentWordIndexOnTap = -1;

  Future<bool> loadWordList() async {
    // 模拟从数据库中拿数据
    await Future.delayed(Duration(seconds: 1));
    if (_wordBookList == null) {
      _wordBookList = [
        UserWordEntity(word: "hfss", definition: "皇甫素素", tempIsCompelete: true),
        UserWordEntity(word: "abandon", definition: "抛弃;抛弃 "),
        UserWordEntity(
            word: "abc", definition: "字母表（尤指儿童学习的全部字母）;（某学科的）基础知识，入门"),
        UserWordEntity(word: "hello", definition: "你好"),
        UserWordEntity(word: "sun", definition: "太阳"),
        UserWordEntity(word: "moon", definition: "月亮"),
        UserWordEntity(word: "lol", definition: "英雄联盟"),
        UserWordEntity(word: "girl", definition: "女孩"),
        UserWordEntity(word: "play", definition: "玩")
      ];
    }
    return true;
  }

  void addToWordBook(SimpleWordEntity word) {
    
    UserWordEntity userWordEntity = UserWordEntity(
        word: word.word ?? "null", definition: word.translation ?? "");
    _wordBookList.insert(0, userWordEntity);
    EasyLoading.showSuccess("添加成功");
    _floatingSearchBarController.close();
    notifyListeners();
  }

  get wordBookList {
    if (_wordBookList == null) {
      loadWordList();
      return _wordBookList;
    } else {
      return _wordBookList;
    }
  }

  get scrollController {
    if (_scrollController == null) {
      _scrollController = new ScrollController();
      return _scrollController;
    } else {
      return _scrollController;
    }
  }

  get floatingSearchBarController {
    if (_floatingSearchBarController == null) {
      _floatingSearchBarController = new FloatingSearchBarController();
      return _floatingSearchBarController;
    } else {
      return _floatingSearchBarController;
    }
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

  void onDeleteWord(BuildContext context, int index) {
    _wordBookList.removeAt(index);
    Navigator.pop(context);
    EasyLoading.showSuccess("删除成功");
    notifyListeners();
  }

  // 检查是否正确
  void checkDefinition(context) {
    if (textEditingController.text ==
        _wordBookList[_currentWordIndexOnTap].word) {
      Navigator.pop(context);
      EasyLoading.showSuccess("真棒!\n拼写正确");
      _wordBookList[_currentWordIndexOnTap].tempIsCompelete = true;
      textEditingController.text = "";
      notifyListeners();
    } else {
      EasyLoading.showError("拼写错误");
    }
  }

  void onTapListTile(int index, BuildContext context) {
    _currentWordIndexOnTap = index;
    currentWordEntity = _wordBookList[index];
    switch (_showDefinitionMode) {
      // 如果是英语模式 ，则出现他的中文意思
      case DefinitinoEnum.ENG:
        EasyLoading.showToast(_wordBookList[index].definition);
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

    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //全局设置透明
        statusBarIconBrightness: Brightness.light);

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    notifyListeners();
  }

  // 播放音频
  void tapPlayAudioButton(String word) async {
    await player.setAudioSource(AudioSource.uri(
        Uri.parse("https://dict.youdao.com/dictvoice?audio=$word&type=2)")));
    player.play();
  }

  @override
  Future disposeController() async {
    floatingSearchBarController.dispose();
  }

  @override
  Future<WordBookController> initController() async {
    // 加载用户单词
    player = AudioPlayer();
    textEditingController = TextEditingController();
    return this;
  }
}
