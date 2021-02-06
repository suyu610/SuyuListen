/// 申请的状态
/// 分为 空闲 [FREE], 申请中 [LOADING], 已经有朋友了[HAS_FRIEND]
/// 初始状态为 [FREE] ,
/// 


enum FriendRequestState {
  FREE,
  LOADING,
  HAS_FRIEND,
}
