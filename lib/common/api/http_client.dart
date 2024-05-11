import 'dart:async';

import '../failure.dart';

const String unexpectedErrorMessage = "Unexpected network error";

class ApiResponse {
  ApiResponse({required this.statusCode, this.data});

  int? statusCode;
  Map<String, dynamic>? data;
}

class BasicApiFailure extends Failure {
  BasicApiFailure({required String errorMessage, this.statusCode}) : super(errorMessage: errorMessage);

  int? statusCode;
}

abstract class HttpClient<F extends Failure, R extends ApiResponse, I> {
  Future<(F?, R?)> get(String url, {Map<String, dynamic> queryParameters});
  Future<(F?, R?)> post(String url, Map<String, dynamic> data, {Map<String, dynamic> queryParameters});
  Future<(F?, R?)> put(String url, Map<String, dynamic> data, {Map<String, dynamic> queryParameters});
  Future<(F?, R?)> delete(String url, {Map<String, dynamic> data, Map<String, dynamic> queryParameters});
  void addInterceptors(I interceptor);
}
