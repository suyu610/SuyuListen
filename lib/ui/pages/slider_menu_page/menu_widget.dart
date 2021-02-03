import 'package:SuyuListening/ui/components/avatar/custom_avatar/fluttermojiCircleAvatar.dart';

import '../../../ui/components/dialog/popup.dart';
import '../../../ui/components/theme_switcher.dart';
import '../../../ui/pages/temp/avatar.dart';
import '../../../constant/theme_color.dart';
import '../../../route/router_helper.dart';
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
        color: Theme.of(context).backgroundColor,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          RouterHelper.router.navigateTo(
                            context,
                            "/avatar_setting",
                            transition: TransitionType.fadeIn,
                          )
                        },
                        child: FluttermojiCircleAvatar(
                          radius: 70.h,
                          backgroundColor: silver.withAlpha(200),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "皇甫素素",
                        textAlign: TextAlign.end,
                        style: kCaptionTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          RouterHelper.router.navigateTo(
                            context,
                            "/avatar_setting",
                            transition: TransitionType.fadeIn,
                          )
                        },

                        child: FluttermojiCircleAvatar(
                          radius: 70.h,
                          backgroundColor: silver.withAlpha(200),
                        ),
                        // child: CircleAvatar(
                        //     backgroundColor: silver.withAlpha(200),
                        //     radius: 70.h,
                        //     child: SvgPicture.string(
                        //       "",
                        //       // getSvg(
                        //       //   randomAvatarOptions(),
                        //       // ),
                        //       height: 70.h * 1.6,
                        //     )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("黄鹏宇",
                          textAlign: TextAlign.end, style: kCaptionTextStyle),
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
                      icon: Ionicons.notifications_outline,
                      tapAction: () => {
                            RouterHelper.router.navigateTo(
                              context,
                              "/avatar_setting",
                              transition: TransitionType.fadeIn,
                            )
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
                      title: "伙伴",
                      icon: Ionicons.cog_outline,
                      tapAction: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, a, b) => TempPage()))),
                  MenuItem(
                      title: "设置",
                      icon: Ionicons.person_outline,
                      tapAction: () => RouterHelper.router.navigateTo(
                            context,
                            "/setting",
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
                  themeSwitcher,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
