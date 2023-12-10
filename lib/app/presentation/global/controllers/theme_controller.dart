import 'package:flutter/foundation.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode;

  ThemeController(this._isDarkMode);

  bool get isDarkMode => _isDarkMode;

  void onChange(bool darkMode) {
    _isDarkMode = darkMode;
    notifyListeners();
  }
}