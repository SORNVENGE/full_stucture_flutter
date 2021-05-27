import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

var cookieJar = CookieJar();

Dio dio() {
  Dio dio = new Dio();

  dio.interceptors.add(CookieManager(cookieJar));
  dio.options.baseUrl = 'https://rare-pair.lixr.me/wp-json/';

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        options.headers['Accept'] = 'application/json';
        return handler.next(options);
      }
    )
  );

  return dio;
}