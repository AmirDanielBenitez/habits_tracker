import 'package:get_it/get_it.dart';
import 'package:habits_tracker/core/database.dart';
import 'package:habits_tracker/features/config_page/data/repository/config_repository_impl.dart';
import 'package:habits_tracker/features/config_page/domain/repository/config_repository.dart';
import 'package:habits_tracker/features/config_page/domain/usecases/config_usecase.dart';
import 'package:habits_tracker/features/config_page/presentation/bloc/bloc/config_bloc.dart';
import 'package:habits_tracker/features/habits_tracker/data/repository/habit_repository_impl.dart';
import 'package:habits_tracker/features/habits_tracker/domain/repository/habit_repository.dart';
import 'package:habits_tracker/features/habits_tracker/domain/usecases/habit_usecase.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/bloc/habits_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Version
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  sl.registerSingleton<PackageInfo>(packageInfo);

  // Database
  final database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);

  // Dependencies
  sl.registerSingleton<HabitRepository>(HabitRepositoryImpl());
  sl.registerSingleton<ConfigRepository>(ConfigRepositoryImpl());

  // UseCases
  sl.registerSingleton<HabitUseCase>(HabitUseCase(sl()));
  sl.registerSingleton<ConfigUseCase>(ConfigUseCase(sl()));

  // Blocs
  sl.registerFactory<HabitsBloc>(() => HabitsBloc(sl()));
  sl.registerFactory<ConfigBloc>(() => ConfigBloc(sl()));

  // Config
  ConfigItem configItem = await ConfigUseCase(sl()).call();
  sl.registerSingleton<ConfigItem>(configItem);
}
