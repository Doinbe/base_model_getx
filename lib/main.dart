import 'package:base_model_getx/common/store/config.dart';
import 'package:base_model_getx/components/refresh_progress_indicator.dart';
import 'package:base_model_getx/global.dart';
import 'package:base_model_getx/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/routes/route_config.dart';

void main() async{
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(188, 406), //填入设计稿中设备的屏幕尺寸,单位dp
      builder: () => RefreshConfiguration(
        headerBuilder: () => ClassicHeader(refreshingIcon: buildRefreshIndicator(),),
        footerBuilder: () => ClassicFooter(loadingIcon: buildRefreshIndicator(),),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80,
        maxOverScrollExtent: 100,
        footerTriggerDistance: 150,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: PageRoutes.INIT_ROUTER,
          getPages: PageRoutes.routes,
          localizationsDelegates: const [
            RefreshLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: ConfigStore.to.languages,
          locale: ConfigStore.to.locale,
          fallbackLocale: ConfigStore.to.locale,
          enableLog: true,
          logWriterCallback: Logger.write,
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(
            builder: (context, widget) {
              return MediaQuery(
                ///设置文字大小不随系统设置改变
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
          ),
        ),
      ),
    );
  }
}
