import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:habits_tracker/core/database.dart';
import 'package:habits_tracker/core/resources/helper.dart';
import 'package:habits_tracker/features/habits_tracker/data/models/checklist_model.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/domain/usecases/habit_usecase.dart';
import 'package:habits_tracker/injection_container.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final HabitUseCase _habitUseCase;

  HabitsBloc(this._habitUseCase) : super(HabitsLoading()) {
    on<LoadHabitsEvent>(_onLoadHabitsEvent);
    on<CreateHabitEvent>(_onCreateHabitEvent);
    on<EditHabitEvent>(_onEditHabitEvent);
    on<DeleteHabitEvent>(_onDeleteHabitEvent);
    on<DoneHabitEvent>(_onDoneHabitEvent);
    on<ChecklistDoneHabitEvent>(_onChecklistDoneHabitEvent);
  }

  Future<void> _onLoadHabitsEvent(
      LoadHabitsEvent event, Emitter<HabitsState> emit) async {
    emit(HabitsLoading());

    await _habitUseCase.checkStreak();

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
        await FirebaseAnalytics.instance.logEvent(
            name: 'habit_created', parameters: {'name': event.habit.name});

        final List<HabitEntity> habitsUpdated = await _habitUseCase();
        emit(HabitsLoaded(habitsUpdated));

        showToast(sl<ConfigItem>().locale == 'es'
            ? 'Habito creado'
            : 'Habit created');
      } else {
        emit(HabitsLoaded(habits));
        showToast(
            sl<ConfigItem>().locale == 'es'
                ? 'Habito no creado'
                : 'Habit not created',
            error: true);
      }
    } catch (e) {
      print(e);
      showToast(
          sl<ConfigItem>().locale == 'es'
              ? 'Habito no creado'
              : 'Habit not created',
          error: true);
    }
  }

  Future<void> _onEditHabitEvent(
      EditHabitEvent event, Emitter<HabitsState> emit) async {
    try {
      List<HabitEntity> habits = [];
      if (state is HabitsLoaded) {
        habits = (state as HabitsLoaded).habits;
      }
      emit(HabitsLoading());

      final bool edited = await _habitUseCase.edit(habit: event.habit);
      if (edited) {
        await FirebaseAnalytics.instance.logEvent(name: 'habit_edited');

        final List<HabitEntity> habitsUpdated = await _habitUseCase();
        emit(HabitsLoaded(habitsUpdated));
        showToast(sl<ConfigItem>().locale == 'es'
            ? 'Habito editado'
            : 'Habit edited');
      } else {
        emit(HabitsLoaded(habits));
        showToast(
            sl<ConfigItem>().locale == 'es'
                ? 'Habito no editado'
                : 'Habit not edited',
            error: true);
      }
    } catch (e) {
      print(e);
      showToast(
          sl<ConfigItem>().locale == 'es'
              ? 'Habito no editado'
              : 'Habit not edited',
          error: true);
    }
  }

  Future<void> _onDeleteHabitEvent(
      DeleteHabitEvent event, Emitter<HabitsState> emit) async {
    try {
      List<HabitEntity> habits = [];
      if (state is HabitsLoaded) {
        habits = (state as HabitsLoaded).habits;
      }
      emit(HabitsLoading());

      final bool deleted =
          await _habitUseCase.delete(habitCode: event.habitCode);

      if (deleted) {
        await FirebaseAnalytics.instance.logEvent(name: 'habit_deleted');

        final List<HabitEntity> habitsUpdated = await _habitUseCase();
        emit(HabitsLoaded(habitsUpdated));
        showToast(sl<ConfigItem>().locale == 'es'
            ? 'Habito borrado'
            : 'Habit deleted');
      } else {
        emit(HabitsLoaded(habits));
        showToast(
            sl<ConfigItem>().locale == 'es'
                ? 'Habito no borrado'
                : 'Habit not deleted',
            error: true);
      }
      emit(HabitsLoaded(habits));
    } catch (e) {
      print(e);
      showToast(
          sl<ConfigItem>().locale == 'es'
              ? 'Habito no borrado'
              : 'Habit not deleted',
          error: true);
    }
  }

  Future<void> _onDoneHabitEvent(
      DoneHabitEvent event, Emitter<HabitsState> emit) async {
    try {
      List<HabitEntity> habits = [];
      if (state is HabitsLoaded) {
        habits = (state as HabitsLoaded).habits;
      }
      emit(HabitsLoading());

      final bool done =
          await _habitUseCase.done(event.done, habitCode: event.habitCode);

      if (done) {
        await FirebaseAnalytics.instance.logEvent(name: 'habit_done');

        final List<HabitEntity> habitsUpdated = await _habitUseCase();
        emit(HabitsLoaded(habitsUpdated));
        sl<ConfigItem>().locale == 'es' ? 'Habito hecho' : 'Habit done';
      } else {
        emit(HabitsLoaded(habits));
        showToast(
            sl<ConfigItem>().locale == 'es'
                ? 'Habito no hecho'
                : 'Habit not done',
            error: true);
      }
    } catch (e) {
      print(e);
      showToast(
          sl<ConfigItem>().locale == 'es'
              ? 'Habito no hecho'
              : 'Habit not done',
          error: true);
    }
  }

  Future<void> _onChecklistDoneHabitEvent(
      ChecklistDoneHabitEvent event, Emitter<HabitsState> emit) async {
    try {
      List<HabitEntity> habits = [];
      if (state is HabitsLoaded) {
        habits = (state as HabitsLoaded).habits;
      }
      emit(HabitsLoading());

      final bool done = await _habitUseCase.checkListDone(event.checkList,
          habitCode: event.habitCode);
      if (done) {
        final List<HabitEntity> habitsUpdated = await _habitUseCase();
        emit(HabitsLoaded(habitsUpdated));
        // showToast('Habit checklist item done');
      } else {
        emit(HabitsLoaded(habits));
        showToast(
            sl<ConfigItem>().locale == 'es'
                ? 'Habito tarea no hecho'
                : 'Habit checklist item not done',
            error: true);
      }
    } catch (e) {
      print(e);
      showToast(
          sl<ConfigItem>().locale == 'es'
              ? 'Habito tarea no hecho'
              : 'Habit checklist item not done',
          error: true);
    }
  }
}
