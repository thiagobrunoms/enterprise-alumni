import 'package:dio/dio.dart';
import 'package:flutter_test_template/auth/data/authentication_api.dart';
import 'package:flutter_test_template/auth/data/rest_authentication_api.dart';
import 'package:flutter_test_template/common/api/dio_http_client.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/products/data/products_api.dart';
import 'package:flutter_test_template/products/data/rest_products_api.dart';
import 'package:flutter_test_template/profile/data/profile_api.dart';
import 'package:flutter_test_template/profile/data/rest_profile_api.dart';

class Api {
  Api._() {
    _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
    _client = DioHttpClient(_dio);
  }

  late AuthenticationApi authentication;
  late ProductsApi products;
  late ProfileApi profile;
  late Dio _dio;
  late HttpClient _client;

  Future<void> setup() async {
    products = RestProductsApi(_client);
    authentication = RestAuthenticationApi(_client);
    profile = RestProfileApi(_client);

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
