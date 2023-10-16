import 'package:movies_app/app/domain/models/user.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<User> getUserData() {
    return Future.value(User());
  }

  @override
  Future<bool> get isSignedIn {
    return Future.value(true);
  }

}