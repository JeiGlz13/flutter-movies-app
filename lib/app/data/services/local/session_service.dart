import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';
const _accountKey = 'accountKey';

class SessionService {
  final FlutterSecureStorage _flutterSecureStorage;

  SessionService(this._flutterSecureStorage);

  Future<String?> get sessionId => _flutterSecureStorage.read(key: _key);

  Future<String?> get accountId => _flutterSecureStorage.read(key: _accountKey);

  Future<void> saveSessionId(String sessionId) {
    return _flutterSecureStorage.write(key: _key, value: sessionId);
  }

  Future<void> saveAccountId(String accountId) {
    return _flutterSecureStorage.write(key: _accountKey, value: accountId);
  }

  Future<void> deleteStorageKey(String key) {
    return _flutterSecureStorage.delete(key: key);
  }

  Future<void> signOut() async {
    return _flutterSecureStorage.deleteAll();
  }
}