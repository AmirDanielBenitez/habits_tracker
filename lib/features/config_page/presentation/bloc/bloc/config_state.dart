part of 'config_bloc.dart';

sealed class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object> get props => [];
}

final class ConfigInitial extends ConfigState {}

final class ConfigLoading extends ConfigState {}

final class ConfigLoaded extends ConfigState {
  final ConfigItem config;
  const ConfigLoaded(this.config);
}
