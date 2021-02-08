import 'package:SuyuListening/config/pref_keys.dart';
import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/route/router_helper.dart';
import 'package:SuyuListening/utils/shared_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:styled_text/styled_text.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    SharedUtil().saveBoolean(PrefKeys.isNotFirstLauch, true);

    // 将不是第一次启动的值，设置为true
    RouterHelper.router.navigateTo(context, "/welcome",
        transition: TransitionType.fadeIn,
        transitionDuration: Duration(seconds: 1),
        clearStack: true);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(
        'assets/$assetName',
        width: 220.0,
        fit: BoxFit.contain,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              Text(
                "素素 和 黄鹏宇\n浇灌激情与爱, 为您呈现",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          image: _buildImage('images/logo_transparent.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              Text(
                "面向对象\n学习竟如此有趣",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          image: _buildImage('images/popup/success.JPG'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Padding(
            padding: const EdgeInsets.all(34.0),
            child: StyledText(
              text: "<normal>凡心所向，</normal><bold>素</bold><normal>履所往</normal>",
              styles: {
                'normal': TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                  color: white, //color(0xffffefa4),
                ),
                'bold': TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                  color: yellow, //color(0xffffefa4),
                ),
              },
            ),
          ),
          image: _buildImage('images/onboarding_3.png'),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: Color(0xffeb118e)),
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xff171717),
            imagePadding: EdgeInsets.zero,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('至尾'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('冲呀',
          style: TextStyle(fontWeight: FontWeight.w600, color: white)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: white,
        activeColor: yellow,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }
}
