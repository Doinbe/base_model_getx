import 'package:base_model_getx/common/routes/middlewares/router_welcome.dart';
import 'package:base_model_getx/page/welcome/binding.dart';
import 'package:base_model_getx/page/welcome/view.dart';
import 'package:get/get.dart';

class AppRoutes{
  ///主页面
  static const String main = "/main";
  static const String welcome = "/welcome";
  ///登录页面
  static const String login = "/login";

}

class PageRoutes {
  static const String INIT_ROUTER = AppRoutes.welcome;
  static final List<GetPage<dynamic>> routes = [

    GetPage(
      name: AppRoutes.welcome,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),

  ];
}