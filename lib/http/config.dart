import 'package:base_model_getx/global.dart';

class HttpConfig {
  ///HTTP
  ///开发
  static const String DEBUG_URL = '';
  ///将 DEBUG_URL 通过 NUAPI（https://www.nuapi.com/）域名转发生成代理地址
  static const String PROXY_URL = '';
  ///内试
  static const String RELEASE_URL = '';
  static const String HTTP_URL = Global.BEBUG ? PROXY_URL : RELEASE_URL;
  static const String BASE_URL = '$HTTP_URL/api';
  static const String BASE_FILE = '$HTTP_URL/file';
}