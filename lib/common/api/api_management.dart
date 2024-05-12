import 'package:dio/dio.dart';
import 'package:flutter_test_template/auth/data/authentication_api.dart';
import 'package:flutter_test_template/auth/data/rest_authentication_api.dart';
import 'package:flutter_test_template/common/api/dio_http_client.dart';
import 'package:flutter_test_template/common/api/http_client.dart';

class Api {
  Api._() {
    _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
    _client = DioHttpClient(_dio);
  }

  late AuthenticationApi authentication;
  late Dio _dio;
  late HttpClient _client;

  Future<void> setup() async {
    authentication = RestAuthenticationApi(_client);

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (options.path == '/auth/login') {
        handler.next(options);
        return;
      }
      options.headers['Authorization'] = 'Bearer ${authentication.getToken()}';
      if (await authentication.isTokenExpired()) {
        var (failure, refreshResponse) = await authentication.refreshToken();
        if (failure == null && !refreshResponse) {
          await authentication.logout();
          return;
        }
      }

      handler.next(options);
    }));
  }
}

final api = Api._();
