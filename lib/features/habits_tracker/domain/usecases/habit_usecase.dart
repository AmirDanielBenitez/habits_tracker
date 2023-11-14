import 'package:habits_tracker/core/usecase/usecase.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/domain/repository/habit_repository.dart';

class HabitUseCase implements UseCase<List<HabitEntity>, void> {
  final HabitRepository _habitRepository;

  HabitUseCase(this._habitRepository);

  @override
  Future<List<HabitEntity>> call({void params}) {
    return _habitRepository.getSavedHabits();
  }

  Future<bool> create({required HabitEntity habit}) {
    return _habitRepository.createHabit(habit);
  }

  Future<List<HabitEntity>> edit({required HabitEntity habit}) {
    return _habitRepository.editHabit(habit);
  }

  Future<List<HabitEntity>> delete({required int habitCode}) {
    return _habitRepository.deleteHabit(habitCode);
  }
}
