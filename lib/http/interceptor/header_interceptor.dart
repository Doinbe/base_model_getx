// 请求头拦截器
import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.copyWith(
      headers: {
        "Content-Type": "application/json",
        'terminal': 'terminal',
      },
    );
    return super.onRequest(options, handler);
  }
}
