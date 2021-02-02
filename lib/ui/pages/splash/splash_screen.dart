import 'package:SuyuListening/ui/animation/FadeAnimation.dart';
import 'package:SuyuListening/ui/animation/my_fade_animation.dart';
import 'package:flutter/material.dart';

import '../welcom_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = Duration(seconds: 2);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return WelcomePage();
      }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffffd673),
          // image: DecorationImage(
          //   image: AssetImage('assets/images/bg.png'),
          //   fit: BoxFit.contain,
          // ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
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
                          image:
                              AssetImage('assets/images/logo_transparent.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyFadeAnimation(
                        1.5,
                        1000,
                        Text(
                          "小",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontFamily: "logoFonts"),
                        ),
                      ),
                      MyFadeAnimation(
                        1.6,
                        1000,
                        Text(
                          "兔",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontFamily: "logoFonts"),
                        ),
                      ),
                      MyFadeAnimation(
                        1.7,
                        1000,
                        Text(
                          "崽",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontFamily: "logoFonts"),
                        ),
                      ),
                      MyFadeAnimation(
                        1.8,
                        1000,
                        Text(
                          "子",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontFamily: "logoFonts"),
                        ),
                      ),
                      MyFadeAnimation(
                        1.9,
                        1000,
                        Text(
                          "听",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontFamily: "logoFonts"),
                        ),
                      ),
                      MyFadeAnimation(
                        2.0,
                        1000,
                        Text(
                          "力",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontFamily: "logoFonts"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
