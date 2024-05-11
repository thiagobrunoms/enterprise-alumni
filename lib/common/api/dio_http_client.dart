import 'package:dio/dio.dart';

import 'http_client.dart';

class DioHttpClient extends HttpClient<BasicApiFailure, ApiResponse, Interceptor> {
  DioHttpClient(this._client);

  final Dio _client;

  @override
  Future<(BasicApiFailure?, ApiResponse?)> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.get(url, queryParameters: queryParameters);
      return _buildNetworkResponseData(response);
    } on DioException catch (e) {
      return _buildNetworkError(e);
    }
  }

  @override
  Future<(BasicApiFailure?, ApiResponse?)> post(String url, Map<String, dynamic> data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.post(url, data: data, queryParameters: queryParameters);
      return _buildNetworkResponseData(response);
    } on DioException catch (e) {
      return _buildNetworkError(e);
    }
  }

  @override
  Future<(BasicApiFailure?, ApiResponse?)> put(String url, Map<String, dynamic> data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.put(url, data: data, queryParameters: queryParameters);
      return _buildNetworkResponseData(response);
    } on DioException catch (e) {
      return _buildNetworkError(e);
    }
  }

  @override
  Future<(BasicApiFailure?, ApiResponse?)> delete(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.delete(url, data: data, queryParameters: queryParameters);
      return _buildNetworkResponseData(response);
    } on DioException catch (e) {
      return _buildNetworkError(e);
    }
  }

  @override
  void addInterceptors(Interceptor interceptor) {
    _client.interceptors.add(interceptor);
  }

  (BasicApiFailure, ApiResponse?) _buildNetworkError(DioException exception) {
    return (
      BasicApiFailure(
          errorMessage: exception.message ?? unexpectedErrorMessage, statusCode: exception.response?.statusCode),
      null
    );
  }

  (BasicApiFailure?, ApiResponse) _buildNetworkResponseData(Response dioResponse) {
    return (null, ApiResponse(statusCode: dioResponse.statusCode, data: dioResponse.data));
  }
}
