import '../../../provider/key_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../components/avatar/custom_avatar/fluttermojiCircleAvatar.dart';

import '../../components/theme_switcher.dart';
import '../temp/avatar.dart';
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
                      title: "消息/test",
                      icon: Ionicons.notifications_outline,
                      tapAction: () => {
                            RouterHelper.router.navigateTo(
                              context,
                              "/test",
                              transition: TransitionType.fadeIn,
                            )
                          }),
                  MenuItem(
                      title: "单词本",
                      icon: Ionicons.book_outline,
                      tapAction: () => RouterHelper.router.navigateTo(
                            context,
                            "/word_book",
                            transition: TransitionType.inFromRight,
                          )),
                  MenuItem(
                      title: "伙伴/error",
                      icon: Ionicons.cog_outline,
                      tapAction: () => RouterHelper.router.navigateTo(
                            context,
                            "/error",
                            transitionDuration: Duration(milliseconds: 300),
                            transition: TransitionType.fadeIn,
                          )),
                  MenuItem(
                      title: "设置",
                      icon: Ionicons.person_outline,
                      tapAction: () => RouterHelper.router.navigateTo(
                            context,
                            "/setting",
                            transitionDuration: Duration(seconds: 1),
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
                  GestureDetector(
                    child: Icon(
                      Ionicons.skull_outline,
                      size: 35.sp,
                    ),
                    onTap: () => {
                      Provider.of<KeyProvider>(context, listen: false)
                              .isFocusMode
                          ? {
                              Provider.of<KeyProvider>(context, listen: false)
                                  .switchFocusMode(),
                              EasyLoading.showSuccess("已关闭专注模式")
                            }
                          : showCupertinoDialog(
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Icon(Ionicons.skull_outline),
                                  content: Text('\n要开启黑白专注模式吗?'),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text('确认'),
                                      onPressed: () {
                                        Provider.of<KeyProvider>(context,
                                                listen: false)
                                            .switchFocusMode();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text('取消'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                              context: context),
                    },
                  ),
                  SizedBox(
                    width: 60.w,
                  ),
                  themeSwitcher,
                  SizedBox(
                    width: 60.w,
                  ),
                  Icon(
                    Ionicons.flash,
                    size: 30.sp,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
