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
        color: Color(0xfffff7eb),
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
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color(0xfffff7eb),
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "素语听力",
                  style: TextStyle(fontSize: 24, color: Color(0xffbe4f29)),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
