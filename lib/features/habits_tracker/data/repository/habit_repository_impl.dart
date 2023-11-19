import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:habits_tracker/core/database.dart';
import 'package:habits_tracker/features/habits_tracker/data/models/checklist_model.dart';
import 'package:habits_tracker/features/habits_tracker/data/models/habit_model.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/domain/repository/habit_repository.dart';
import 'package:habits_tracker/injection_container.dart';

class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl();

  @override
  Future<List<HabitEntity>> getSavedHabits() async {
    List<HabitItem> allHabitItems =
        await sl<AppDatabase>().select(sl<AppDatabase>().habitItems).get();
    return allHabitItems.map((habit) => HabitModel.fromItem(habit)).toList();
  }

  @override
  Future<bool> checkStreak() async {
    try {
      List<HabitItem> allHabitItems =
          await sl<AppDatabase>().select(sl<AppDatabase>().habitItems).get();

      final now = DateTime.now();
      final yesterday = DateTime(now.year, now.month, now.day - 1);

      for (HabitItem habit in allHabitItems) {
        if (habit.lastEdited.year < now.year ||
            habit.lastEdited.month < now.month ||
            habit.lastEdited.day < now.day) {
          if (habit.done && !habit.lastEdited.isBefore(yesterday)) {
            sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
              ..where((tbl) => tbl.id.equals(habit.id))
              ..write(
                HabitItemsCompanion(
                  done: const Value(false),
                  lastEdited: Value(DateTime.now()),
                ),
              );
          } else {
            sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
              ..where((tbl) => tbl.id.equals(habit.id))
              ..write(
                HabitItemsCompanion(
                  done: const Value(false),
                  streak: const Value(0),
                  lastEdited: Value(DateTime.now()),
                ),
              );
          }
        }
      }

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> createHabit(HabitEntity habit) async {
    try {
      HabitItem? habitCreated = await sl<AppDatabase>()
          .into(sl<AppDatabase>().habitItems)
          .insertReturningOrNull(HabitItemsCompanion.insert(
            name: habit.name,
            color: habit.color.value,
            checkList: Value(habit.checkList?.isNotEmpty ?? false
                ? habit.checkList!
                    .map((e) => CheckListModel.fromEntity(e))
                    .toList()
                : null),
            dayTime: Value(habit.dayTime),
            specificDays: Value(json.encode(habit.specificDays)),
          ));
      if (habitCreated != null) {
        return Future.value(true);
      }
      return Future.value(false);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> editHabit(HabitEntity habit) async {
    try {
      await sl<AppDatabase>()
          .update(sl<AppDatabase>().habitItems)
          .replace(HabitItemsCompanion(
            id: Value(habit.id),
            name: Value(habit.name),
            color: Value(habit.color.value),
            checkList: Value(habit.checkList?.isNotEmpty ?? false
                ? habit.checkList!
                    .map((e) => CheckListModel.fromEntity(e))
                    .toList()
                : null),
            dayTime: Value(habit.dayTime),
            specificDays: Value(json.encode(habit.specificDays)),
          ));
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteHabit(int habitCode) async {
    try {
      final int deleted =
          await (sl<AppDatabase>().delete(sl<AppDatabase>().habitItems)
                ..where((tbl) => tbl.id.equals(habitCode)))
              .go();

      return Future.value(deleted > 0);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> doneHabit(bool done, int habitCode) async {
    try {
      final habitToUpdate = sl<AppDatabase>()
          .select(sl<AppDatabase>().habitItems)
        ..where((tbl) => tbl.id.equals(habitCode));

      final HabitItem habitItem = await habitToUpdate.getSingle();

      sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
        ..where((tbl) => tbl.id.equals(habitCode))
        ..write(
          HabitItemsCompanion(
            done: Value(done),
            streak: Value(done
                ? (habitItem.streak + 1)
                : habitItem.streak > 0
                    ? (habitItem.streak - 1)
                    : 0),
            lastEdited: Value(DateTime.now()),
          ),
        );

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}