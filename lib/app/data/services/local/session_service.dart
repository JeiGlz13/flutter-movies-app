import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class SessionService {
  final FlutterSecureStorage _flutterSecureStorage;

  SessionService(this._flutterSecureStorage);

  Future<String?> get sessionId async {
    final sessionId = await _flutterSecureStorage.read(key: _key);
    return sessionId;
  }

  Future<void> saveSessionId(String sessionId) {
    return _flutterSecureStorage.write(key: _key, value: sessionId);
  }

  Future<void> deleteSessionId() {
    return _flutterSecureStorage.delete(key: _key);
  }
}