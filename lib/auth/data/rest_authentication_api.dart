import 'package:flutter_test_template/auth/data/authentication_api.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/common/event.dart';
import 'package:flutter_test_template/utils/ut_local_store/ut_local_store.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum UtDummyJsonAuthApiEvents { LOGGED_IN, LOGGED_OUT }

class RestAuthenticationApi implements AuthenticationApi {
  RestAuthenticationApi(
    this._client,
  );

  String? _token;
  LocalStore localStoreInstance = LocalStore.instance;
  late HttpClient _client;
  final Map<Event, List<void Function()>> _subscribers = {};

  @override
  Future<(BasicApiFailure?, bool)> login(String userName, String password) async {
    _token = await localStoreInstance.loadToken();

    if (await isTokenExpired()) {
      var (failure, response) = (await _client.post('/auth/login', {
        'username': userName,
        'password': password,
      }));

      if (response != null) {
        _token = response.data?['token'];
        localStoreInstance.saveToken(_token);
        return (null, true);
      }

      return (failure, false);
    }

    return (null, true);
    // _emit(UtDummyJsonApiEvents.LOGGED_IN);
  }

  @override
  Future<(BasicApiFailure?, bool)> logout() async {
    _token = null;
    await localStoreInstance.deleteToken();
    // _emit(UtDummyJsonApiEvents.LOGGED_OUT);
    return (null, true);
  }

  Future<bool> isLoggedIn() async {
    _token = await localStoreInstance.loadToken();
    return await isTokenExpired();
  }

  @override
  Future<bool> isTokenExpired() async => _token == null || JwtDecoder.isExpired(_token!);

  @override
  Future<(BasicApiFailure?, bool)> refreshToken() async {
    var (failure, response) = await _client.post('/auth/refresh', {});

    if (response != null) {
      _token = response.data?['token'];
      await localStoreInstance.saveToken(_token);
      return (null, true);
    }

    return (failure, false);
  }

  @override
  String? getToken() => _token;
}
