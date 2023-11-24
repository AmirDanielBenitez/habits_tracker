import 'package:habits_tracker/core/usecase/usecase.dart';
import 'package:habits_tracker/features/habits_tracker/data/models/checklist_model.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/domain/repository/habit_repository.dart';

class HabitUseCase implements UseCase<List<HabitEntity>, void> {
  final HabitRepository _habitRepository;

  HabitUseCase(this._habitRepository);

  @override
  Future<List<HabitEntity>> call({void params}) {
    return _habitRepository.getSavedHabits();
  }

  Future<bool> checkStreak() {
    return _habitRepository.checkStreak();
  }

  Future<bool> create({required HabitEntity habit}) {
    return _habitRepository.createHabit(habit);
  }

  Future<bool> edit({required HabitEntity habit}) {
    return _habitRepository.editHabit(habit);
  }

  Future<bool> delete({required int habitCode}) {
    return _habitRepository.deleteHabit(habitCode);
  }

  Future<bool> done(bool done, {required int habitCode}) {
    return _habitRepository.doneHabit(done, habitCode);
  }

  Future<bool> checkListDone(List<CheckListModel> checkList,
      {required int habitCode}) {
    return _habitRepository.checkListDone(checkList, habitCode);
  }
}
