import 'package:get_it/get_it.dart';
import 'package:habits_tracker/features/habits_tracker/data/repository/habit_repository_impl.dart';
import 'package:habits_tracker/features/habits_tracker/domain/repository/habit_repository.dart';
import 'package:habits_tracker/features/habits_tracker/domain/usecases/habit_usecase.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/bloc/habits_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies
  sl.registerSingleton<HabitRepository>(HabitRepositoryImpl());

  // UseCases
  sl.registerSingleton<HabitUseCase>(HabitUseCase(sl()));

  // Blocs
  sl.registerFactory<HabitsBloc>(() => HabitsBloc(sl()));
}
