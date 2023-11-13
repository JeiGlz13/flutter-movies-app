import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/domain/models/user/user.dart';

class AccountService {
  final Http _http;

  AccountService(this._http);

  Future<User?> getAccount(String sessionId) async{
    final result = await _http.request(
      '/account/1',
      queryParameters: {
        'session_id': sessionId
      },
      onSuccess: (json) {
        return User.fromJson(json);
      },
    );

    return result.when(
      error: (_) => null,
      success: (user) => user,
    );
  }
}