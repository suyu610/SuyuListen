class LrcEntity {
  String title;
  String path;
  List<Lyric> lrcList;

  // 从本地获取
  LrcEntity loadFromLocal() {
    return LrcEntity();
  }

  LrcEntity loadFromNet() {
    return LrcEntity();
  }
  // 获取最大时间
  num getMaxTime() {
    return lrcList.last.endTime;
  }

  // 通过时间点，获得当前的歌词
  // 如果没找到匹配的，则返回空
  Lyric getLyric(num time) {
    if (time < 0) throw Exception("时间为负数");

    if (time > getMaxTime()) throw Exception("超出时间");

    lrcList.forEach((element) {
      if (time >= element.startTime && time <= element.endTime) {
        return element;
      }
    });
    throw Exception("未知错误");
  }

  // 如果全部完成，则为完成
  bool isComplete() {
    lrcList.forEach((element) {
      if (!element.isComplete) return false;
    });
    return true;
  }
}

class Lyric {
  // 歌词文本
  String text;
  // 毫秒
  num startTime;
  num endTime;
  bool isComplete;
}
