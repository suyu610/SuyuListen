import 'package:SuyuListening/ui/components/keyboard_actions.dart/keyboard_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../constant/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  //默认初始值为0.0

  @override
  void initState() {
    super.initState();
  }

  final FocusNode _nodeText5 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: colorWhite,
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText5,
          toolbarButtons: [
            //button 1
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.play_arrow),
                ),
              );
            },
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Ionicons.arrow_back),
                ),
              );
            },
            (node) {
              return GestureDetector(
                onTap: () => {
                  EasyLoading.instance.indicatorType =
                      EasyLoadingIndicatorType.wave,
                  EasyLoading.show(status: "正在录音", dismissOnTap: true)
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward),
                ),
              );
            },
            //button 2
            (node) {
              return GestureDetector(
                onLongPress: () => {
                  EasyLoading.instance.indicatorType =
                      EasyLoadingIndicatorType.wave,
                  EasyLoading.show(status: "正在录音", dismissOnTap: true)
                },
                onLongPressEnd: (detail) => {
                  print(detail),
                  EasyLoading.instance.indicatorType =
                      EasyLoadingIndicatorType.pulse,
                  EasyLoading.show(status: "识别中", dismissOnTap: true),
                  Future.delayed(
                      Duration(seconds: 2),
                      () => {
                            EasyLoading.showSuccess("识别的文字为\n\n皇甫素素是笨蛋",
                                duration: Duration(seconds: 3)),
                          })
                },
                onTap: () => EasyLoading.showInfo("请长按"),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.mic),
                ),
              );
            },
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.clear,
                  ),
                ),
              );
            }
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              focusNode: _nodeText5,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Input Text without Done button",
              ),
            ),
            // CupertinoSegmentedControl<EasyLoadingIndicatorType>(
            //     onValueChanged: (value) {
            //       EasyLoading.instance.indicatorType = value;
            //     },
            //     selectedColor: Colors.blue,
            //     children: {
            //     }),
          ],
        ),
      ),
    );
  }
}
