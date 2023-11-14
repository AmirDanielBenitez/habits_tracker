part of 'habits_bloc.dart';

sealed class HabitsState extends Equatable {
  const HabitsState();

  @override
  List<Object> get props => [];
}

final class HabitsLoading extends HabitsState {}

final class HabitsLoaded extends HabitsState {
  final List<HabitEntity> habits;

  const HabitsLoaded(this.habits);
}

final class HabitsNotLoaded extends HabitsState {}
