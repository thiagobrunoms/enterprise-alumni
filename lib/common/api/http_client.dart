import 'dart:async';

const String unexpectedErrorMessage = "Unexpected network error";

class ApiResponse {
  ApiResponse({required this.statusCode, this.data});

  int? statusCode;
  Map<String, dynamic>? data;
}

abstract class HttpClient<R extends ApiResponse, I> {
  Future<R> get(String url, {Map<String, dynamic> queryParameters});
  Future<R> post(String url, Map<String, dynamic> data, {Map<String, dynamic> queryParameters});
  Future<R> put(String url, Map<String, dynamic> data, {Map<String, dynamic> queryParameters});
  Future<R> delete(String url, {Map<String, dynamic> data, Map<String, dynamic> queryParameters});
  void addInterceptors(I interceptor);
}
