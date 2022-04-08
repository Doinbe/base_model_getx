
import 'dart:io';

import 'package:base_model_getx/common/store/user_store.dart';
import 'package:base_model_getx/global.dart';
import 'package:base_model_getx/http/interceptor/cache_interceptor.dart';
import 'package:base_model_getx/http/interceptor/error_interceptor.dart';
import 'package:base_model_getx/http/interceptor/header_interceptor.dart';
import 'package:base_model_getx/http/interceptor/retry_interceptor.dart';
import 'package:base_model_getx/http/proxy.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Http {
  static final Http _instance = Http._internal();
  factory Http() => _instance;

  static late final Dio dio;
  final CancelToken _cancelToken = CancelToken();

  ///超时时间
  static const int CONNECT_TIMEOUT = 6000;
  static const int RECEIVE_TIMEOUT = 6000;

  Http._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions();

    dio = Dio(options);

    //请求头拦截器
    dio.interceptors.add(HeaderInterceptor());
    //错误信息拦截器
    dio.interceptors.add(ErrorInterceptor());
    //重试请求拦截器
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    //日志格式化拦截器
    if(Global.BEBUG){
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    }
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (PROXY_ENABLE) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init({
    String? baseUrl,
    int connectTimeout = Http.CONNECT_TIMEOUT,
    int receiveTimeout = Http.RECEIVE_TIMEOUT,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers ?? const {},
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  // 关闭dio
  void cancelRequests({required CancelToken token}) {
    _cancelToken.cancel("cancelled");
  }

  // 添加认证
  // 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    Map<String, dynamic>? headers;
    //从缓存中获取
    if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
      headers = {
        'Authorization': UserStore.to.token,
      };
    }
    return headers;
  }

  Future get(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "refresh": refresh,
        "noCache": noCache,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    Response response;
    response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );

    return response.data;
  }

  Future post(
      String path, {
        Map<String, dynamic>? params,
        data,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
      onSendProgress: onSendProgress,
    );
    return response.data;
  }

  Future put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  Future patch(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  Future delete(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }
}
