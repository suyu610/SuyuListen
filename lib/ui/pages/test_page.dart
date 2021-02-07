import 'dart:ui';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/ui/components/bubble/bubble_widget.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(),
        buildBlurWidget(),
        BubbleWidget(),
      ],
    );
  }

  buildBackground() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [blue, blue.withOpacity(0.6), blue.withOpacity(0.4)])),
      );
  buildBlurWidget() => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
        child: Container(
          color: Colors.white.withOpacity(0.1),
        ),
      );
}
