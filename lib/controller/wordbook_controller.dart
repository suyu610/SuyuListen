import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/entity/entities.dart';
import 'package:SuyuListening/ui/components/dialog/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'page_controller.dart';

enum DefinitinoEnum { ENG, CH, BOTH }

class WordBookController extends ChangeNotifier implements MyPageController {
  WordBookController() {
    initController();
  }

  TextEditingController _textEditingController;
  DefinitinoEnum _showDefinitionMode = DefinitinoEnum.BOTH;

  DefinitinoEnum get showDefinitionMode => _showDefinitionMode;

  List<SimpleWordEntity> wordList;
  FloatingSearchBarController floatingSearchBarController;

  int _index = 0;
  int get index => _index;

  void onTapListTile(int index, BuildContext context) {
    switch (_showDefinitionMode) {
      // 如果是英语模式 ，则出现他的中文意思
      case DefinitinoEnum.ENG:
        EasyLoading.showToast("抛弃放弃");
        break;
      // 如果是中文模式， 则出来一个对话框，让用户写单词
      case DefinitinoEnum.CH:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                  backgroundColor: silver,
                  contentWidget: Container(
                      width: 200,
                      child: TextField(
                        controller: _textEditingController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Color(0x99000000)),
                          hintText: '输入单词',
                          hintMaxLines: 2,
                          enabledBorder: new UnderlineInputBorder(
                            // 不是焦点的时候颜色
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: new UnderlineInputBorder(
                            // 焦点集中的时候颜色
                            borderSide: BorderSide(color: yellow, width: 2),
                          ),
                        ),
                        maxLines: 1,
                      )),
                  title: "抛弃；放弃；遗弃",
                  text: "检查",
                  onTapButton: () {
                    // 检查是否正确
                    if (_textEditingController.text == "abandon") {
                      Navigator.pop(context);
                      EasyLoading.showSuccess("真棒!\n拼写正确");
                      _textEditingController.text = "";
                    } else {
                      EasyLoading.showError("拼写错误");
                    }
                  });
            });
        break;
      // 如果是both模式，则跳转到单词详情页
      default:
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
    _index = value;
    notifyListeners();
  }

  @override
  Future disposeController() async{
    floatingSearchBarController.dispose();
  }

  @override
  Future initController() async {
    _textEditingController = TextEditingController();
    floatingSearchBarController = new FloatingSearchBarController();
  }
}
