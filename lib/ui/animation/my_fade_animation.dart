import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class MyFadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final int millisecondsDuration;

  MyFadeAnimation(this.delay, this.millisecondsDuration, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: millisecondsDuration),
          Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(Duration(milliseconds: millisecondsDuration),
          Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
