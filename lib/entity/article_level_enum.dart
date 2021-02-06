import 'dart:math';

enum TopicLevel { VeryEasy, Easy, Normal, Hard, VeryNormal }

TopicLevel randomLevel() {
  var index = Random().nextInt(TopicLevel.values.length);
  return TopicLevel.values[index];
}
