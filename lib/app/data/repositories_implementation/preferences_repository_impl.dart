import 'package:movies_app/app/domain/enums/preferences_enum.dart';
import 'package:movies_app/app/domain/repositories/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final SharedPreferences _sharedPreferences;

  PreferencesRepositoryImpl(this._sharedPreferences);
  
  @override
  bool? get isDarkMode {
    return _sharedPreferences.getBool(PreferencesEnum.isDarkMode.name);
  }
  
  @override
  Future<void> setDarkMode(bool isDarkMode) {
    return _sharedPreferences.setBool(
      PreferencesEnum.isDarkMode.name,
      isDarkMode,
    );
  }

}