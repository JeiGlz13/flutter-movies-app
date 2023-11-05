import 'package:flutter/foundation.dart';

class SignInController extends ChangeNotifier {
  String _username = '', _password = '';
  bool _isLoading = false;

  String get userName => _username;
  String get password => _password;
  bool get isLoading => _isLoading;

  void onUsernameChanged(String text) {
    _username = text.trim().toLowerCase();
  }

  void onPasswordChanged(String text) {
    _password = text.trim();
  }

  void onLoadingChanged(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}