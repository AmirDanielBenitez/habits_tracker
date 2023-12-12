part of 'config_bloc.dart';

sealed class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

class LoadConfigEvent extends ConfigEvent {}

class SetLocaleEvent extends ConfigEvent {
  final String locale;
  const SetLocaleEvent(this.locale);
}
