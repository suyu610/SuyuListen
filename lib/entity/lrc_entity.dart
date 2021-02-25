import 'dart:convert';
import 'dart:io';

import 'package:SuyuListening/utils/lrc_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:SuyuListening/utils/storage_util.dart';

class LrcEntity {
  String title;
  String savePath;
  List<Lyric> lrcList;
  LrcEntity({
    this.title,
    this.savePath,
    this.lrcList,
  });

  Future<void> init() async {
    // 首先判断本地是否存在
    String path = await getLrcFolderPath();
    File file = new File(path + "/" + savePath + ".txt");
    if (!await file.exists()) {
      // 如果不存在则从网络上下载
      var url = "https://cdns.qdu.life/suyuListen/files/$savePath" + ".lrc";
      Dio dio = new Dio();
      String path = await getLrcFolderPath();
      var response = await dio.download(url, path + "/" + savePath + ".txt",
          options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
          onReceiveProgress: (received, total) {
        if (total != -1) {
        }
      });

      if (response.statusCode == 200) {
        // 解析lrc
        parseLrcFile();
      } else {
        throw Exception("下载失败");
      }
    } else {
      parseLrcFile();
    }
  }

  Future<void> parseLrcFile() async {
    String path = await getLrcFolderPath();
    File file = new File(path + "/" + savePath + ".txt");

    if (!await file.exists()) {
      init();
    } else {
      String lrcStr = await file.readAsString(encoding: latin1);
      lrcList = LyricUtil.formatLyric(lrcStr);
    }
  }

  // 从本地获取
  LrcEntity loadFromLocal() {
    return LrcEntity();
  }

  // 获取最大时间
  Future<double> getMaxTime() async {
    if (lrcList != null) {
      return lrcList.last.endTime.inMilliseconds.toDouble();
    } else {
      await parseLrcFile();
      return lrcList.last.endTime.inMilliseconds.toDouble();
    }
  }

  // 通过时间点，获得当前的歌词
  // 如果没找到匹配的，则返回空
  Lyric getLyric(num time) {
    if (time < 0) throw Exception("时间为负数");

    lrcList.forEach((element) {
      if (time >= element.startTime.inMilliseconds &&
          time <= element.endTime.inMilliseconds) {
        return element;
      }
    });
    throw Exception("未知错误");
  }

  // 如果全部完成，则为完成
  bool isComplete() {
    lrcList.forEach((element) {
      if (!element.isRemark) return false;
    });
    return true;
  }

  LrcEntity copyWith({
    String title,
    String savePath,
    List<Lyric> lrcList,
  }) {
    return LrcEntity(
      title: title ?? this.title,
      savePath: savePath ?? this.savePath,
      lrcList: lrcList ?? this.lrcList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'savePath': savePath,
      'lrcList': lrcList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory LrcEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LrcEntity(
      title: map['title'],
      savePath: map['savePath'],
      lrcList: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LrcEntity.fromJson(String source) =>
      LrcEntity.fromMap(json.decode(source));

  @override
  String toString() =>
      'LrcEntity(title: $title, savePath: $savePath, lrcList: $lrcList)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LrcEntity &&
        o.title == title &&
        o.savePath == savePath &&
        listEquals(o.lrcList, lrcList);
  }

  @override
  int get hashCode => title.hashCode ^ savePath.hashCode ^ lrcList.hashCode;
}

class Lyric {
  String lyric;
  Duration startTime;
  Duration endTime;
  bool isRemark;
  Lyric(this.lyric, {this.startTime, this.endTime, this.isRemark = false});

  Map<String, dynamic> toMap() {
    return {
      'lyric': lyric,
      'startTime': startTime.inMilliseconds,
      'endTime': endTime?.inMilliseconds,
      'isRemark': isRemark,
    };
  }

  @override
  String toString() {
    return 'Lyric(lyric: $lyric, startTime: $startTime, endTime: $endTime, isRemark: $isRemark)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Lyric &&
        o.lyric == lyric &&
        o.startTime == startTime &&
        o.endTime == endTime &&
        o.isRemark == isRemark;
  }

  @override
  int get hashCode {
    return lyric.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        isRemark.hashCode;
  }
}
