import 'package:base_model_getx/http/app_exceptions.dart';
import 'package:base_model_getx/utils/loading.dart';
import 'package:dio/dio.dart';

/// 错误处理拦截器
class ErrorInterceptor extends Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // error统一处理
    AppException appException = AppException.create(err);
    // 错误提示
    onHandlerError(appException);
    err.error = appException;
    super.onError(err, handler);
  }

  // error统一处理
  void onHandlerError(AppException eInfo) {
    Loading.dismiss();
    Loading.toast(eInfo.message, milliseconds: 4000);
  }
}