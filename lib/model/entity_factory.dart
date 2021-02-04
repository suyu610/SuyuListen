import 'entities.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "SimpleWordEntity") {
      return SimpleWordEntity.fromJson(json) as T;
    } else if (T.toString() == "YouDaoWordEntity") {
      return YouDaoWordEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
