import 'package:dio/dio.dart';
import '../cache_helper/cache_keys.dart';
import '../cache_helper/shared_pref_methods.dart';
import '../constants/constants.dart';
import 'api_end_points.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    );
  }

  void getToken() {
    token = CacheHelper.getData(key: CacheKeys.token);
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    getToken();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language': 'ar',
      'User-Agent': 'PostmanRuntime/7.39.0',
      if (token != null) "Authorization": "$token",
      'Accept': 'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  Future<Response> postData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
    Options? options,
  }) async {
    getToken();
    final bool isFormData = data is FormData;
    dio.options.headers = {
      'Content-Type': isFormData ? 'multipart/form-data' : 'application/json',
      'Accept-Language': 'ar',
      'User-Agent': 'PostmanRuntime/7.39.0',
      if (token != null) "Authorization": "$token",
      'Accept': 'application/json',
    };
    return await dio.post(url, queryParameters: query, data: data, options: options);

    // return ;
  }

  Future<Response> deleteData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
  }) async {
    getToken();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language': 'ar',
      'User-Agent': 'PostmanRuntime/7.39.0',
      if (token != null) "Authorization": "$token",
      'Accept': 'application/json',
    };
    return await dio.delete(url, queryParameters: query, data: data);
  }

  Future<Response> putData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
  }) async {
    getToken();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language': 'ar',
      'User-Agent': 'PostmanRuntime/7.39.0',
      if (token != null) "Authorization": "$token",
      'Accept': 'application/json',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
