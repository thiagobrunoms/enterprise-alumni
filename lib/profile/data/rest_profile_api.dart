import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/profile/data/models/profile.dart';
import 'package:flutter_test_template/profile/data/profile_api.dart';

class RestProfileApi implements ProfileApi {
  RestProfileApi(
    this._client,
  );

  late HttpClient _client;

  @override
  Future<(BasicApiFailure?, Profile?)> getProfile() async {
    var (failure, response) = await _client.get('/auth/me');

    if (failure != null) {
      return (failure, null);
    }

    return (null, Profile.fromJson(response!.data));
  }
}
