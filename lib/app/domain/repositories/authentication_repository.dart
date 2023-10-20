import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/sign_in_fail.dart';
import 'package:movies_app/app/domain/models/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
  Future<Either<SignInFail, User>> signIn(
    String username,
    String password,
  );
  Future<void> signOut();
}
