import 'package:habits_tracker/core/database.dart';
import 'package:habits_tracker/core/usecase/usecase.dart';
import 'package:habits_tracker/features/config_page/domain/repository/config_repository.dart';

class ConfigUseCase implements UseCase<void, void> {
  final ConfigRepository _configRepository;

  ConfigUseCase(this._configRepository);

  @override
  Future<ConfigItem> call({void params}) {
    return _configRepository.getConfig();
  }

  Future<String?> getLocale() {
    return _configRepository.getLocale();
  }

  Future<bool> setLocale(String locale) {
    return _configRepository.setLocale(locale);
  }
}
