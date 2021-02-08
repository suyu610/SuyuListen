import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/controller/wordbook_controller.dart';
import 'package:SuyuListening/ui/components/dialog/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckDefinitionDialogWidget extends StatefulWidget {
  CheckDefinitionDialogWidget({Key key}) : super(key: key);

  @override
  _CheckDefinitionDialogWidgetState createState() =>
      _CheckDefinitionDialogWidgetState();
}

class _CheckDefinitionDialogWidgetState
    extends State<CheckDefinitionDialogWidget> {
  WordBookController wordBookController;

  @override
  void initState() {
    wordBookController =
        Provider.of<WordBookController>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(
        backgroundColor: silver,
        contentWidget: Container(
            width: 200,
            child: TextField(
              controller: wordBookController.textEditingController,
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Color(0x99000000)),
                hintText: '输入单词',
                hintMaxLines: 2,
                enabledBorder: new UnderlineInputBorder(
                  // 不是焦点的时候颜色
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: new UnderlineInputBorder(
                  // 焦点集中的时候颜色
                  borderSide: BorderSide(color: yellow, width: 2),
                ),
              ),
              maxLines: 1,
            )),
        title: wordBookController.currentWordEntity.definition,
        text: "检查",
        onTapButton: () {
          wordBookController.checkDefinition(context);
        });
  }
}
