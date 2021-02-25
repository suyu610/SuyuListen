import 'package:SuyuListening/controller/page_controller.dart';

import 'package:SuyuListening/route/router_helper.dart';
import 'package:flutter/material.dart';

class LoginController implements MyPageController {
  BuildContext context;

  @override
  Future initController() async {
    return true;
  }

  @override
  Future disposeController() async {
    return true;
  }

  void jumpToHomePage() {
    RouterHelper.router.navigateTo(context, '/home', clearStack: true);
  }

  LoginController(context) {
    this.context = context;
    initController();
  }
}
