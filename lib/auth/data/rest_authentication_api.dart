import 'package:flutter_test_template/auth/data/authentication_api.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/utils/ut_local_store/ut_local_store.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class RestAuthenticationApi implements AuthenticationApi {
  RestAuthenticationApi(
    this._client,
  );

  String? _token;
  LocalStore localStoreInstance = LocalStore.instance;
  late HttpClient _client;

  @override
  Future<bool> login(String userName, String password) async {
    _token = await localStoreInstance.loadToken();

    if (await isTokenExpired()) {
      var response = (await _client.post('/auth/login', {
        'username': userName,
        'password': password,
      }));

      _token = response.data?['token'];
      localStoreInstance.saveToken(_token);
    }

    return true;
  }

  @override
  Future<bool> logout() async {
    _token = null;
    await localStoreInstance.deleteToken();
    return true;
  }

  Future<bool> isLoggedIn() async {
    _token = await localStoreInstance.loadToken();
    return await isTokenExpired();
  }

  @override
  Future<bool> isTokenExpired() async => _token == null || JwtDecoder.isExpired(_token!);

  @override
  Future<bool> refreshToken() async {
    var response = await _client.post('/auth/refresh', {});

    if (response.data == null) {
      return false;
    }

    _token = response.data!['token'];
    await localStoreInstance.saveToken(_token);
    return true;
  }

  @override
  String? getToken() => _token;
}
