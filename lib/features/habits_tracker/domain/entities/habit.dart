import 'package:equatable/equatable.dart';

class HabitEntity extends Equatable {
  final int? id;
  final bool? done;
  final String? name;
  final int? streak;

  const HabitEntity({
    this.id,
    this.done,
    this.name,
    this.streak,
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
