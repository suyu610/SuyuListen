import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class Content extends StatelessWidget {
  final FocusNode _nodeText7 = FocusNode();
  final FocusNode _nodeText8 = FocusNode();
  //This is only for custom keyboards
  final custom1Notifier = ValueNotifier<String>("0");
  final custom2Notifier = ValueNotifier<Color>(Colors.blue);

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText7,
          footerBuilder: (_) => CounterKeyboard(
            notifier: custom1Notifier,
          ),
        ),
        KeyboardActionsItem(
          focusNode: _nodeText8,
          footerBuilder: (_) => ColorPickerKeyboard(
            notifier: custom2Notifier,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              KeyboardCustomInput<String>(
                focusNode: _nodeText7,
                height: 65,
                notifier: custom1Notifier,
                builder: (context, val, hasFocus) {
                  return Container(
                    alignment: Alignment.center,
                    color: hasFocus ? Colors.grey[300] : Colors.white,
                    child: Text(
                      val,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              KeyboardCustomInput<Color>(
                focusNode: _nodeText8,
                height: 65,
                notifier: custom2Notifier,
                builder: (context, val, hasFocus) {
                  return Container(
                    width: double.maxFinite,
                    color: val ?? Colors.transparent,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A quick example "keyboard" widget for picking a color.
class ColorPickerKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<Color>
    implements PreferredSizeWidget {
  final ValueNotifier<Color> notifier;
  static const double _kKeyboardHeight = 200;

  ColorPickerKeyboard({Key key, this.notifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double rows = 3;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int colorsCount = Colors.primaries.length;
    final int colorsPerRow = (colorsCount / rows).ceil();
    final double itemWidth = screenWidth / colorsPerRow;
    final double itemHeight = _kKeyboardHeight / rows;

    return Container(
      height: _kKeyboardHeight,
      child: Wrap(
        children: <Widget>[
          for (final color in Colors.primaries)
            GestureDetector(
              onTap: () {
                updateValue(color);
              },
              child: Container(
                color: color,
                width: itemWidth,
                height: itemHeight,
              ),
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_kKeyboardHeight);
}

/// A quick example "keyboard" widget for counter value.
class CounterKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  final ValueNotifier<String> notifier;

  CounterKeyboard({Key key, this.notifier}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(200);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                int value = int.tryParse(notifier.value) ?? 0;
                value--;
                updateValue(value.toString());
              },
              child: FittedBox(
                child: Text(
                  "-",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                int value = int.tryParse(notifier.value) ?? 0;
                value++;
                updateValue(value.toString());
              },
              child: FittedBox(
                child: Text(
                  "+",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
