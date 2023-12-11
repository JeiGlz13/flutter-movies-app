import 'package:flutter/foundation.dart';
import 'package:movies_app/app/domain/repositories/preferences_repository.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode;
  final PreferencesRepository preferencesRepository;

  ThemeController(
    this._isDarkMode,
    { required this.preferencesRepository }
  );

  bool get isDarkMode => _isDarkMode;

  void onChange(bool darkMode) {
    _isDarkMode = darkMode;
    preferencesRepository.setDarkMode(darkMode);
    notifyListeners();
  }
}