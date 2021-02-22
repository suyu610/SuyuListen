import 'dart:convert';

class Topic {
  int topicId;
  String topicName;
  
  Topic({
    this.topicId,
    this.topicName,
  });

  Topic copyWith({
    int topicId,
    String topicName,
  }) {
    return Topic(
      topicId: topicId ?? this.topicId,
      topicName: topicName ?? this.topicName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topicId': topicId,
      'topicName': topicName,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Topic(
      topicId: map['topicId'],
      topicName: map['topicName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) => Topic.fromMap(json.decode(source));

  @override
  String toString() => 'Topic(topicId: $topicId, topicName: $topicName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Topic &&
      o.topicId == topicId &&
      o.topicName == topicName;
  }

  @override
  int get hashCode => topicId.hashCode ^ topicName.hashCode;
}
