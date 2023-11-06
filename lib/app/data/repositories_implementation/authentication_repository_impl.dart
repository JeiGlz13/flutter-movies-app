import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movies_app/app/data/services/local/session_service.dart';
import 'package:movies_app/app/data/services/remote/account_service.dart';
import 'package:movies_app/app/data/services/remote/authentication_service.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/sign_in_fail.dart';
import 'package:movies_app/app/domain/models/user.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';



class AuthenticationRepositoryImpl implements AuthenticationRepository {

  final AuthenticationService _authenticationService;
  final SessionService _sessionService;
  final AccountService _accountService;

  AuthenticationRepositoryImpl(this._authenticationService, this._sessionService, this._accountService);

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _sessionService.sessionId;
    return sessionId != null;
  }

  @override
  Future<Either<SignInFail, User>> signIn(
    String username,
    String password,
  ) async {
    final requestTokenResult = await _authenticationService.createRequestToken();

    return requestTokenResult.when(
      (failure) => Either.left(failure),
      (requestToken) async {
        final loginResult = await _authenticationService.createSessionWithLogin(
          userName: username,
          password: password,
          requestToken: requestToken ?? ''
        );

        return loginResult.when(
          (failure) async {
            return Either.left(failure);
          },
          (newRequestToken) async {
            final sessionResponse = await _authenticationService.createSession(newRequestToken);
            
            return sessionResponse.when(
              (sessionFail) async {
                return Either.left(sessionFail);
              },
              (sessionId) async {
                await _sessionService.saveSessionId(sessionId);
                final user = await _accountService.getAccount(sessionId);

                if (user == null) {
                  return Either.left(SignInFail.unknown);
                }

                return Either.right(user);
              }
            );
          },
        );
      },
    );
  }
  
  @override
  Future<void> signOut() async {
    return await _sessionService.deleteSessionId();
  }

}