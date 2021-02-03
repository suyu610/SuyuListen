import '../../constant/theme_color.dart';
import '../../route/router_helper.dart';
import '../../ui/components/buttons/fancy_button.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_text/styled_text.dart';

import 'login/login_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: silver,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: silver,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StyledText(
                    text:
                        "<normal>©️小兔崽子听力 is an app written by Flutter & Java for my lover susu to use to improve listening skill efficiently</normal>",
                    styles: {
                      'normal': TextStyle(
                          wordSpacing: 2,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withAlpha(100)),
                    },
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Illustration.png'))),
              ),
              Column(
                children: <Widget>[
                  FancyButton(
                      titleColor: Colors.black,
                      onPress: () async {
                        RouterHelper.router.navigateTo(context, "/home",
                            transition: TransitionType.inFromRight,
                            clearStack: true);
                      },
                      label: "Experience without Login",
                      gradient:
                          LinearGradient(colors: [Colors.white, Colors.white])),
                  SizedBox(
                    height: 20.h,
                  ),
                  FancyButton(
                      titleColor: Colors.black,
                      onPress: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      label: "Login",
                      gradient: kActiveButtonGradient),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
