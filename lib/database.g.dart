// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _assetManMeta =
      const VerificationMeta('assetMan');
  @override
  late final GeneratedColumn<String> assetMan = GeneratedColumn<String>(
      'asset_man', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetWomanMeta =
      const VerificationMeta('assetWoman');
  @override
  late final GeneratedColumn<String> assetWoman = GeneratedColumn<String>(
      'asset_woman', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _instructionsMeta =
      const VerificationMeta('instructions');
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
      'instructions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, category, assetMan, assetWoman, instructions];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<Exercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('asset_man')) {
      context.handle(_assetManMeta,
          assetMan.isAcceptableOrUnknown(data['asset_man']!, _assetManMeta));
    } else if (isInserting) {
      context.missing(_assetManMeta);
    }
    if (data.containsKey('asset_woman')) {
      context.handle(
          _assetWomanMeta,
          assetWoman.isAcceptableOrUnknown(
              data['asset_woman']!, _assetWomanMeta));
    } else if (isInserting) {
      context.missing(_assetWomanMeta);
    }
    if (data.containsKey('instructions')) {
      context.handle(
          _instructionsMeta,
          instructions.isAcceptableOrUnknown(
              data['instructions']!, _instructionsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      assetMan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_man'])!,
      assetWoman: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_woman'])!,
      instructions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instructions']),
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String name;
  final String category;
  final String assetMan;
  final String assetWoman;
  final String? instructions;
  const Exercise(
      {required this.id,
      required this.name,
      required this.category,
      required this.assetMan,
      required this.assetWoman,
      this.instructions});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['asset_man'] = Variable<String>(assetMan);
    map['asset_woman'] = Variable<String>(assetWoman);
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      assetMan: Value(assetMan),
      assetWoman: Value(assetWoman),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      assetMan: serializer.fromJson<String>(json['assetMan']),
      assetWoman: serializer.fromJson<String>(json['assetWoman']),
      instructions: serializer.fromJson<String?>(json['instructions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'assetMan': serializer.toJson<String>(assetMan),
      'assetWoman': serializer.toJson<String>(assetWoman),
      'instructions': serializer.toJson<String?>(instructions),
    };
  }

  Exercise copyWith(
          {int? id,
          String? name,
          String? category,
          String? assetMan,
          String? assetWoman,
          Value<String?> instructions = const Value.absent()}) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        assetMan: assetMan ?? this.assetMan,
        assetWoman: assetWoman ?? this.assetWoman,
        instructions:
            instructions.present ? instructions.value : this.instructions,
      );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      assetMan: data.assetMan.present ? data.assetMan.value : this.assetMan,
      assetWoman:
          data.assetWoman.present ? data.assetWoman.value : this.assetWoman,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('assetMan: $assetMan, ')
          ..write('assetWoman: $assetWoman, ')
          ..write('instructions: $instructions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, category, assetMan, assetWoman, instructions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.assetMan == this.assetMan &&
          other.assetWoman == this.assetWoman &&
          other.instructions == this.instructions);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> assetMan;
  final Value<String> assetWoman;
  final Value<String?> instructions;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.assetMan = const Value.absent(),
    this.assetWoman = const Value.absent(),
    this.instructions = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required String assetMan,
    required String assetWoman,
    this.instructions = const Value.absent(),
  })  : name = Value(name),
        category = Value(category),
        assetMan = Value(assetMan),
        assetWoman = Value(assetWoman);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? assetMan,
    Expression<String>? assetWoman,
    Expression<String>? instructions,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (assetMan != null) 'asset_man': assetMan,
      if (assetWoman != null) 'asset_woman': assetWoman,
      if (instructions != null) 'instructions': instructions,
    });
  }

  ExercisesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? assetMan,
      Value<String>? assetWoman,
      Value<String?>? instructions}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      assetMan: assetMan ?? this.assetMan,
      assetWoman: assetWoman ?? this.assetWoman,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (assetMan.present) {
      map['asset_man'] = Variable<String>(assetMan.value);
    }
    if (assetWoman.present) {
      map['asset_woman'] = Variable<String>(assetWoman.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('assetMan: $assetMan, ')
          ..write('assetWoman: $assetWoman, ')
          ..write('instructions: $instructions')
          ..write(')'))
        .toString();
  }
}

class $WorkoutPlansTable extends WorkoutPlans
    with TableInfo<$WorkoutPlansTable, WorkoutPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'plan_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _restDurationMeta =
      const VerificationMeta('restDuration');
  @override
  late final GeneratedColumn<int> restDuration = GeneratedColumn<int>(
      'rest_duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(30));
  @override
  List<GeneratedColumn> get $columns => [id, name, restDuration];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_plans';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutPlan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['plan_name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rest_duration')) {
      context.handle(
          _restDurationMeta,
          restDuration.isAcceptableOrUnknown(
              data['rest_duration']!, _restDurationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutPlan(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_name'])!,
      restDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rest_duration'])!,
    );
  }

  @override
  $WorkoutPlansTable createAlias(String alias) {
    return $WorkoutPlansTable(attachedDatabase, alias);
  }
}

class WorkoutPlan extends DataClass implements Insertable<WorkoutPlan> {
  final int id;
  final String name;
  final int restDuration;
  const WorkoutPlan(
      {required this.id, required this.name, required this.restDuration});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_name'] = Variable<String>(name);
    map['rest_duration'] = Variable<int>(restDuration);
    return map;
  }

  WorkoutPlansCompanion toCompanion(bool nullToAbsent) {
    return WorkoutPlansCompanion(
      id: Value(id),
      name: Value(name),
      restDuration: Value(restDuration),
    );
  }

  factory WorkoutPlan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutPlan(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      restDuration: serializer.fromJson<int>(json['restDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'restDuration': serializer.toJson<int>(restDuration),
    };
  }

  WorkoutPlan copyWith({int? id, String? name, int? restDuration}) =>
      WorkoutPlan(
        id: id ?? this.id,
        name: name ?? this.name,
        restDuration: restDuration ?? this.restDuration,
      );
  WorkoutPlan copyWithCompanion(WorkoutPlansCompanion data) {
    return WorkoutPlan(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      restDuration: data.restDuration.present
          ? data.restDuration.value
          : this.restDuration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlan(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('restDuration: $restDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, restDuration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutPlan &&
          other.id == this.id &&
          other.name == this.name &&
          other.restDuration == this.restDuration);
}

class WorkoutPlansCompanion extends UpdateCompanion<WorkoutPlan> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> restDuration;
  const WorkoutPlansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.restDuration = const Value.absent(),
  });
  WorkoutPlansCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.restDuration = const Value.absent(),
  }) : name = Value(name);
  static Insertable<WorkoutPlan> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? restDuration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'plan_name': name,
      if (restDuration != null) 'rest_duration': restDuration,
    });
  }

  WorkoutPlansCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? restDuration}) {
    return WorkoutPlansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      restDuration: restDuration ?? this.restDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['plan_name'] = Variable<String>(name.value);
    }
    if (restDuration.present) {
      map['rest_duration'] = Variable<int>(restDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('restDuration: $restDuration')
          ..write(')'))
        .toString();
  }
}

class $PlanItemsTable extends PlanItems
    with TableInfo<$PlanItemsTable, PlanItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workout_plans (id)'));
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exercises (id)'));
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
      'sets', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _durationInSecondsMeta =
      const VerificationMeta('durationInSeconds');
  @override
  late final GeneratedColumn<int> durationInSeconds = GeneratedColumn<int>(
      'duration_in_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _exerciseOrderMeta =
      const VerificationMeta('exerciseOrder');
  @override
  late final GeneratedColumn<int> exerciseOrder = GeneratedColumn<int>(
      'exercise_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, planId, exerciseId, sets, reps, durationInSeconds, exerciseOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_items';
  @override
  VerificationContext validateIntegrity(Insertable<PlanItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(_planIdMeta,
          planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta));
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
          _setsMeta, sets.isAcceptableOrUnknown(data['sets']!, _setsMeta));
    } else if (isInserting) {
      context.missing(_setsMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('duration_in_seconds')) {
      context.handle(
          _durationInSecondsMeta,
          durationInSeconds.isAcceptableOrUnknown(
              data['duration_in_seconds']!, _durationInSecondsMeta));
    }
    if (data.containsKey('exercise_order')) {
      context.handle(
          _exerciseOrderMeta,
          exerciseOrder.isAcceptableOrUnknown(
              data['exercise_order']!, _exerciseOrderMeta));
    } else if (isInserting) {
      context.missing(_exerciseOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}plan_id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_id'])!,
      sets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sets'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps']),
      durationInSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}duration_in_seconds']),
      exerciseOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_order'])!,
    );
  }

  @override
  $PlanItemsTable createAlias(String alias) {
    return $PlanItemsTable(attachedDatabase, alias);
  }
}

class PlanItem extends DataClass implements Insertable<PlanItem> {
  final int id;
  final int planId;
  final int exerciseId;
  final int sets;
  final int? reps;
  final int? durationInSeconds;
  final int exerciseOrder;
  const PlanItem(
      {required this.id,
      required this.planId,
      required this.exerciseId,
      required this.sets,
      this.reps,
      this.durationInSeconds,
      required this.exerciseOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_id'] = Variable<int>(planId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['sets'] = Variable<int>(sets);
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || durationInSeconds != null) {
      map['duration_in_seconds'] = Variable<int>(durationInSeconds);
    }
    map['exercise_order'] = Variable<int>(exerciseOrder);
    return map;
  }

  PlanItemsCompanion toCompanion(bool nullToAbsent) {
    return PlanItemsCompanion(
      id: Value(id),
      planId: Value(planId),
      exerciseId: Value(exerciseId),
      sets: Value(sets),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      durationInSeconds: durationInSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationInSeconds),
      exerciseOrder: Value(exerciseOrder),
    );
  }

  factory PlanItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanItem(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int>(json['planId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      sets: serializer.fromJson<int>(json['sets']),
      reps: serializer.fromJson<int?>(json['reps']),
      durationInSeconds: serializer.fromJson<int?>(json['durationInSeconds']),
      exerciseOrder: serializer.fromJson<int>(json['exerciseOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int>(planId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'sets': serializer.toJson<int>(sets),
      'reps': serializer.toJson<int?>(reps),
      'durationInSeconds': serializer.toJson<int?>(durationInSeconds),
      'exerciseOrder': serializer.toJson<int>(exerciseOrder),
    };
  }

  PlanItem copyWith(
          {int? id,
          int? planId,
          int? exerciseId,
          int? sets,
          Value<int?> reps = const Value.absent(),
          Value<int?> durationInSeconds = const Value.absent(),
          int? exerciseOrder}) =>
      PlanItem(
        id: id ?? this.id,
        planId: planId ?? this.planId,
        exerciseId: exerciseId ?? this.exerciseId,
        sets: sets ?? this.sets,
        reps: reps.present ? reps.value : this.reps,
        durationInSeconds: durationInSeconds.present
            ? durationInSeconds.value
            : this.durationInSeconds,
        exerciseOrder: exerciseOrder ?? this.exerciseOrder,
      );
  PlanItem copyWithCompanion(PlanItemsCompanion data) {
    return PlanItem(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      durationInSeconds: data.durationInSeconds.present
          ? data.durationInSeconds.value
          : this.durationInSeconds,
      exerciseOrder: data.exerciseOrder.present
          ? data.exerciseOrder.value
          : this.exerciseOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanItem(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('durationInSeconds: $durationInSeconds, ')
          ..write('exerciseOrder: $exerciseOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, planId, exerciseId, sets, reps, durationInSeconds, exerciseOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanItem &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.exerciseId == this.exerciseId &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.durationInSeconds == this.durationInSeconds &&
          other.exerciseOrder == this.exerciseOrder);
}

class PlanItemsCompanion extends UpdateCompanion<PlanItem> {
  final Value<int> id;
  final Value<int> planId;
  final Value<int> exerciseId;
  final Value<int> sets;
  final Value<int?> reps;
  final Value<int?> durationInSeconds;
  final Value<int> exerciseOrder;
  const PlanItemsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.durationInSeconds = const Value.absent(),
    this.exerciseOrder = const Value.absent(),
  });
  PlanItemsCompanion.insert({
    this.id = const Value.absent(),
    required int planId,
    required int exerciseId,
    required int sets,
    this.reps = const Value.absent(),
    this.durationInSeconds = const Value.absent(),
    required int exerciseOrder,
  })  : planId = Value(planId),
        exerciseId = Value(exerciseId),
        sets = Value(sets),
        exerciseOrder = Value(exerciseOrder);
  static Insertable<PlanItem> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<int>? exerciseId,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<int>? durationInSeconds,
    Expression<int>? exerciseOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (durationInSeconds != null) 'duration_in_seconds': durationInSeconds,
      if (exerciseOrder != null) 'exercise_order': exerciseOrder,
    });
  }

  PlanItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? planId,
      Value<int>? exerciseId,
      Value<int>? sets,
      Value<int?>? reps,
      Value<int?>? durationInSeconds,
      Value<int>? exerciseOrder}) {
    return PlanItemsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
      exerciseOrder: exerciseOrder ?? this.exerciseOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (durationInSeconds.present) {
      map['duration_in_seconds'] = Variable<int>(durationInSeconds.value);
    }
    if (exerciseOrder.present) {
      map['exercise_order'] = Variable<int>(exerciseOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanItemsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('durationInSeconds: $durationInSeconds, ')
          ..write('exerciseOrder: $exerciseOrder')
          ..write(')'))
        .toString();
  }
}

class $WorkoutLogsTable extends WorkoutLogs
    with TableInfo<$WorkoutLogsTable, WorkoutLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _planNameMeta =
      const VerificationMeta('planName');
  @override
  late final GeneratedColumn<String> planName = GeneratedColumn<String>(
      'plan_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateCompletedMeta =
      const VerificationMeta('dateCompleted');
  @override
  late final GeneratedColumn<DateTime> dateCompleted =
      GeneratedColumn<DateTime>('date_completed', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, planName, dateCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_logs';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_name')) {
      context.handle(_planNameMeta,
          planName.isAcceptableOrUnknown(data['plan_name']!, _planNameMeta));
    } else if (isInserting) {
      context.missing(_planNameMeta);
    }
    if (data.containsKey('date_completed')) {
      context.handle(
          _dateCompletedMeta,
          dateCompleted.isAcceptableOrUnknown(
              data['date_completed']!, _dateCompletedMeta));
    } else if (isInserting) {
      context.missing(_dateCompletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      planName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_name'])!,
      dateCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_completed'])!,
    );
  }

  @override
  $WorkoutLogsTable createAlias(String alias) {
    return $WorkoutLogsTable(attachedDatabase, alias);
  }
}

class WorkoutLog extends DataClass implements Insertable<WorkoutLog> {
  final int id;
  final String planName;
  final DateTime dateCompleted;
  const WorkoutLog(
      {required this.id, required this.planName, required this.dateCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_name'] = Variable<String>(planName);
    map['date_completed'] = Variable<DateTime>(dateCompleted);
    return map;
  }

  WorkoutLogsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutLogsCompanion(
      id: Value(id),
      planName: Value(planName),
      dateCompleted: Value(dateCompleted),
    );
  }

  factory WorkoutLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutLog(
      id: serializer.fromJson<int>(json['id']),
      planName: serializer.fromJson<String>(json['planName']),
      dateCompleted: serializer.fromJson<DateTime>(json['dateCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planName': serializer.toJson<String>(planName),
      'dateCompleted': serializer.toJson<DateTime>(dateCompleted),
    };
  }

  WorkoutLog copyWith({int? id, String? planName, DateTime? dateCompleted}) =>
      WorkoutLog(
        id: id ?? this.id,
        planName: planName ?? this.planName,
        dateCompleted: dateCompleted ?? this.dateCompleted,
      );
  WorkoutLog copyWithCompanion(WorkoutLogsCompanion data) {
    return WorkoutLog(
      id: data.id.present ? data.id.value : this.id,
      planName: data.planName.present ? data.planName.value : this.planName,
      dateCompleted: data.dateCompleted.present
          ? data.dateCompleted.value
          : this.dateCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLog(')
          ..write('id: $id, ')
          ..write('planName: $planName, ')
          ..write('dateCompleted: $dateCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, planName, dateCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutLog &&
          other.id == this.id &&
          other.planName == this.planName &&
          other.dateCompleted == this.dateCompleted);
}

class WorkoutLogsCompanion extends UpdateCompanion<WorkoutLog> {
  final Value<int> id;
  final Value<String> planName;
  final Value<DateTime> dateCompleted;
  const WorkoutLogsCompanion({
    this.id = const Value.absent(),
    this.planName = const Value.absent(),
    this.dateCompleted = const Value.absent(),
  });
  WorkoutLogsCompanion.insert({
    this.id = const Value.absent(),
    required String planName,
    required DateTime dateCompleted,
  })  : planName = Value(planName),
        dateCompleted = Value(dateCompleted);
  static Insertable<WorkoutLog> custom({
    Expression<int>? id,
    Expression<String>? planName,
    Expression<DateTime>? dateCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planName != null) 'plan_name': planName,
      if (dateCompleted != null) 'date_completed': dateCompleted,
    });
  }

  WorkoutLogsCompanion copyWith(
      {Value<int>? id,
      Value<String>? planName,
      Value<DateTime>? dateCompleted}) {
    return WorkoutLogsCompanion(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      dateCompleted: dateCompleted ?? this.dateCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planName.present) {
      map['plan_name'] = Variable<String>(planName.value);
    }
    if (dateCompleted.present) {
      map['date_completed'] = Variable<DateTime>(dateCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLogsCompanion(')
          ..write('id: $id, ')
          ..write('planName: $planName, ')
          ..write('dateCompleted: $dateCompleted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WorkoutPlansTable workoutPlans = $WorkoutPlansTable(this);
  late final $PlanItemsTable planItems = $PlanItemsTable(this);
  late final $WorkoutLogsTable workoutLogs = $WorkoutLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [exercises, workoutPlans, planItems, workoutLogs];
}

typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  required String name,
  required String category,
  required String assetMan,
  required String assetWoman,
  Value<String?> instructions,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> category,
  Value<String> assetMan,
  Value<String> assetWoman,
  Value<String?> instructions,
});

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlanItemsTable, List<PlanItem>>
      _planItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.planItems,
          aliasName:
              $_aliasNameGenerator(db.exercises.id, db.planItems.exerciseId));

  $$PlanItemsTableProcessedTableManager get planItemsRefs {
    final manager = $$PlanItemsTableTableManager($_db, $_db.planItems)
        .filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_planItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assetMan => $composableBuilder(
      column: $table.assetMan, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assetWoman => $composableBuilder(
      column: $table.assetWoman, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => ColumnFilters(column));

  Expression<bool> planItemsRefs(
      Expression<bool> Function($$PlanItemsTableFilterComposer f) f) {
    final $$PlanItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.planItems,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanItemsTableFilterComposer(
              $db: $db,
              $table: $db.planItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assetMan => $composableBuilder(
      column: $table.assetMan, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assetWoman => $composableBuilder(
      column: $table.assetWoman, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructions => $composableBuilder(
      column: $table.instructions,
      builder: (column) => ColumnOrderings(column));
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get assetMan =>
      $composableBuilder(column: $table.assetMan, builder: (column) => column);

  GeneratedColumn<String> get assetWoman => $composableBuilder(
      column: $table.assetWoman, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => column);

  Expression<T> planItemsRefs<T extends Object>(
      Expression<T> Function($$PlanItemsTableAnnotationComposer a) f) {
    final $$PlanItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.planItems,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.planItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, $$ExercisesTableReferences),
    Exercise,
    PrefetchHooks Function({bool planItemsRefs})> {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> assetMan = const Value.absent(),
            Value<String> assetWoman = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
          }) =>
              ExercisesCompanion(
            id: id,
            name: name,
            category: category,
            assetMan: assetMan,
            assetWoman: assetWoman,
            instructions: instructions,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String category,
            required String assetMan,
            required String assetWoman,
            Value<String?> instructions = const Value.absent(),
          }) =>
              ExercisesCompanion.insert(
            id: id,
            name: name,
            category: category,
            assetMan: assetMan,
            assetWoman: assetWoman,
            instructions: instructions,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExercisesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({planItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (planItemsRefs) db.planItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (planItemsRefs)
                    await $_getPrefetchedData<Exercise, $ExercisesTable,
                            PlanItem>(
                        currentTable: table,
                        referencedTable:
                            $$ExercisesTableReferences._planItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExercisesTableReferences(db, table, p0)
                                .planItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, $$ExercisesTableReferences),
    Exercise,
    PrefetchHooks Function({bool planItemsRefs})>;
typedef $$WorkoutPlansTableCreateCompanionBuilder = WorkoutPlansCompanion
    Function({
  Value<int> id,
  required String name,
  Value<int> restDuration,
});
typedef $$WorkoutPlansTableUpdateCompanionBuilder = WorkoutPlansCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<int> restDuration,
});

final class $$WorkoutPlansTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutPlansTable, WorkoutPlan> {
  $$WorkoutPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlanItemsTable, List<PlanItem>>
      _planItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.planItems,
          aliasName:
              $_aliasNameGenerator(db.workoutPlans.id, db.planItems.planId));

  $$PlanItemsTableProcessedTableManager get planItemsRefs {
    final manager = $$PlanItemsTableTableManager($_db, $_db.planItems)
        .filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_planItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutPlansTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTable> {
  $$WorkoutPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restDuration => $composableBuilder(
      column: $table.restDuration, builder: (column) => ColumnFilters(column));

  Expression<bool> planItemsRefs(
      Expression<bool> Function($$PlanItemsTableFilterComposer f) f) {
    final $$PlanItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.planItems,
        getReferencedColumn: (t) => t.planId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanItemsTableFilterComposer(
              $db: $db,
              $table: $db.planItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTable> {
  $$WorkoutPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restDuration => $composableBuilder(
      column: $table.restDuration,
      builder: (column) => ColumnOrderings(column));
}

class $$WorkoutPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTable> {
  $$WorkoutPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get restDuration => $composableBuilder(
      column: $table.restDuration, builder: (column) => column);

  Expression<T> planItemsRefs<T extends Object>(
      Expression<T> Function($$PlanItemsTableAnnotationComposer a) f) {
    final $$PlanItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.planItems,
        getReferencedColumn: (t) => t.planId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.planItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutPlansTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutPlansTable,
    WorkoutPlan,
    $$WorkoutPlansTableFilterComposer,
    $$WorkoutPlansTableOrderingComposer,
    $$WorkoutPlansTableAnnotationComposer,
    $$WorkoutPlansTableCreateCompanionBuilder,
    $$WorkoutPlansTableUpdateCompanionBuilder,
    (WorkoutPlan, $$WorkoutPlansTableReferences),
    WorkoutPlan,
    PrefetchHooks Function({bool planItemsRefs})> {
  $$WorkoutPlansTableTableManager(_$AppDatabase db, $WorkoutPlansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> restDuration = const Value.absent(),
          }) =>
              WorkoutPlansCompanion(
            id: id,
            name: name,
            restDuration: restDuration,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int> restDuration = const Value.absent(),
          }) =>
              WorkoutPlansCompanion.insert(
            id: id,
            name: name,
            restDuration: restDuration,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutPlansTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({planItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (planItemsRefs) db.planItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (planItemsRefs)
                    await $_getPrefetchedData<WorkoutPlan, $WorkoutPlansTable,
                            PlanItem>(
                        currentTable: table,
                        referencedTable: $$WorkoutPlansTableReferences
                            ._planItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutPlansTableReferences(db, table, p0)
                                .planItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.planId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutPlansTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutPlansTable,
    WorkoutPlan,
    $$WorkoutPlansTableFilterComposer,
    $$WorkoutPlansTableOrderingComposer,
    $$WorkoutPlansTableAnnotationComposer,
    $$WorkoutPlansTableCreateCompanionBuilder,
    $$WorkoutPlansTableUpdateCompanionBuilder,
    (WorkoutPlan, $$WorkoutPlansTableReferences),
    WorkoutPlan,
    PrefetchHooks Function({bool planItemsRefs})>;
typedef $$PlanItemsTableCreateCompanionBuilder = PlanItemsCompanion Function({
  Value<int> id,
  required int planId,
  required int exerciseId,
  required int sets,
  Value<int?> reps,
  Value<int?> durationInSeconds,
  required int exerciseOrder,
});
typedef $$PlanItemsTableUpdateCompanionBuilder = PlanItemsCompanion Function({
  Value<int> id,
  Value<int> planId,
  Value<int> exerciseId,
  Value<int> sets,
  Value<int?> reps,
  Value<int?> durationInSeconds,
  Value<int> exerciseOrder,
});

final class $$PlanItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PlanItemsTable, PlanItem> {
  $$PlanItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutPlansTable _planIdTable(_$AppDatabase db) =>
      db.workoutPlans.createAlias(
          $_aliasNameGenerator(db.planItems.planId, db.workoutPlans.id));

  $$WorkoutPlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$WorkoutPlansTableTableManager($_db, $_db.workoutPlans)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
          $_aliasNameGenerator(db.planItems.exerciseId, db.exercises.id));

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PlanItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanItemsTable> {
  $$PlanItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sets => $composableBuilder(
      column: $table.sets, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationInSeconds => $composableBuilder(
      column: $table.durationInSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder, builder: (column) => ColumnFilters(column));

  $$WorkoutPlansTableFilterComposer get planId {
    final $$WorkoutPlansTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.workoutPlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlansTableFilterComposer(
              $db: $db,
              $table: $db.workoutPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlanItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanItemsTable> {
  $$PlanItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sets => $composableBuilder(
      column: $table.sets, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationInSeconds => $composableBuilder(
      column: $table.durationInSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder,
      builder: (column) => ColumnOrderings(column));

  $$WorkoutPlansTableOrderingComposer get planId {
    final $$WorkoutPlansTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.workoutPlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlansTableOrderingComposer(
              $db: $db,
              $table: $db.workoutPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableOrderingComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlanItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanItemsTable> {
  $$PlanItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get durationInSeconds => $composableBuilder(
      column: $table.durationInSeconds, builder: (column) => column);

  GeneratedColumn<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder, builder: (column) => column);

  $$WorkoutPlansTableAnnotationComposer get planId {
    final $$WorkoutPlansTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.workoutPlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutPlansTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlanItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlanItemsTable,
    PlanItem,
    $$PlanItemsTableFilterComposer,
    $$PlanItemsTableOrderingComposer,
    $$PlanItemsTableAnnotationComposer,
    $$PlanItemsTableCreateCompanionBuilder,
    $$PlanItemsTableUpdateCompanionBuilder,
    (PlanItem, $$PlanItemsTableReferences),
    PlanItem,
    PrefetchHooks Function({bool planId, bool exerciseId})> {
  $$PlanItemsTableTableManager(_$AppDatabase db, $PlanItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> planId = const Value.absent(),
            Value<int> exerciseId = const Value.absent(),
            Value<int> sets = const Value.absent(),
            Value<int?> reps = const Value.absent(),
            Value<int?> durationInSeconds = const Value.absent(),
            Value<int> exerciseOrder = const Value.absent(),
          }) =>
              PlanItemsCompanion(
            id: id,
            planId: planId,
            exerciseId: exerciseId,
            sets: sets,
            reps: reps,
            durationInSeconds: durationInSeconds,
            exerciseOrder: exerciseOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int planId,
            required int exerciseId,
            required int sets,
            Value<int?> reps = const Value.absent(),
            Value<int?> durationInSeconds = const Value.absent(),
            required int exerciseOrder,
          }) =>
              PlanItemsCompanion.insert(
            id: id,
            planId: planId,
            exerciseId: exerciseId,
            sets: sets,
            reps: reps,
            durationInSeconds: durationInSeconds,
            exerciseOrder: exerciseOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlanItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({planId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (planId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.planId,
                    referencedTable:
                        $$PlanItemsTableReferences._planIdTable(db),
                    referencedColumn:
                        $$PlanItemsTableReferences._planIdTable(db).id,
                  ) as T;
                }
                if (exerciseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseId,
                    referencedTable:
                        $$PlanItemsTableReferences._exerciseIdTable(db),
                    referencedColumn:
                        $$PlanItemsTableReferences._exerciseIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PlanItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlanItemsTable,
    PlanItem,
    $$PlanItemsTableFilterComposer,
    $$PlanItemsTableOrderingComposer,
    $$PlanItemsTableAnnotationComposer,
    $$PlanItemsTableCreateCompanionBuilder,
    $$PlanItemsTableUpdateCompanionBuilder,
    (PlanItem, $$PlanItemsTableReferences),
    PlanItem,
    PrefetchHooks Function({bool planId, bool exerciseId})>;
typedef $$WorkoutLogsTableCreateCompanionBuilder = WorkoutLogsCompanion
    Function({
  Value<int> id,
  required String planName,
  required DateTime dateCompleted,
});
typedef $$WorkoutLogsTableUpdateCompanionBuilder = WorkoutLogsCompanion
    Function({
  Value<int> id,
  Value<String> planName,
  Value<DateTime> dateCompleted,
});

class $$WorkoutLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planName => $composableBuilder(
      column: $table.planName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateCompleted => $composableBuilder(
      column: $table.dateCompleted, builder: (column) => ColumnFilters(column));
}

class $$WorkoutLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planName => $composableBuilder(
      column: $table.planName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateCompleted => $composableBuilder(
      column: $table.dateCompleted,
      builder: (column) => ColumnOrderings(column));
}

class $$WorkoutLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planName =>
      $composableBuilder(column: $table.planName, builder: (column) => column);

  GeneratedColumn<DateTime> get dateCompleted => $composableBuilder(
      column: $table.dateCompleted, builder: (column) => column);
}

class $$WorkoutLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutLogsTable,
    WorkoutLog,
    $$WorkoutLogsTableFilterComposer,
    $$WorkoutLogsTableOrderingComposer,
    $$WorkoutLogsTableAnnotationComposer,
    $$WorkoutLogsTableCreateCompanionBuilder,
    $$WorkoutLogsTableUpdateCompanionBuilder,
    (WorkoutLog, BaseReferences<_$AppDatabase, $WorkoutLogsTable, WorkoutLog>),
    WorkoutLog,
    PrefetchHooks Function()> {
  $$WorkoutLogsTableTableManager(_$AppDatabase db, $WorkoutLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> planName = const Value.absent(),
            Value<DateTime> dateCompleted = const Value.absent(),
          }) =>
              WorkoutLogsCompanion(
            id: id,
            planName: planName,
            dateCompleted: dateCompleted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String planName,
            required DateTime dateCompleted,
          }) =>
              WorkoutLogsCompanion.insert(
            id: id,
            planName: planName,
            dateCompleted: dateCompleted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutLogsTable,
    WorkoutLog,
    $$WorkoutLogsTableFilterComposer,
    $$WorkoutLogsTableOrderingComposer,
    $$WorkoutLogsTableAnnotationComposer,
    $$WorkoutLogsTableCreateCompanionBuilder,
    $$WorkoutLogsTableUpdateCompanionBuilder,
    (WorkoutLog, BaseReferences<_$AppDatabase, $WorkoutLogsTable, WorkoutLog>),
    WorkoutLog,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$WorkoutPlansTableTableManager get workoutPlans =>
      $$WorkoutPlansTableTableManager(_db, _db.workoutPlans);
  $$PlanItemsTableTableManager get planItems =>
      $$PlanItemsTableTableManager(_db, _db.planItems);
  $$WorkoutLogsTableTableManager get workoutLogs =>
      $$WorkoutLogsTableTableManager(_db, _db.workoutLogs);
}
