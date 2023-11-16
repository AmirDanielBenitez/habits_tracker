import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:habits_tracker/features/habits_tracker/data/models/checklist_model.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';

class HabitItems extends Table {
  @override
  String get tableName => 'habits';

  IntColumn get id => integer().autoIncrement()();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
  TextColumn get name => text()();
  IntColumn get streak => integer().withDefault(const Constant(0))();

  IntColumn get color => integer()();
  TextColumn get checkList =>
      text().nullable().map(const CheckListConverter())();
  IntColumn get dayTime =>
      intEnum<DayTimeHabit>().withDefault(const Constant(0))();
  TextColumn get specificDays => text().nullable()();
}

class CheckListConverter extends TypeConverter<List<CheckListModel>, String> {
  const CheckListConverter();

  @override
  List<CheckListModel> fromSql(String fromDb) {
    final List<dynamic> list = json.decode(fromDb);
    return list
        .map((item) => CheckListModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  String toSql(List<CheckListModel> value) {
    final List<Map<String, dynamic>> list =
        value.map((item) => item.toJson()).toList();
    return json.encode(list);
  }
}

// Ejemplo typeConverte de clase pero no lista
// class CheckListConverter extends TypeConverter<CheckListModel, String> {
//   const CheckListConverter();

//   @override
//   CheckListModel fromSql(String fromDb) {
//     return CheckListModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
//   }

//   @override
//   String toSql(CheckListModel value) {
//     return json.encode(value.toJson());
//   }
// }