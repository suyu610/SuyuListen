import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/route/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

/// from [https://github.com/abuanwar072/20-Error-States-Flutter]
/// author: Abu Anwar & Abdul Momin

class RouteErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/5_Something_Wrong.png",
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Oh no!",
                style: TextStyle(
                    fontSize: 34,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "好像出了点问题...",
                style: TextStyle(fontSize: 16, color: Color(0xff777485)),
              ),
              SizedBox(
                height: 50,
              ),
              OutlineButton.icon(
                highlightColor: yellow,
                highlightedBorderColor: colorBlack,
                borderSide: BorderSide(width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  // 如果没有上一页，则去splash页面,否则返回
                  Navigator.of(context).canPop()
                      ? RouterHelper.router.pop(context)
                      : RouterHelper.router
                          .navigateTo(context, "/splash", clearStack: true);
                },
                label: Text("刷新".toUpperCase()),
                icon: Icon(Icons.refresh),
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
          Positioned(
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(
                      Ionicons.flower_outline,
                      color: Colors.grey[300],
                      size: 20,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "反馈",
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
