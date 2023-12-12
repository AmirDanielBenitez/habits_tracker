import 'package:drift/drift.dart';
import 'package:habits_tracker/core/database.dart';
import 'package:habits_tracker/features/config_page/domain/repository/config_repository.dart';
import 'package:habits_tracker/injection_container.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  ConfigRepositoryImpl();

  @override
  Future<ConfigItem> getConfig() async {
    ConfigItem? config = await sl<AppDatabase>()
        .select(sl<AppDatabase>().configItems)
        .getSingleOrNull();

    if (config == null) {
      await sl<AppDatabase>().into(sl<AppDatabase>().configItems).insert(
            const ConfigItemsCompanion(
              id: Value(1),
            ),
          );
    }
    return config ?? const ConfigItem(id: 1);
  }

  @override
  Future<String?> getLocale() async {
    ConfigItem locale = await sl<AppDatabase>()
        .select(sl<AppDatabase>().configItems)
        .getSingle();
    return locale.locale;
  }

  @override
  Future<bool> setLocale(String locale) async {
    try {
      sl<AppDatabase>().update(sl<AppDatabase>().configItems)
        ..where((tbl) => tbl.id.equals(1))
        ..write(
          ConfigItemsCompanion(
            locale: Value(locale),
          ),
        );
      return true;
    } catch (e) {
      return false;
    }
  }
}
