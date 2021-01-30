import 'package:flutter/cupertino.dart';

class ArticleModel {
  String id = UniqueKey().toString();
  String title;
  int index;
  int coint;
  int level;
  int learnProgress;
  bool isDownloading = false;
  double downloadValue;
  String imageUrl = "assets/jupiter.png";
  bool isMark = false;
  @override
  String toString() {
    return index.toString();
  }
}
