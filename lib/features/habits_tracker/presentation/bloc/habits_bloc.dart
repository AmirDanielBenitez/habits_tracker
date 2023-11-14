import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/domain/usecases/habit_usecase.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final HabitUseCase _habitUseCase;

  HabitsBloc(this._habitUseCase) : super(HabitsLoading()) {
    on<LoadHabitsEvent>(_onLoadHabitsEvent);
    on<CreateHabitEvent>(_onCreateHabitEvent);
    on<EditHabitEvent>(_onEditHabitEvent);
    on<DeleteHabitEvent>(_onDeleteHabitEvent);
  }

  Future<void> _onLoadHabitsEvent(
      LoadHabitsEvent event, Emitter<HabitsState> emit) async {
    emit(HabitsLoading());

    final List<HabitEntity> habits = await _habitUseCase();

    emit(HabitsLoaded(habits));
  }

  Future<void> _onCreateHabitEvent(
      CreateHabitEvent event, Emitter<HabitsState> emit) async {
    try {
      List<HabitEntity> habits = [];
      if (state is HabitsLoaded) {
        habits = (state as HabitsLoaded).habits;
      }
      emit(HabitsLoading());

      final bool created = await _habitUseCase.create(habit: event.habit);

      if (created) {
        habits.add(event.habit);

        emit(HabitsLoaded(habits));
      } else {
        //#TODO
        // agregar alerta de no creado
      }
    } catch (e) {
      print(e);
      //#TODO
      // agregar alerta de no creado
    }
  }

  Future<void> _onEditHabitEvent(
      EditHabitEvent event, Emitter<HabitsState> emit) async {
    try {
      emit(HabitsLoading());

      final List<HabitEntity> habits =
          await _habitUseCase.edit(habit: event.habit);

      emit(HabitsLoaded(habits));
    } catch (e) {
      print(e);
      //#TODO
      // agregar alerta de no editado
    }
  }

  Future<void> _onDeleteHabitEvent(
      DeleteHabitEvent event, Emitter<HabitsState> emit) async {
    try {
      emit(HabitsLoading());

      final List<HabitEntity> habits =
          await _habitUseCase.delete(habitCode: event.habitCode);

      emit(HabitsLoaded(habits));
    } catch (e) {
      print(e);
      //#TODO
      // agregar alerta de no eliminado
    }
  }
}
