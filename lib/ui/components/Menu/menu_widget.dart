import 'package:SuyuListening/route/RouterHelper.dart';
import 'package:SuyuListening/ui/components/Popup/popup.dart';
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          child: Image.asset("assets/earth.png"),
                          radius: 50.h,
                          foregroundColor: Colors.transparent,
                          backgroundColor: Colors.transparent),
                      Text(
                        "20",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 48.sp, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          child: Image.asset("assets/jupiter.png"),
                          radius: 50.h,
                          foregroundColor: Colors.transparent,
                          backgroundColor: Colors.transparent),
                      Text(
                        "30",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 48.sp, color: Colors.white),
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
                            RouterHelper.router.navigateTo(
                              context,
                              "/gameCenter",
                              transition: TransitionType.inFromRight,
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
                      tapAction: () => RouterHelper.router.navigateTo(
                            context,
                            "/editor",
                            transition: TransitionType.inFromRight,
                          )),
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
