import 'package:SuyuListening/ui/components/avatar/generator.dart';
import 'package:SuyuListening/ui/pages/temp/avatar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant/theme_color.dart';
import '../../../route/router_helper.dart';
import '../../../ui/components/Popup/popup.dart';
import '../../../ui/components/customAvatar/fluttermojiCircleAvatar.dart';
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
      decoration: BoxDecoration(gradient: drawerGradient),
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
                            "13",
                            style:
                                TextStyle(fontSize: 30.sp, color: Colors.white),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Text(
                            "皇甫素素",
                            textAlign: TextAlign.end,
                            style:
                                TextStyle(fontSize: 30.sp, color: Colors.white),
                          ),
                        ],
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
                        child: CircleAvatar(
                            backgroundColor: silver.withAlpha(200),
                            radius: 70.h,
                            child: SvgPicture.string(
                              getSvg(
                                randomAvatarOptions(),
                              ),
                              height: 70.h * 1.6,
                            )),
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
                            "19",
                            style:
                                TextStyle(fontSize: 30.sp, color: Colors.white),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Text(
                            "黄鹏宇",
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
            Padding(
                padding:
                    const EdgeInsets.only(right: 10.0, left: 10, bottom: 10),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.white.withAlpha(60),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10),
                    child: Text(
                      "菜单",
                      style: TextStyle(color: Colors.white.withAlpha(60)),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.white.withAlpha(60),
                  )),
                ])),
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
                      title: "你的伙伴",
                      icon: Ionicons.cog_outline,
                      tapAction: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, a, b) => TempPage()))),
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
