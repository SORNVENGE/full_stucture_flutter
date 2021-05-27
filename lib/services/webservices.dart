import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const username = 'ck_cf9d2a0080f06d414cd49b1818f74f8c0d4497ce';
const password = 'cs_130907954874514e5747f6ea09b8ff1a54e1e09b';

class Webservices {
    
    static String auth = 'Basic '+ base64Encode(utf8.encode('$username:$password'));

    static Future<Response> post(String url, {@required Map body, Function onSuccess, Function onError }) async {
      Dio dio = new Dio();

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      var cj = PersistCookieJar(ignoreExpires: true, persistSession: true, storage: FileStorage(appDocPath +"/.cookies/" ));
      dio.interceptors.add(CookieManager(cj));

      dio.options.baseUrl = 'https://rare-pair.lixr.me/wp-json/';

      return await dio.post(url,
        options: Options(
          headers: {
            'authorization': auth
          }
        ),
        data: json.encode(body)
      );
    }

    static Future<Response> put(String url, {@required Map body, Function onSuccess, Function onError }) async {
      Dio dio = new Dio();

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      var cj = PersistCookieJar(ignoreExpires: true, persistSession: true, storage: FileStorage(appDocPath +"/.cookies/" ));
      dio.interceptors.add(CookieManager(cj));

      dio.options.baseUrl = 'https://rare-pair.lixr.me/wp-json/';

      return await dio.put(url,
        options: Options(
          headers: {
            'authorization': auth
          }
        ),
        data: json.encode(body)
      );
    }

    static Future<Response> delete(String url, {Function onSuccess, Function onError }) async {
      Dio dio = new Dio();

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      var cj = PersistCookieJar(ignoreExpires: true, persistSession: true, storage: FileStorage(appDocPath +"/.cookies/" ));
      dio.interceptors.add(CookieManager(cj));

      dio.options.baseUrl = 'https://rare-pair.lixr.me/wp-json/';

      return await dio.delete(url,
        options: Options(
          headers: {
            'authorization': auth
          }
        )
      );
    }

    static Future<Response> get(String url, { Function onSuccess, Function onError }) async {
      Dio dio = new Dio();

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      var cj = PersistCookieJar(ignoreExpires: true, persistSession: true, storage: FileStorage(appDocPath +"/.cookies/" ));
      dio.interceptors.add(CookieManager(cj));

      dio.options.baseUrl = 'https://rare-pair.lixr.me/wp-json/';

      return await dio.get(url,
        options: Options(
          headers: {
            'authorization': auth
          }
        )
      );
    }
}
