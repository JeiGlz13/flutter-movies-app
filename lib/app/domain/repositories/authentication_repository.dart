import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/sign_in/sign_in_failure.dart';
import 'package:movies_app/app/domain/models/user/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  );
  Future<void> signOut();
}
