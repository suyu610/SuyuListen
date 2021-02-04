import 'package:flutter/material.dart';

/// 点击空白处，收起键盘

class FoldKeyboardGestureDetector extends StatelessWidget {
  const FoldKeyboardGestureDetector({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
