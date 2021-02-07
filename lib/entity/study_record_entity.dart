import 'package:flutter/material.dart';

class StudyRecordEntity {
  /// 以天为单位
  DateTime day;

  /// 更新的时间戳
  int updateTimeStamp;

  /// 今天的学习时长 -> 单位:[秒]
  double studyDuration;

  /// 今天的学习时长目标 -> 单位:[秒]
  double studyDurationTarget;

  /// 今天的完成情况 [0,1]
  double progressValue;

  StudyRecordEntity({
    @required this.day,
    @required this.updateTimeStamp,
    this.studyDuration = 0,
    this.studyDurationTarget,
    this.progressValue = 0,
  })  : assert(progressValue <= 1),
        assert(progressValue >= 1);
}
