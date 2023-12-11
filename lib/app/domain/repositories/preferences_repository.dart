abstract class PreferencesRepository {
  bool? get isDarkMode;
  Future<void> setDarkMode(bool isDarkMode);
}