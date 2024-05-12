import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/profile/data/models/profile.dart';
import 'package:flutter_test_template/profile/data/profile_api.dart';

class RestProfileApi implements ProfileApi {
  RestProfileApi(
    this._client,
  );

  late HttpClient _client;

  @override
  Future<Profile> getProfile() async {
    var response = await _client.get('/auth/me');

    return Profile.fromJson(response.data);
  }
}
