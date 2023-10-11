import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';

class HabitModel extends HabitEntity {
  const HabitModel({
    int? id,
    bool? done,
    String? name,
    int? streak,
  }) : super(
          id: id,
          done: done,
          name: name,
          streak: streak,
        );

  factory HabitModel.fromJson(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      done: map['done'],
      name: map['name'],
      streak: map['streak'],
    );
  }

  factory HabitModel.fromEntity(HabitEntity entity) {
    return HabitModel(
      id: entity.id,
      done: entity.done,
      name: entity.name,
      streak: entity.streak,
    );
  }
}
