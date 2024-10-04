import 'package:dio/dio.dart';
import 'package:newlife_app/app/constants/app_url.dart';

class ApiService {
  static final _options = BaseOptions(
    baseUrl: AppUrl.baseUrl,
    responseType: ResponseType.json,
  );

  final Dio dio = Dio(_options)
    ..interceptors.add(LogInterceptor(responseBody: true));

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(url, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String url, {dynamic data}) async {
    try {
      return await dio.post(url, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String url, {dynamic data}) async {
    try {
      return await dio.put(url, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String url) async {
    try {
      return await dio.delete(url);
    } catch (e) {
      rethrow;
    }
  }
}
