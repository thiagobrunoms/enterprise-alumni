import '../../common/api/http_client.dart';

abstract class SetupAuthentication {
  Future<(BasicApiFailure?, bool)> setup();
}
