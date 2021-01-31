// ignore: must_be_immutable
import 'dart:async';
import 'dart:ui';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/model/article_model.dart';
import 'package:SuyuListening/ui/animation/FadeAnimation.dart';
import 'package:SuyuListening/ui/pages/article/article_detail.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:ionicons/ionicons.dart' as icon_2;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleListTile extends StatefulWidget {
  const ArticleListTile({
    this.model,
    Key key,
  }) : super(key: key);
  final ArticleModel model;
  @override
  _ArticleListTileState createState() => _ArticleListTileState();
}

class _ArticleListTileState extends State<ArticleListTile> {
  ArticleModel model;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  void tapBookMark() {
    EasyLoading.showSuccess(model.isMark ? "取消收藏" : "已收藏");
    model.isMark = !model.isMark;
    setState(() {});
  }

  void tapDownloadingButton() {
    if (model.isDownloading) {
      EasyLoading.showError("取消下载");
      // 取消下载
      model.downloadValue = 0;
    } else {
      const timeout = const Duration(milliseconds: 100);

      Timer.periodic(timeout, (timer) {
        model.downloadValue += 0.01;
        if (model.downloadValue >= 1) {
          timer.cancel();
          EasyLoading.showSuccess("下载完成");
        }
        setState(() {});
      });
    }
    model.isDownloading = !model.isDownloading;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticleDetailPage();
        }))
      },
      onLongPress: () => {
        CoolAlert.show(
            backgroundColor: ThemeColors.colorTheme,
            context: context,
            confirmBtnColor: ThemeColors.colorTheme,
            confirmBtnTextStyle: TextStyle(color: Colors.black),
            type: CoolAlertType.confirm,
            lottieAsset: "assets/lotties/lf30_editor_obrqtkg5.json",
            title: "确认删除吗?",
            confirmBtnText: "确认",
            cancelBtnText: "取消",
            cancelBtnTextStyle: TextStyle(color: Colors.black),
            onConfirmBtnTap: () async {
              // list.removeAt(index);
              setState(() {});
              Navigator.pop(context);
              EasyLoading.showSuccess("删除成功");
            })
      },
      child: Container(
        height: 300.h,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: gradientStartColor,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(model.imageUrl),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 10,
                  offset: Offset(0, 10))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 标题
                      FadeAnimation(
                          1,
                          Text(
                            model.title,
                            maxLines: 2,
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Colors.black54,
                                      blurRadius: 4,
                                      offset: Offset(0, 0))
                                ],
                                color: Colors.white,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      // 积分
                      FadeAnimation(
                          1.1,
                          Container(
                            // padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                            width: 100.w,
                            // color: Colors.black38,
                            child: Row(
                              children: [
                                Icon(
                                  icon_2.Ionicons.flower,
                                  size: 30.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  model.coint.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 34.sp),
                                ),
                              ],
                            ),
                          )),
                      // 难度
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: FadeAnimation(
                          1.1,
                          RatingBar(
                            rating: 3,
                            icon: Icon(
                              Icons.star,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                            color: gradientEndColor,
                            starCount: 5,
                            spacing: 1.0.w,
                            size: 30.w,
                            isIndicator: true,
                            allowHalfRating: true,
                            onRatingCallback: (double value,
                                ValueNotifier<bool> isIndicator) {
                              print('Number of stars-->  $value');
                              //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                              isIndicator.value = true;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeAnimation(
                    1.2,
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => tapDownloadingButton(),
                          child: model.isDownloading
                              ? Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 55.h,
                                  width: 55.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: model.downloadValue < 1
                                          ? Colors.white
                                          : ThemeColors.colorTheme),
                                  child: model.downloadValue < 1
                                      ? Center(
                                          child:
                                              LiquidCircularProgressIndicator(
                                            value: model
                                                .downloadValue, // Defaults to 0.5.
                                            valueColor: AlwaysStoppedAnimation(
                                                ThemeColors
                                                    .colorTheme), // Defaults to the current Theme's accentColor.
                                            backgroundColor: Colors
                                                .transparent, // Defaults to the current Theme's backgroundColor.
                                            direction: Axis
                                                .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                            center: Text(
                                              (model.downloadValue * 100)
                                                      .toInt()
                                                      .toString() +
                                                  "%",
                                              style: TextStyle(fontSize: 22.sp),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Icon(
                                            icon_2.Ionicons.checkmark,
                                            color: Colors.black,
                                            size: 36.sp,
                                          ),
                                        ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width: 55.h,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Center(
                                    child: Icon(
                                      icon_2.Ionicons.cloud_download_outline,
                                      size: 36.sp,
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () => tapBookMark(),
                          child: Container(
                            width: 55.h,
                            height: 55.h,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: model.isMark
                                    ? ThemeColors.colorTheme
                                    : Colors.white),
                            child: Center(
                              child: Icon(
                                Icons.bookmark_border_rounded,
                                color: Colors.black,
                                size: 36.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            // 进度
            FadeAnimation(
                1.3,
                Text(
                  model.learnProgress.toString() + "%",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}