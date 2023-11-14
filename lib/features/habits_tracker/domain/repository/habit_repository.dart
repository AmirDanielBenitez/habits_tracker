import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';

abstract class HabitRepository {
  // API methods

  // Database methods
  Future<List<HabitEntity>> getSavedHabits();

  Future<bool> createHabit(HabitEntity habit);

  Future<List<HabitEntity>> editHabit(HabitEntity habit);

  Future<List<HabitEntity>> deleteHabit(int habitCode);
}
