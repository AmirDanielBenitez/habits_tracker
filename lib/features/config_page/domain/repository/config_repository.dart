import 'package:habits_tracker/core/database.dart';

abstract class ConfigRepository {
  // API methods

  // Database methods
  Future<ConfigItem> getConfig();

  Future<String?> getLocale();

  Future<bool> setLocale(String locale);
}
