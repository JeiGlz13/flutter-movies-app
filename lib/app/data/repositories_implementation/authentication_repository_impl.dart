import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/sign_in_fail.dart';
import 'package:movies_app/app/domain/models/user.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';

const _key = 'sessionId';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _flutterSecureStorage;

  AuthenticationRepositoryImpl(this._flutterSecureStorage);
  
  @override
  Future<User?> getUserData() {
    return Future.value(User());
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _flutterSecureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<SignInFail, User>> signIn(
    String username,
    String password,
  ) async {
    if (username != 'test') {
      return Either.left(SignInFail.notFound);
    }

    if (password != '123456') {
      return Either.left(SignInFail.unauthorized);
    }

    await _flutterSecureStorage.write(key: _key, value: 'sessionId');

    return Either.right(User());
  }
  
  @override
  Future<void> signOut() async {
   return _flutterSecureStorage.delete(key: _key);
  }

}