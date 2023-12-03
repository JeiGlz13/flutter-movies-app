import 'package:movies_app/app/data/services/local/session_service.dart';
import 'package:movies_app/app/data/services/remote/account_service.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/models/user/user.dart';
import 'package:movies_app/app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountService _accountService;
  final SessionService _sessionService;

  AccountRepositoryImpl(this._accountService, this._sessionService);

  @override
  Future<User?> getUserData() async {
    final sessionId = await _sessionService.sessionId;
    final user = await _accountService.getAccount(sessionId ?? '');

    if (user != null) {
      await _sessionService.saveAccountId(user.id.toString());
    }

    return user
    ;
  }

  @override
  Future<Either<HttpRequestFailure, Map<int, TrendMedia>>> getFavorites(TrendType type) {
    return _accountService.getFavorites(type);
  }
}