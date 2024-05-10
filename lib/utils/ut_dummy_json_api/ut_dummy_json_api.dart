import 'package:dio/dio.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/md_product.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/md_profile.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../products/cm_create_product.dart';

enum UtDummyJsonApiEvents { LOGGED_IN, LOGGED_OUT }

class UtDummyJsonApi {
  String? _token;
  Dio? _client;
  final Map<UtDummyJsonApiEvents, List<void Function()>> _subscribers = {};

  UtDummyJsonApi._();

  Future<bool> setup() async {
    _client = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
    _client!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.path == '/auth/login') {
          handler.next(options);
          return;
        }
        options.headers['Authorization'] = 'Bearer ${token()}';
        if (await _isExpired() && !await _refreshToken()) {
          logout();
          return;
        }

        handler.next(options);
      },
    ));
    return true;
  }

  Future<bool> login(String userName, String password) async {
    var res = (await _client!.post('/auth/login', data: {
      'username': userName,
      'password': password,
    }))
        .data;
    _token = res['token'];
    _emit(UtDummyJsonApiEvents.LOGGED_IN);
    return true;
  }

  Future<bool> logout() async {
    _token = null;
    _emit(UtDummyJsonApiEvents.LOGGED_OUT);
    return true;
  }

  String? token() => _token;

  Future<bool> _isExpired() async {
    try {
      if (_token == null) return true;
      return JwtDecoder.isExpired(_token!);
    } catch (_) {
      return true;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      var res = (await _client?.post('/auth/refresh'))?.data;
      _token = res['token'];
      return _token != null;
    } catch (_) {
      return false;
    }
  }

  void Function() subscribe(
      UtDummyJsonApiEvents event, void Function() action) {
    if (_subscribers[event] == null) {
      _subscribers[event] = [];
    }
    _subscribers[event]?.add(action);
    return () {
      _subscribers[event]?.remove(action);
    };
  }

  void _emit(UtDummyJsonApiEvents event) {
    _subscribers[event]?.forEach((action) {
      action();
    });
  }

  Future<MdProfile> profile() async =>
      MdProfile.fromJson((await _client!.get('/auth/me')).data);

  Future<ProductsList> products() async =>
      ProductsList.fromJson((await _client!.get('/products')).data);

  Future<Product> doCreateProduct(CmCreateProductParams productParams) async {
    var res = (await _client!.post(
      '/products/add',
      data: {
        'title': productParams.title,
        'price': productParams.price,
      },
    ));

    return Product.fromJson(res.data);
  }

  Future<Product> doUpdateProduct(Product product) async {
    var res = (await _client!.put(
      '/products/${product.id}',
      data: product.toJson(),
    ));

    return Product.fromJson(res.data);
  }

  Future<bool> doDeleteProduct(int id) async {
    var res = (await _client!.delete('/products/$id'));
    return res.statusCode == 200;
  }
}

UtDummyJsonApi utJsonDummyApi = UtDummyJsonApi._();
