part of 'habits_bloc.dart';

sealed class HabitsEvent extends Equatable {
  const HabitsEvent();

  @override
  List<Object> get props => [];
}

class LoadHabitsEvent extends HabitsEvent {}

class CreateHabitEvent extends HabitsEvent {
  final HabitEntity habit;
  const CreateHabitEvent(this.habit);
}

class EditHabitEvent extends HabitsEvent {
  final HabitEntity habit;
  const EditHabitEvent(this.habit);
}

class DeleteHabitEvent extends HabitsEvent {
  final int habitCode;
  const DeleteHabitEvent(this.habitCode);
}
