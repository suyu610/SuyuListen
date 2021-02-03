import '../../../constant/theme_color.dart';
import '../../components/dialog/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:waveprogressbar_flutter/waveprogressbar_flutter.dart';

import 'foo.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  //默认初始值为0.0

  double waterHeight = 0.6;
  WaterController waterController = WaterController();
  @override
  void initState() {
    WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) {
      //这里写你想要显示的百分比
      waterController.changeWaterHeight(0.82);
    });

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
                onTap: () => node.unfocus(),
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
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        onTapButton: () {
                          Navigator.pop(context);
                        },
                        headWidget: Image(
                          image: AssetImage("assets/icons/record.png"),
                        ),
                        title: "正在录音..",
                        text: "结束",
                        contentWidget: WaveProgressBar(
                          flowSpeed: 1.0,
                          waveDistance: 45.0,
                          waterColor: blue,
                          strokeCircleColor: Colors.transparent,
                          heightController: waterController,
                          percentage: waterHeight,
                          size: new Size(100, 100),
                          textStyle: new TextStyle(
                              color: Colors.transparent,
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
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

  _openWidget(BuildContext context, Widget widget) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => widget),
      );

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
            RaisedButton(
              onPressed: () => {_openWidget(context, Content())},
            ),
          ],
        ),
      ),
    );
  }
}
