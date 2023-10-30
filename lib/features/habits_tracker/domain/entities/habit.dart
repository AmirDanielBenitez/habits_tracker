import 'dart:ui';

import 'package:equatable/equatable.dart';

class HabitEntity extends Equatable {
  final int? id;
  final bool done;
  final String name;
  final int streak;
  final Color color;
  final List<Map<String, bool>>? checkList;
  final DayTimeHabit dayTime;
  final List<String>? specificDays;

  const HabitEntity({
    this.id,
    required this.done,
    required this.name,
    required this.streak,
    required this.color,
    this.checkList,
    this.dayTime = DayTimeHabit.anytime,
    this.specificDays,
  });

  @override
  List<Object?> get props {
    return [
      id,
      done,
      name,
      streak,
    ];
  }
}

enum DayTimeHabit {
  anytime,
  morning,
  afternoon,
  evening,
}
