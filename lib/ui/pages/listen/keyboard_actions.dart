import 'package:SuyuListening/ui/components/keyboard_actions.dart/keyboard_actions.dart';

import 'keyboard_footer_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ionicons/ionicons.dart';

List<KeyboardActionsItem> keyboardActionsItem(FocusNode keyboardNode) {
  return [
    KeyboardActionsItem(
      focusNode: keyboardNode,
      footerBuilder: (context) => keyBoardFooterWidget(context),
      toolbarButtons: keyboardActions,
    ),
  ];
}

List<ButtonBuilder> keyboardActions = [
  //button 1
  (node) {
    return GestureDetector(
      onTap: () => node.unfocus(),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(right: 8.0, left: 8),
        child: Icon(Icons.play_arrow),
      ),
    );
  },
  (node) {
    return GestureDetector(
      onTap: () => node.unfocus(),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(right: 8.0, left: 8),
        child: Icon(Ionicons.arrow_back),
      ),
    );
  },
  (node) {
    return GestureDetector(
      onTap: () => {
        EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.wave,
        EasyLoading.show(status: "正在录音", dismissOnTap: true)
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(right: 8.0, left: 8),
        child: Icon(Icons.arrow_forward),
      ),
    );
  },
  //button 2
  (node) {
    return GestureDetector(
      onLongPress: () => {
        EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.wave,
        EasyLoading.show(status: "正在录音", dismissOnTap: true)
      },
      onLongPressEnd: (detail) => {
        print(detail),
        EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.pulse,
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
        padding: EdgeInsets.only(right: 8.0, left: 8),
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
];
