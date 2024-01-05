import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/database.dart';
import 'package:habits_tracker/core/resources/helper.dart';
import 'package:habits_tracker/features/habits_tracker/data/models/checklist_model.dart';
import 'package:habits_tracker/features/habits_tracker/data/models/habit_model.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/domain/repository/habit_repository.dart';
import 'package:habits_tracker/injection_container.dart';
import 'package:collection/collection.dart';

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

      final DateTime now = DateTime.now();
      final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

      for (HabitItem habit in allHabitItems) {
        if (habit.lastDone != null) {
          if (habit.lastDone!.year < now.year ||
              habit.lastDone!.month < now.month ||
              habit.lastDone!.day < now.day) {
            if (!habit.lastDone!.isBefore(yesterday)) {
              sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
                ..where((tbl) => tbl.id.equals(habit.id))
                ..write(
                  HabitItemsCompanion(
                    done: const Value(false),
                    checkList: Value(habit.checkList?.isNotEmpty ?? false
                        ? habit.checkList!.map((item) {
                            return CheckListModel(name: item.name, done: false);
                          }).toList()
                        : null),
                  ),
                );
            } else {
              if (habit.specificDays == null || habit.specificDays == 'null') {
                sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
                  ..where((tbl) => tbl.id.equals(habit.id))
                  ..write(
                    HabitItemsCompanion(
                      done: const Value(false),
                      checkList: Value(habit.checkList?.isNotEmpty ?? false
                          ? habit.checkList!.map((item) {
                              return CheckListModel(
                                  name: item.name, done: false);
                            }).toList()
                          : null),
                      streak: const Value(0),
                    ),
                  );
              } else {
                DateTime lastDone = habit.lastDone!;
                final int differenceDays = now.difference(lastDone).inDays;
                if (differenceDays > 7) {
                  sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
                    ..where((tbl) => tbl.id.equals(habit.id))
                    ..write(
                      HabitItemsCompanion(
                        done: const Value(false),
                        checkList: Value(habit.checkList?.isNotEmpty ?? false
                            ? habit.checkList!.map((item) {
                                return CheckListModel(
                                    name: item.name, done: false);
                              }).toList()
                            : null),
                        streak: const Value(0),
                      ),
                    );
                } else {
                  bool loseStreak = false;
                  List<int> daysSequence =
                      getDaysSequence(lastDone.weekday, differenceDays - 1);
                  for (int day in daysSequence) {
                    if (List<String>.from(json.decode(habit.specificDays!))
                        .contains(kDaysInWeek[(day - 1) as int].dayKey)) {
                      loseStreak = true;
                      break;
                    }
                  }

                  if (loseStreak) {
                    sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
                      ..where((tbl) => tbl.id.equals(habit.id))
                      ..write(
                        HabitItemsCompanion(
                          done: const Value(false),
                          checkList: Value(habit.checkList?.isNotEmpty ?? false
                              ? habit.checkList!.map((item) {
                                  return CheckListModel(
                                      name: item.name, done: false);
                                }).toList()
                              : null),
                          streak: const Value(0),
                        ),
                      );
                  } else {
                    sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
                      ..where((tbl) => tbl.id.equals(habit.id))
                      ..write(
                        HabitItemsCompanion(
                          done: const Value(false),
                          checkList: Value(habit.checkList?.isNotEmpty ?? false
                              ? habit.checkList!.map((item) {
                                  return CheckListModel(
                                      name: item.name, done: false);
                                }).toList()
                              : null),
                        ),
                      );
                  }
                }
              }
            }
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
            streak: Value(habit.streak),
            done: Value(habit.done),
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
            checkList: Value((habitItem.checkList
                ?.map((item) => CheckListModel(name: item.name, done: done))
                .toList())),
            lastDone: Value(DateTime.now()),
          ),
        );

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> checkListDone(
      List<CheckListModel> checkList, int habitCode) async {
    try {
      final habitToUpdate = sl<AppDatabase>()
          .select(sl<AppDatabase>().habitItems)
        ..where((tbl) => tbl.id.equals(habitCode));

      final HabitItem habitItem = await habitToUpdate.getSingle();

      final bool done =
          (checkList.firstWhereOrNull((element) => element.done == false) ==
              null);

      sl<AppDatabase>().update(sl<AppDatabase>().habitItems)
        ..where((tbl) => tbl.id.equals(habitCode))
        ..write(
          HabitItemsCompanion(
            done: Value(done),
            streak: Value(done
                ? (habitItem.streak + 1)
                : habitItem.done && !done
                    ? (habitItem.streak - 1)
                    : habitItem.streak),
            checkList: Value(
              checkList,
            ),
            lastDone: Value(DateTime.now()),
          ),
        );

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
