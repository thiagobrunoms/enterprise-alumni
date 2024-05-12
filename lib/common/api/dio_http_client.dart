import 'package:dio/dio.dart';

import 'http_client.dart';

class DioHttpClient extends HttpClient<ApiResponse, Interceptor> {
  DioHttpClient(this._client);

  final Dio _client;

  @override
  Future<ApiResponse> get(String url, {Map<String, dynamic>? queryParameters}) async {
    final response = await _client.get(url, queryParameters: queryParameters);
    return ApiResponse(statusCode: response.statusCode, data: response.data);
  }

  @override
  Future<ApiResponse> post(String url, Map<String, dynamic> data, {Map<String, dynamic>? queryParameters}) async {
    final response = await _client.post(url, data: data, queryParameters: queryParameters);
    return ApiResponse(statusCode: response.statusCode, data: response.data);
  }

  @override
  Future<ApiResponse> put(String url, Map<String, dynamic> data, {Map<String, dynamic>? queryParameters}) async {
    final response = await _client.put(url, data: data, queryParameters: queryParameters);
    return ApiResponse(statusCode: response.statusCode, data: response.data);
  }

  @override
  Future<ApiResponse> delete(String url, {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) async {
    final response = await _client.delete(url, data: data, queryParameters: queryParameters);
    return ApiResponse(statusCode: response.statusCode, data: response.data);
  }

  @override
  void addInterceptors(Interceptor interceptor) {
    _client.interceptors.add(interceptor);
  }
}
