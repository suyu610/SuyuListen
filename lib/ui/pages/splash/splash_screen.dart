import 'dart:async';

import 'package:SuyuListening/provider/key_provider.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';

import '../../../route/router_helper.dart';
import '../../../ui/components/animation/my_fade_animation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<KeyProvider>(context, listen: false).innerDrawerKey =
        new GlobalKey<InnerDrawerState>();
    Future.delayed(Duration(milliseconds: 1800), () {
      RouterHelper.router.navigateTo(context, "/welcome",
          transition: TransitionType.fadeIn, clearStack: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffd673),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyFadeAnimation(
              1,
              1000,
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xffffd673),
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo_transparent.png'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            MyFadeAnimation(
              1.5,
              1000,
              SizedBox(
                height: 32,
                width: 1000,
                child: WavyAnimatedTextKit(
                  speed: Duration(milliseconds: 300),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      fontSize: 32.0,
                      fontFamily: 'logoFonts',
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  text: [
                    "小兔崽听力",
                  ],
                  repeatForever: false,
                  isRepeatingAnimation: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
