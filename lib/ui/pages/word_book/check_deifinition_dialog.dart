import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/controller/wordbook_controller.dart';
import 'package:SuyuListening/ui/components/dialog/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckDefinitionDialogWidget extends StatefulWidget {
  CheckDefinitionDialogWidget({Key key}) : super(key: key);

  @override
  _CheckDefinitionDialogWidgetState createState() =>
      _CheckDefinitionDialogWidgetState();
}

class _CheckDefinitionDialogWidgetState
    extends State<CheckDefinitionDialogWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(
        backgroundColor: silver,
        contentWidget: Container(
            width: 400.w,
            child: TextField(
              controller:
                  Provider.of<WordBookController>(context, listen: false)
                      .textEditingController,
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Ionicons.color_wand_outline,
                    size: 28.sp,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Provider.of<WordBookController>(context, listen: false)
                        .helpWhenEditing();
                  },
                ),
                labelStyle: TextStyle(color: Color(0x99000000)),
                hintText: '输入单词',
                hintMaxLines: 2,
                enabledBorder: new UnderlineInputBorder(
                  // 不是焦点的时候颜色
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: new UnderlineInputBorder(
                  // 焦点集中的时候颜色
                  borderSide: BorderSide(color: blue, width: 2),
                ),
              ),
              maxLines: 1,
            )),
        title: Provider.of<WordBookController>(context, listen: true)
            .currentWordEntity
            .definition,
        text: "检查",
        onTapButton: () {
          Provider.of<WordBookController>(context, listen: false)
              .checkDefinition(context);
        });
  }
}
