import 'package:base_model_getx/common/services/storage_service.dart';
import 'package:base_model_getx/common/store/config.dart';
import 'package:base_model_getx/common/store/user_store.dart';
import 'package:base_model_getx/http/config.dart';
import 'package:base_model_getx/http/http_utils.dart';
import 'package:base_model_getx/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


/// 全局静态数据
class Global {
  ///是否开发
  static const bool BEBUG = true;

  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    setSystemUi();
    Loading();

    /// 初始化request类
    HttpUtils.init(
      baseUrl: HttpConfig.BASE_URL,
    );

    /// 初始化本地存储类
    await Get.putAsync<StorageService>(() => StorageService().init());

    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
  }

  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
