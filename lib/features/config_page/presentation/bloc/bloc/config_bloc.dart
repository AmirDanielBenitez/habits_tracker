import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habits_tracker/core/database.dart';
import 'package:habits_tracker/features/config_page/domain/usecases/config_usecase.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigUseCase _configUseCase;

  ConfigBloc(this._configUseCase) : super(ConfigInitial()) {
    on<LoadConfigEvent>(_onLoadHabitsEvent);
    on<SetLocaleEvent>(_onSetLocaleEvent);
  }

  Future<void> _onLoadHabitsEvent(
      LoadConfigEvent event, Emitter<ConfigState> emit) async {
    emit(ConfigLoading());

    final ConfigItem configItem = await _configUseCase.call();

    emit(ConfigLoaded(configItem));
  }

  Future<void> _onSetLocaleEvent(
      SetLocaleEvent event, Emitter<ConfigState> emit) async {
    emit(ConfigLoading());

    await _configUseCase.setLocale(event.locale);

    final ConfigItem configItem = await _configUseCase.call();

    emit(ConfigLoaded(configItem));
  }
}
