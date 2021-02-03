import 'package:SuyuListening/constant/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

import '../components/customAvatar/fluttermoji.dart';

class AvatarSettingPage extends StatefulWidget {
  AvatarSettingPage({Key key}) : super(key: key);

  @override
  _AvatarSettingPageState createState() => _AvatarSettingPageState();
}

class _AvatarSettingPageState extends State<AvatarSettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: silver,
        body: Stack(
          children: [
            Column(
              children: [
                FluttermojiCircleAvatar(
                    radius: 100, backgroundColor: silver.withAlpha(150)),
                SizedBox(
                  height: 30,
                ),
                FluttermojiCustomizer(
                  outerTitleText: "来设计素素的头像吧",
                  scaffoldHeight: 400,
                ),
              ],
            ),
            Positioned(
              right: 50,
              top: 10,
              child: ChatBubble(
                clipper: ChatBubbleClipper6(type: BubbleType.receiverBubble),
                backGroundColor: blue,
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "来打我呀",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
