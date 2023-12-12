import 'package:drift/drift.dart';

class ConfigItems extends Table {
  @override
  String get tableName => 'config';
  IntColumn get id => integer()();
  TextColumn get locale => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
