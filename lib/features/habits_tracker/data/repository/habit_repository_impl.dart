import 'package:flutter/material.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/domain/repository/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl();

  @override
  Future<List<HabitEntity>> getSavedHabits() {
    return Future.value([
      const HabitEntity(
          id: 1, name: 'Pray', done: false, color: Colors.red, streak: 5),
    ]);
  }

  @override
  Future<bool> createHabit(HabitEntity habit) {
    return Future.value(true);
  }

  @override
  Future<List<HabitEntity>> editHabit(HabitEntity habit) {
    return Future.value([
      const HabitEntity(
          id: 1, name: 'Pray edit', done: false, color: Colors.red, streak: 5),
    ]);
  }

  @override
  Future<List<HabitEntity>> deleteHabit(int habitCode) {
    return Future.value([
      const HabitEntity(
          id: 1, name: 'Pray', done: false, color: Colors.red, streak: 5),
    ]);
  }
}
