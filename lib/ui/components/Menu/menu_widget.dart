import '../../../constant/theme_color.dart';
import '../../../route/router_helper.dart';
import '../../../ui/components/Popup/popup.dart';
import '../../../ui/components/customAvatar/fluttermojiCircleAvatar.dart';
import '../../../ui/pages/message.dart';
import '../../../ui/pages/profile.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import 'menu_item.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);
  void printHello() {
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        // image: DecorationImage(
        // image: AssetImage("assets/images/main_bg_with_blank.png"),
        // fit: BoxFit.none,
        // repeat: ImageRepeat.repeat,
        // )
      ),
      // color: ThemeColors.colorBlack,
      // color: Colors.grey[900],
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfilePage();
                            }));
                          })
                        },
                        child: FluttermojiCircleAvatar(
                          radius: 50.h,
                          backgroundColor: colorWhite,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.flower_outline,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Text(
                            "30",
                            textAlign: TextAlign.end,
                            style:
                                TextStyle(fontSize: 30.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfilePage();
                          }))
                        },
                        child: FluttermojiCircleAvatar(
                          radius: 50.h,
                          backgroundColor: colorWhite,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.flower_outline,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Text(
                            "30",
                            textAlign: TextAlign.end,
                            style:
                                TextStyle(fontSize: 30.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MenuItem(
                      title: "消息",
                      icon: Ionicons.notifications,
                      tapAction: () => {
                            Future.delayed(Duration.zero, () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MessagePage();
                              }));
                            })
                          }),
                  MenuItem(
                      title: "单词本",
                      icon: Ionicons.book_outline,
                      tapAction: () {
                        showPopup(
                          context,
                          printHello,
                          title: "oh-ooh123",
                        );
                      }),
                  MenuItem(
                      title: "你的伙伴",
                      icon: Ionicons.cog_outline,
                      tapAction: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfilePage();
                            }))
                          }),
                  MenuItem(
                      title: "我的",
                      icon: Ionicons.person_outline,
                      tapAction: () => RouterHelper.router.navigateTo(
                            context,
                            "/song",
                            transition: TransitionType.inFromRight,
                          )),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      iconSize: 34.sp,
                      icon: Icon(Ionicons.information),
                      color: Colors.white,
                      onPressed: () => {}),
                  Text(
                    "关于我们",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
