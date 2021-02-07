import 'package:SuyuListening/entity/study_record_entity.dart';

class StudyRecordService {
  // 存
  Future<bool> saveRecord(StudyRecordEntity record) async {
    return true;
  }
  // 改
  Future<bool> updateRecord(StudyRecordEntity record) async {
    return true;
  }
  
  ///// 查  
  // 按天查询
  Future<StudyRecordEntity> getRecordByDate(DateTime date) async {
    StudyRecordEntity studyRecordEntity;
    return studyRecordEntity;
  }

  // 查询在此之前的学习记录
  Future<List<StudyRecordEntity>> getRecordBeforeDate(DateTime date) async {
    List<StudyRecordEntity> list = [];
    return list;
  }
}
