import 'package:flutter/material.dart';

import '../../ui/components/customAvatar/fluttermoji.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            FluttermojiCircleAvatar(
              backgroundColor: Colors.white,
            ),
            FluttermojiCustomizer(
              outerTitleText: "设计你的头像吧",
              scaffoldHeight: 420,
            ),
          ],
        ),
      ),
    );
  }
}
