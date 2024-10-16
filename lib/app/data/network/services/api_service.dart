import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newlife_app/app/constants/app_url.dart';

class ApiService {
  late final Dio dio;
  final GetStorage storage = GetStorage();

  ApiService() {
    dio = Dio(BaseOptions(
      baseUrl: AppUrl.baseUrl,
      responseType: ResponseType.json,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = storage.read('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(url, queryParameters: queryParameters);
    } catch (e) {
      print('GET request error: $e');
      rethrow;
    }
  }

  Future<Response> post(String url, {dynamic data}) async {
    try {
      return await dio.post(url, data: data);
    } catch (e) {
      print('POST request error: $e');
      rethrow;
    }
  }

  Future<Response> put(String url, {dynamic data}) async {
    try {
      return await dio.put(url, data: data);
    } catch (e) {
      print('PUT request error: $e');
      rethrow;
    }
  }

  Future<Response> delete(String url) async {
    try {
      return await dio.delete(url);
    } catch (e) {
      print('DELETE request error: $e');
      rethrow;
    }
  }

  Future<Response> patch(String url, {dynamic data}) async {
    try {
      return await dio.patch(url, data: data);
    } catch (e) {
      print('PATCH request error: $e');
      rethrow;
    }
  }
}
