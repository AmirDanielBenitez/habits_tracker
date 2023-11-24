// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HabitItemsTable extends HabitItems
    with TableInfo<$HabitItemsTable, HabitItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool> done = GeneratedColumn<bool>(
      'done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _streakMeta = const VerificationMeta('streak');
  @override
  late final GeneratedColumn<int> streak = GeneratedColumn<int>(
      'streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _checkListMeta =
      const VerificationMeta('checkList');
  @override
  late final GeneratedColumnWithTypeConverter<List<CheckListModel>?, String>
      checkList = GeneratedColumn<String>('check_list', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<CheckListModel>?>(
              $HabitItemsTable.$convertercheckListn);
  static const VerificationMeta _dayTimeMeta =
      const VerificationMeta('dayTime');
  @override
  late final GeneratedColumnWithTypeConverter<DayTimeHabit, int> dayTime =
      GeneratedColumn<int>('day_time', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<DayTimeHabit>($HabitItemsTable.$converterdayTime);
  static const VerificationMeta _specificDaysMeta =
      const VerificationMeta('specificDays');
  @override
  late final GeneratedColumn<String> specificDays = GeneratedColumn<String>(
      'specific_days', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastDoneMeta =
      const VerificationMeta('lastDone');
  @override
  late final GeneratedColumn<DateTime> lastDone = GeneratedColumn<DateTime>(
      'last_done', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        done,
        name,
        streak,
        color,
        checkList,
        dayTime,
        specificDays,
        lastDone
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<HabitItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('done')) {
      context.handle(
          _doneMeta, done.isAcceptableOrUnknown(data['done']!, _doneMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('streak')) {
      context.handle(_streakMeta,
          streak.isAcceptableOrUnknown(data['streak']!, _streakMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    context.handle(_checkListMeta, const VerificationResult.success());
    context.handle(_dayTimeMeta, const VerificationResult.success());
    if (data.containsKey('specific_days')) {
      context.handle(
          _specificDaysMeta,
          specificDays.isAcceptableOrUnknown(
              data['specific_days']!, _specificDaysMeta));
    }
    if (data.containsKey('last_done')) {
      context.handle(_lastDoneMeta,
          lastDone.isAcceptableOrUnknown(data['last_done']!, _lastDoneMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      done: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}done'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      streak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      checkList: $HabitItemsTable.$convertercheckListn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}check_list'])),
      dayTime: $HabitItemsTable.$converterdayTime.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_time'])!),
      specificDays: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specific_days']),
      lastDone: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_done']),
    );
  }

  @override
  $HabitItemsTable createAlias(String alias) {
    return $HabitItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<CheckListModel>, String> $convertercheckList =
      const CheckListConverter();
  static TypeConverter<List<CheckListModel>?, String?> $convertercheckListn =
      NullAwareTypeConverter.wrap($convertercheckList);
  static JsonTypeConverter2<DayTimeHabit, int, int> $converterdayTime =
      const EnumIndexConverter<DayTimeHabit>(DayTimeHabit.values);
}

class HabitItem extends DataClass implements Insertable<HabitItem> {
  final int id;
  final bool done;
  final String name;
  final int streak;
  final int color;
  final List<CheckListModel>? checkList;
  final DayTimeHabit dayTime;
  final String? specificDays;
  final DateTime? lastDone;
  const HabitItem(
      {required this.id,
      required this.done,
      required this.name,
      required this.streak,
      required this.color,
      this.checkList,
      required this.dayTime,
      this.specificDays,
      this.lastDone});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['done'] = Variable<bool>(done);
    map['name'] = Variable<String>(name);
    map['streak'] = Variable<int>(streak);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || checkList != null) {
      final converter = $HabitItemsTable.$convertercheckListn;
      map['check_list'] = Variable<String>(converter.toSql(checkList));
    }
    {
      final converter = $HabitItemsTable.$converterdayTime;
      map['day_time'] = Variable<int>(converter.toSql(dayTime));
    }
    if (!nullToAbsent || specificDays != null) {
      map['specific_days'] = Variable<String>(specificDays);
    }
    if (!nullToAbsent || lastDone != null) {
      map['last_done'] = Variable<DateTime>(lastDone);
    }
    return map;
  }

  HabitItemsCompanion toCompanion(bool nullToAbsent) {
    return HabitItemsCompanion(
      id: Value(id),
      done: Value(done),
      name: Value(name),
      streak: Value(streak),
      color: Value(color),
      checkList: checkList == null && nullToAbsent
          ? const Value.absent()
          : Value(checkList),
      dayTime: Value(dayTime),
      specificDays: specificDays == null && nullToAbsent
          ? const Value.absent()
          : Value(specificDays),
      lastDone: lastDone == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDone),
    );
  }

  factory HabitItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitItem(
      id: serializer.fromJson<int>(json['id']),
      done: serializer.fromJson<bool>(json['done']),
      name: serializer.fromJson<String>(json['name']),
      streak: serializer.fromJson<int>(json['streak']),
      color: serializer.fromJson<int>(json['color']),
      checkList: serializer.fromJson<List<CheckListModel>?>(json['checkList']),
      dayTime: $HabitItemsTable.$converterdayTime
          .fromJson(serializer.fromJson<int>(json['dayTime'])),
      specificDays: serializer.fromJson<String?>(json['specificDays']),
      lastDone: serializer.fromJson<DateTime?>(json['lastDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'done': serializer.toJson<bool>(done),
      'name': serializer.toJson<String>(name),
      'streak': serializer.toJson<int>(streak),
      'color': serializer.toJson<int>(color),
      'checkList': serializer.toJson<List<CheckListModel>?>(checkList),
      'dayTime': serializer
          .toJson<int>($HabitItemsTable.$converterdayTime.toJson(dayTime)),
      'specificDays': serializer.toJson<String?>(specificDays),
      'lastDone': serializer.toJson<DateTime?>(lastDone),
    };
  }

  HabitItem copyWith(
          {int? id,
          bool? done,
          String? name,
          int? streak,
          int? color,
          Value<List<CheckListModel>?> checkList = const Value.absent(),
          DayTimeHabit? dayTime,
          Value<String?> specificDays = const Value.absent(),
          Value<DateTime?> lastDone = const Value.absent()}) =>
      HabitItem(
        id: id ?? this.id,
        done: done ?? this.done,
        name: name ?? this.name,
        streak: streak ?? this.streak,
        color: color ?? this.color,
        checkList: checkList.present ? checkList.value : this.checkList,
        dayTime: dayTime ?? this.dayTime,
        specificDays:
            specificDays.present ? specificDays.value : this.specificDays,
        lastDone: lastDone.present ? lastDone.value : this.lastDone,
      );
  @override
  String toString() {
    return (StringBuffer('HabitItem(')
          ..write('id: $id, ')
          ..write('done: $done, ')
          ..write('name: $name, ')
          ..write('streak: $streak, ')
          ..write('color: $color, ')
          ..write('checkList: $checkList, ')
          ..write('dayTime: $dayTime, ')
          ..write('specificDays: $specificDays, ')
          ..write('lastDone: $lastDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, done, name, streak, color, checkList,
      dayTime, specificDays, lastDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitItem &&
          other.id == this.id &&
          other.done == this.done &&
          other.name == this.name &&
          other.streak == this.streak &&
          other.color == this.color &&
          other.checkList == this.checkList &&
          other.dayTime == this.dayTime &&
          other.specificDays == this.specificDays &&
          other.lastDone == this.lastDone);
}

class HabitItemsCompanion extends UpdateCompanion<HabitItem> {
  final Value<int> id;
  final Value<bool> done;
  final Value<String> name;
  final Value<int> streak;
  final Value<int> color;
  final Value<List<CheckListModel>?> checkList;
  final Value<DayTimeHabit> dayTime;
  final Value<String?> specificDays;
  final Value<DateTime?> lastDone;
  const HabitItemsCompanion({
    this.id = const Value.absent(),
    this.done = const Value.absent(),
    this.name = const Value.absent(),
    this.streak = const Value.absent(),
    this.color = const Value.absent(),
    this.checkList = const Value.absent(),
    this.dayTime = const Value.absent(),
    this.specificDays = const Value.absent(),
    this.lastDone = const Value.absent(),
  });
  HabitItemsCompanion.insert({
    this.id = const Value.absent(),
    this.done = const Value.absent(),
    required String name,
    this.streak = const Value.absent(),
    required int color,
    this.checkList = const Value.absent(),
    this.dayTime = const Value.absent(),
    this.specificDays = const Value.absent(),
    this.lastDone = const Value.absent(),
  })  : name = Value(name),
        color = Value(color);
  static Insertable<HabitItem> custom({
    Expression<int>? id,
    Expression<bool>? done,
    Expression<String>? name,
    Expression<int>? streak,
    Expression<int>? color,
    Expression<String>? checkList,
    Expression<int>? dayTime,
    Expression<String>? specificDays,
    Expression<DateTime>? lastDone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (done != null) 'done': done,
      if (name != null) 'name': name,
      if (streak != null) 'streak': streak,
      if (color != null) 'color': color,
      if (checkList != null) 'check_list': checkList,
      if (dayTime != null) 'day_time': dayTime,
      if (specificDays != null) 'specific_days': specificDays,
      if (lastDone != null) 'last_done': lastDone,
    });
  }

  HabitItemsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? done,
      Value<String>? name,
      Value<int>? streak,
      Value<int>? color,
      Value<List<CheckListModel>?>? checkList,
      Value<DayTimeHabit>? dayTime,
      Value<String?>? specificDays,
      Value<DateTime?>? lastDone}) {
    return HabitItemsCompanion(
      id: id ?? this.id,
      done: done ?? this.done,
      name: name ?? this.name,
      streak: streak ?? this.streak,
      color: color ?? this.color,
      checkList: checkList ?? this.checkList,
      dayTime: dayTime ?? this.dayTime,
      specificDays: specificDays ?? this.specificDays,
      lastDone: lastDone ?? this.lastDone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (streak.present) {
      map['streak'] = Variable<int>(streak.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (checkList.present) {
      final converter = $HabitItemsTable.$convertercheckListn;

      map['check_list'] = Variable<String>(converter.toSql(checkList.value));
    }
    if (dayTime.present) {
      final converter = $HabitItemsTable.$converterdayTime;

      map['day_time'] = Variable<int>(converter.toSql(dayTime.value));
    }
    if (specificDays.present) {
      map['specific_days'] = Variable<String>(specificDays.value);
    }
    if (lastDone.present) {
      map['last_done'] = Variable<DateTime>(lastDone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitItemsCompanion(')
          ..write('id: $id, ')
          ..write('done: $done, ')
          ..write('name: $name, ')
          ..write('streak: $streak, ')
          ..write('color: $color, ')
          ..write('checkList: $checkList, ')
          ..write('dayTime: $dayTime, ')
          ..write('specificDays: $specificDays, ')
          ..write('lastDone: $lastDone')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $HabitItemsTable habitItems = $HabitItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habitItems];
}
