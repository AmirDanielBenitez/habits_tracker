import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/check_list.dart';

class HabitEntity extends Equatable {
  final int id;
  final bool done;
  final String name;
  final int streak;
  final Color color;
  final List<CheckListEntity>? checkList;
  final DayTimeHabit dayTime;
  final List<String>? specificDays;
  final DateTime lastEdited;

  const HabitEntity({
    required this.id,
    required this.done,
    required this.name,
    required this.streak,
    required this.color,
    required this.lastEdited,
    this.checkList,
    this.dayTime = DayTimeHabit.anytime,
    this.specificDays,
  });

  @override
  List<Object?> get props {
    return [id, done, name, streak, lastEdited];
  }

  HabitEntity copyWith({
    int? id,
    bool? done,
    String? name,
    int? streak,
    Color? color,
    List<CheckListEntity>? checkList,
    DayTimeHabit? dayTime,
    List<String>? specificDays,
    DateTime? lastEdited,
  }) {
    return HabitEntity(
      id: id ?? this.id,
      done: done ?? this.done,
      name: name ?? this.name,
      streak: streak ?? this.streak,
      color: color ?? this.color,
      checkList: checkList ?? this.checkList,
      dayTime: dayTime ?? this.dayTime,
      specificDays: specificDays ?? this.specificDays,
      lastEdited: lastEdited ?? this.lastEdited,
    );
  }
}

enum DayTimeHabit {
  anytime,
  morning,
  afternoon,
  evening,
}

enum DayTimeHabitHome {
  all,
  anytime,
  morning,
  afternoon,
  evening,
}
