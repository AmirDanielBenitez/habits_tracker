import 'dart:ui';

import 'package:habits_tracker/features/habits_tracker/domain/entities/checkList.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';

class HabitModel extends HabitEntity {
  const HabitModel({
    final int? id,
    final bool? done,
    required String name,
    final int? streak,
    required Color color,
    final List<CheckListEntity>? checkList,
    final DayTimeHabit dayTime = DayTimeHabit.anytime,
    final List<String>? specificDays,
  }) : super(
          id: id,
          done: done ?? false,
          name: name,
          streak: streak ?? 0,
          color: color,
          checkList: checkList,
          dayTime: dayTime,
          specificDays: specificDays,
        );

  factory HabitModel.fromJson(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      done: map['done'],
      name: map['name'],
      streak: map['streak'],
      color: map['color'],
      checkList: map['check_list'],
      specificDays: map['specific_days'],
    );
  }

  factory HabitModel.fromEntity(HabitEntity entity) {
    return HabitModel(
      id: entity.id,
      done: entity.done,
      name: entity.name,
      streak: entity.streak,
      color: entity.color,
      checkList: entity.checkList,
      dayTime: entity.dayTime,
      specificDays: entity.specificDays,
    );
  }
}
