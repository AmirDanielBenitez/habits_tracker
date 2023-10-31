import 'package:habits_tracker/features/habits_tracker/domain/entities/checkList.dart';

class CheckListModel extends CheckListEntity {
  const CheckListModel({
    required String name,
    required bool done,
  }) : super(
          name: name,
          done: done,
        );

  factory CheckListModel.fromJson(Map<String, dynamic> map) {
    return CheckListModel(
      name: map['name'],
      done: map['done'],
    );
  }

  factory CheckListModel.fromEntity(CheckListEntity entity) {
    return CheckListModel(
      name: entity.name,
      done: entity.done,
    );
  }
}
