import 'package:flutter/material.dart';

import 'friend_request_state_enum.dart';

class UserEntity {
  /////// [属性] ///////

  // id  - 从服务端传过来
  final int userId;
  // 账号
  final String username;
  // 昵称
  String nickname;
  // 朋友账号
  String friendUsername;
  // 密码的
  String pswMd5;
  // token
  String token;
  // 好友请求状态
  FriendRequestState friendRequestState;
  // 积分
  double coint;
  // 最新文章的时间戳 - (秒)
  int latestArticleTimestampInSecond;

  /////// [方法] ///////
  ///
  /// [login] 登陆
  /// [register] 注册
  /// 
  bool login() {
    return true;
  }

  UserEntity({
    @required this.userId,
    @required this.nickname,
    @required this.username,
    this.coint = 0,
    this.token,
    this.friendRequestState = FriendRequestState.FREE,
    this.friendUsername,
  })  : assert(nickname != null),
        assert(username != null);

  bool get hasNickname => nickname?.isNotEmpty == true;

  // factory UserEntity.fromJson(Map<String, dynamic> map) {
  //   final props = map['properties'];

  //   return UserEntity(
  //     nickname: props['nickname'] ?? '',
  //     username: props['username'] ?? '',
  //     token: props['token'] ?? '',
  //     friendUsername: props['friendUsername'] ?? '', userId: null,
  //   );
  // }

  // String get address {
  //   if (isCountry) return country;
  //   return '$name, $level2Address';
  // }

  // @override
  // String toString() =>
  //     'Place(name: $nickname, state: $token, country: $country)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserEntity &&
        o.nickname == nickname &&
        o.token == token &&
        o.username == username;
  }

  @override
  int get hashCode => nickname.hashCode ^ token.hashCode ^ username.hashCode;
}
