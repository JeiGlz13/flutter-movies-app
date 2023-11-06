import 'package:movies_app/app/data/services/local/session_service.dart';
import 'package:movies_app/app/data/services/remote/account_service.dart';
import 'package:movies_app/app/domain/models/user.dart';
import 'package:movies_app/app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountService _accountService;
  final SessionService _sessionService;

  AccountRepositoryImpl(this._accountService, this._sessionService);

  @override
  Future<User?> getUserData() async {
    final sessionId = await _sessionService.sessionId;
    return await _accountService.getAccount(sessionId ?? '');
  }
}