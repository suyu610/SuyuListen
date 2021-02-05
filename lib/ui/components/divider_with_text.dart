import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText(this.title, {Key key, this.textStyle})
      : super(key: key);
  final String title;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10, bottom: 10),
        child: Row(children: <Widget>[
          Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10),
            child: Text(
              title,
              style:
                  textStyle ?? Theme.of(context).brightness == Brightness.dark
                      ? TextStyle(color: Colors.white.withAlpha(60))
                      : TextStyle(color: Colors.black.withAlpha(60)),
            ),
          ),
          Expanded(child: Divider()),
        ]));
  }
}
