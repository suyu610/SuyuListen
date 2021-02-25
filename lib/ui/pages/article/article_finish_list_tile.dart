// ignore: must_be_immutable
import 'dart:async';
import 'dart:ui';

import 'package:SuyuListening/entity/article/user_article_entity.dart';

import '../article_detail/article_detail.dart';
import '../../components/animation/fade_animation.dart';
import '../../../constant/theme_color.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:ionicons/ionicons.dart' as icon_2;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleFinishListTile extends StatefulWidget {
  const ArticleFinishListTile({
    this.model,
    Key key,
  }) : super(key: key);
  final UserArticleEntity model;
  @override
  _ArticleListTileState createState() => _ArticleListTileState();
}

class _ArticleListTileState extends State<ArticleFinishListTile>
    with AutomaticKeepAliveClientMixin {
  UserArticleEntity model;
  Timer timer;
  @override
  bool get wantKeepAlive => true;

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
      timer.cancel();
    } else {
      const timeout = const Duration(milliseconds: 100);

      timer = Timer.periodic(timeout, (timer) {
        model.downloadValue += 0.01;
        if (model.downloadValue >= 1) {
          timer.cancel();
          EasyLoading.showSuccess("下载完成");
        }
        setState(() {});
      });
    }
    model.isDownloading = !model.isDownloading;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticleDetailPage();
        }))
      },
      onLongPress: () => {
        CoolAlert.show(
            backgroundColor: yellow,
            context: context,
            confirmBtnColor: yellow,
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
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          // color: blue,
          gradient: listTileGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Column(
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
                            BorderedText(
                              strokeWidth: 2.0,
                              strokeColor: Colors.black38,
                              child: Text(
                                model.articleEntity.title,
                                maxLines: 2,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationColor: Colors.red,
                                    color: Colors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          // 积分
                          FadeAnimation(
                              1.1,
                              Container(
                                // padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                                width: 200.w,
                                // color: Colors.black38,
                                child: Row(
                                  children: [
                                    Icon(
                                      icon_2.Ionicons.time_outline,
                                      size: 30.sp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),

                                    // 用时
                                    Text(
                                      "10' 13''",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24.sp),
                                    ),
                                  ],
                                ),
                              )),

                          SizedBox(
                            height: 20.h,
                          ),
                          // 完成时间
                          FadeAnimation(
                            1.3,
                            Row(
                              children: [
                                Icon(
                                  icon_2.Ionicons.calendar_outline,
                                  size: 30.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "2020-2-13",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          // 难度
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FadeAnimation(
                              1.1,
                              RatingBar(
                                rating:
                                    model.articleEntity.level.index.toDouble(),
                                icon: Icon(
                                  Icons.star,
                                  size: 30.sp,
                                  color: Colors.white,
                                ),
                                color: yellow,
                                starCount: 5,
                                spacing: 1.0.w,
                                size: 30.w,
                                isIndicator: true,
                                allowHalfRating: true,
                                onRatingCallback: (double value,
                                    ValueNotifier<bool> isIndicator) {
                                  isIndicator.value = true;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 300.h,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75.w),
                  image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    image: NetworkImage(model.articleEntity.imageUrl),
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
