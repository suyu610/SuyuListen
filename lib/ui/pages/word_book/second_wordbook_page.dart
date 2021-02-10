import 'dart:ui';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/ui/components/bubble/bubble_widget.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class SecondWordBookPage extends StatelessWidget {
  const SecondWordBookPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        buildBackground(),
        buildBlurWidget(),
        Container(
          color: Colors.transparent,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BorderedText(
                strokeColor: black,
                strokeWidth: 6.0,
                child: Text(
                  'under',
                  style: TextStyle(
                    color: white,
                    fontFamily: 'gta5Fonts',
                    fontSize: 60,
                    fontWeight: FontWeight.normal,
                    // letterSpacing: 2,
                    decoration: TextDecoration.none,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
              BorderedText(
                strokeColor: black,
                strokeWidth: 6.0,
                child: Text(
                  'Development',
                  style: TextStyle(
                    color: Color(0xfff2001b),
                    fontSize: 50,
                    fontFamily: 'gta5Fonts',
                    fontWeight: FontWeight.normal,
                    // letterSpacing: 2,
                    decoration: TextDecoration.none,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
            ],
          )
              // child: BorderedText(
              //   child:Text("开发中"),
              //   style: TextStyle(
              //       color: black, fontSize: 60, fontWeight: FontWeight.bold),
              // ),
              ),
        ),
        BubbleWidget(),
      ],
    );
  }

  buildBackground() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xffffa289), //#ffa289
              Color(0xffd07923), //#d07923
              Color(0xffaa2b25), //#aa2b25
            ])),
      );
  buildBlurWidget() => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
        child: Container(
          color: Colors.white.withOpacity(0.1),
        ),
      );
}
