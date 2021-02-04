import 'package:SuyuListening/ui/components/avatar/custom_avatar/fluttermoji.dart';
import 'package:SuyuListening/ui/components/buttons/fancy_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import '../../../constant/theme_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../route/router_helper.dart';

class TodayArticleBackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FluttermojiCircleAvatar(
                radius: 70.h,
                backgroundColor: Colors.transparent,
              ),
              ChatBubble(
                clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
                backGroundColor: Colors.white,
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    "我已经学了2小时了，你还不开始学习吗?",
                    style: TextStyle(fontSize: 24.sp, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              width: 240.w,
              height: 100.h,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FancyButton(
                    titleColor: Colors.black,
                    onPress: () async {
                      RouterHelper.router.navigateTo(context, "/article_detail");
                    },
                    label: "开始学习",
                    gradient: kActiveButtonGradient,
                  )))
        ],
      ),
    );
  }
}
