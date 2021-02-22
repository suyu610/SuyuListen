import 'dart:convert';

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

  StudyRecordEntity copyWith({
    DateTime day,
    int updateTimeStamp,
    double studyDuration,
    double studyDurationTarget,
    double progressValue,
  }) {
    return StudyRecordEntity(
      day: day ?? this.day,
      updateTimeStamp: updateTimeStamp ?? this.updateTimeStamp,
      studyDuration: studyDuration ?? this.studyDuration,
      studyDurationTarget: studyDurationTarget ?? this.studyDurationTarget,
      progressValue: progressValue ?? this.progressValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day?.millisecondsSinceEpoch,
      'updateTimeStamp': updateTimeStamp,
      'studyDuration': studyDuration,
      'studyDurationTarget': studyDurationTarget,
      'progressValue': progressValue,
    };
  }

  factory StudyRecordEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StudyRecordEntity(
      day: DateTime.fromMillisecondsSinceEpoch(map['day']),
      updateTimeStamp: map['updateTimeStamp'],
      studyDuration: map['studyDuration'],
      studyDurationTarget: map['studyDurationTarget'],
      progressValue: map['progressValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StudyRecordEntity.fromJson(String source) =>
      StudyRecordEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudyRecordEntity(day: $day, updateTimeStamp: $updateTimeStamp, studyDuration: $studyDuration, studyDurationTarget: $studyDurationTarget, progressValue: $progressValue)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StudyRecordEntity &&
        o.day == day &&
        o.updateTimeStamp == updateTimeStamp &&
        o.studyDuration == studyDuration &&
        o.studyDurationTarget == studyDurationTarget &&
        o.progressValue == progressValue;
  }

  @override
  int get hashCode {
    return day.hashCode ^
        updateTimeStamp.hashCode ^
        studyDuration.hashCode ^
        studyDurationTarget.hashCode ^
        progressValue.hashCode;
  }
}
