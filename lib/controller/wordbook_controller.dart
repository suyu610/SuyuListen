import 'package:SuyuListening/ui/pages/word_book/first_wordbook_page.dart';
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
    return [
      UserWordEntity(word: "0", definition: "皇甫素素", tempIsCompelete: true),
      UserWordEntity(word: "1", definition: "抛弃抛弃抛弃抛弃抛弃"),
      UserWordEntity(word: "2", definition: "英语顺序英语顺序英语顺序英语顺序英语顺序"),
      UserWordEntity(word: "3", definition: "你好"),
      UserWordEntity(word: "4", definition: "抛弃"),
      UserWordEntity(word: "5", definition: "英语顺序"),
      UserWordEntity(word: "6", definition: "你好"),
      UserWordEntity(word: "7", definition: "抛弃"),
      UserWordEntity(word: "8", definition: "英语顺序")
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

  void onDeleteWord(BuildContext context, int index) {
    print(index);
    wordBookList.removeAt(index);
    Navigator.pop(context);
    EasyLoading.showSuccess("删除成功");
    print("========================");
    wordBookList.forEach((element) {
      print(element.word);
    });
    print("========================");
    notifyListeners();
    setState();
    wordBookList.forEach((element) {
      print(element.word);
    });
    print("========================");
  }

  // 检查是否正确
  void checkDefinition(context) {
    if (textEditingController.text ==
        wordBookList[_currentWordIndexOnTap].word) {
      Navigator.pop(context);
      EasyLoading.showSuccess("真棒!\n拼写正确");
      wordBookList[_currentWordIndexOnTap].tempIsCompelete = true;
      textEditingController.text = "";
      setState();
    } else {
      EasyLoading.showError("拼写错误");
    }
  }

  void setState() {
    // ignore: invalid_use_of_protected_member
    booklistKey.currentState.setState(() {});
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
  Future<bool> initController() async {
    player = AudioPlayer();

    booklistKey = GlobalKey<FirstWordBookPageState>();
    textEditingController = TextEditingController();
    textEditingController.addListener(() {});
    scrollController = new ScrollController();
    floatingSearchBarController = new FloatingSearchBarController();

    scrollController.addListener(() {
      scrollControllerListener();
    });

    // 加载用户单词
    wordBookList = await loadWordLisk();

    return true;
  }
}
