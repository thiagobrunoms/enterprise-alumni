import 'package:dio/dio.dart';

import 'http_client.dart';

class DioHttpClient extends HttpClient<BasicApiFailure, ApiResponse, Interceptor> {
  DioHttpClient._() {
    _client = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
  }

  static DioHttpClient get getInstance {
    return _instance;
  }

  late Dio _client;
  static final DioHttpClient _instance = DioHttpClient._();

  @override
  Future<(BasicApiFailure?, ApiResponse?)> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.get(url, queryParameters: queryParameters);
      return (null, ApiResponse(statusCode: response.statusCode, data: response.data));
    } on DioException catch (e) {
      return _buildNetworkError(e);
    }
  }

  @override
  Future<(BasicApiFailure?, ApiResponse?)> post(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.post(url, data: data, queryParameters: queryParameters);
      return (null, ApiResponse(statusCode: response.statusCode, data: response.data));
    } on DioException catch (e) {
      return _buildNetworkError(e);
    }
  }

  @override
  Future<(BasicApiFailure?, ApiResponse?)> put(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.put(url, data: data, queryParameters: queryParameters);
      return (null, ApiResponse(statusCode: response.statusCode, data: response.data));
    } on DioException catch (e) {
      return _buildNetworkError(e);
    }
  }

  @override
  Future<(BasicApiFailure?, ApiResponse?)> delete(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _client.delete(url, queryParameters: queryParameters);
      return (null, ApiResponse(statusCode: response.statusCode, data: response.data));
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
