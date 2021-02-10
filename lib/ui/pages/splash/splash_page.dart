import 'dart:async';

import 'package:SuyuListening/controller/splash_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../route/router_helper.dart';
import '../../components/animation/my_fade_animation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController;

  Future<bool> isLogin;
  @override
  void initState() {
    splashController = SplashController(context);

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
                height: 50,
                width: 1000,
                child: WavyAnimatedTextKit(
                  speed: Duration(milliseconds: 200),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      fontSize: 28.0,
                      // fontFamily: 'logoFonts',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  text: [
                    "小兔崽听力",
                  ],
                  repeatForever: false,
                  isRepeatingAnimation: false,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FutureBuilder(
                future: splashController.decideWhereNeedGo(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Future.delayed(
                          Duration(milliseconds: 1500),
                          () => RouterHelper.router.navigateTo(
                              context, snapshot.data,
                              transitionDuration: Duration(seconds: 1),
                              clearStack: true,
                              transition: TransitionType.fadeIn));
                    });
                    return Text("欢迎回来");
                  } else {
                    return SpinKitFadingCircle(
                      color: Colors.black,
                      size: 30.0,
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
