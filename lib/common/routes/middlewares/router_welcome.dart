import 'package:base_model_getx/common/routes/route_config.dart';
import 'package:base_model_getx/common/store/config.dart';
import 'package:base_model_getx/common/store/user_store.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// 第一次欢迎页面
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (ConfigStore.to.isFirstOpen == true) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return const RouteSettings(name: AppRoutes.main);
    } else {
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
