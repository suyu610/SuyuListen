/// 每一个page都有自己的controller
/// 事件汇总，并在此调用不同的service

abstract class MyPageController {
  Future initController();
  Future disposeController();
}
