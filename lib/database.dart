import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// --- DEFINISI TABEL ---
class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get category => text().withLength(min: 1, max: 50)();

  // Aset Wajib (String biasa)
  TextColumn get assetMan => text()();
  TextColumn get assetWoman => text()();

  // Instruksi
  TextColumn get instructions => text().nullable()();
}

class WorkoutPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('plan_name')();
  IntColumn get restDuration => integer().withDefault(const Constant(30))();
}

class WorkoutLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get planName => text()();
  DateTimeColumn get dateCompleted => dateTime()();
}

class PlanItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId => integer().references(WorkoutPlans, #id)();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  IntColumn get sets => integer()();
  IntColumn get reps => integer().nullable()();
  IntColumn get durationInSeconds => integer().nullable()();
  IntColumn get exerciseOrder => integer()();
}

class PlanItemWithExercise {
  final PlanItem item;
  final Exercise exercise;
  PlanItemWithExercise({required this.item, required this.exercise});
}

class NewPlanItem {
  final int exerciseId;
  final int sets;
  final int? reps;
  final int? durationInSeconds;
  final int order;
  NewPlanItem({required this.exerciseId, required this.sets, this.reps, this.durationInSeconds, required this.order});
}

@DriftDatabase(tables: [Exercises, WorkoutPlans, PlanItems, WorkoutLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.inMemory() : super(NativeDatabase.memory());

  // NAIKKAN VERSI KE 6 (Agar memaksa update data)
  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await _seedExercises();
      },
      onUpgrade: (m, from, to) async {
        // Hapus tabel lama dan buat baru agar data fresh
        for (final table in allTables) {
          await m.deleteTable(table.actualTableName);
          await m.createTable(table);
        }
        await _seedExercises();
      },
    );
  }

  // --- DATA SEEDING (PERBAIKAN TIPE DATA) ---
  Future<void> _seedExercises() async {
    final exercisesList = [
      ExercisesCompanion.insert(
        name: 'Burpees',
        category: 'Full Body',
        // HAPUS "const Value()" pada asset agar tidak error
        assetMan: 'assets/Gif_PAPB_Man/Burpee_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Burpee_Woman.gif',
        instructions: const Value('1. Berdiri tegak.\n2. Jongkok, tangan di lantai.\n3. Lompat kaki ke belakang (pushup).\n4. Lompat kembali ke depan.\n5. Lompat vertikal.'),
      ),
      ExercisesCompanion.insert(
        name: 'Squat',
        category: 'Kaki',
        assetMan: 'assets/Gif_PAPB_Man/Squat_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Squat_Woman.gif',
        instructions: const Value('1. Kaki selebar bahu.\n2. Turunkan pinggul seperti duduk.\n3. Punggung tegak.\n4. Kembali berdiri.'),
      ),
      ExercisesCompanion.insert(
        name: 'Push Up',
        category: 'Dada',
        assetMan: 'assets/Gif_PAPB_Man/Push_Up_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Push_Up_Woman.gif',
        instructions: const Value('1. Posisi plank.\n2. Turunkan dada ke lantai.\n3. Dorong kembali ke atas.\n4. Jaga tubuh lurus.'),
      ),
      ExercisesCompanion.insert(
        name: 'Lying Leg Raise',
        category: 'Perut',
        assetMan: 'assets/Gif_PAPB_Man/Lying_leg_raise_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Lying_leg_raise_Woman.gif',
        instructions: const Value('1. Tidur telentang.\n2. Angkat kaki lurus 90 derajat.\n3. Turunkan perlahan.\n4. Jangan sentuh lantai.'),
      ),
      ExercisesCompanion.insert(
        name: 'Jumping Jack',
        category: 'Kardio',
        assetMan: 'assets/Gif_PAPB_Man/Jumping_Jack_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Jumping_Jack_Woman.gif',
        instructions: const Value('1. Berdiri tegak.\n2. Lompat buka kaki & tepuk tangan.\n3. Tutup kaki & tangan.\n4. Ulangi cepat.'),
      ),
      ExercisesCompanion.insert(
        name: 'High Knee Taps',
        category: 'Kardio',
        assetMan: 'assets/Gif_PAPB_Man/High_knee_taps_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/High_knee_taps_Woman.gif',
        instructions: const Value('1. Lari di tempat.\n2. Angkat lutut tinggi.\n3. Sentuh lutut dengan tangan.\n4. Jaga tempo.'),
      ),
      ExercisesCompanion.insert(
        name: 'Sumo Squat',
        category: 'Paha',
        assetMan: 'assets/Gif_PAPB_Man/Sumo_Squat_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Sumo_Squat_Woman.gif',
        instructions: const Value('1. Kaki lebar, jari keluar.\n2. Turunkan pinggul.\n3. Fokus paha dalam.\n4. Kembali berdiri.'),
      ),
      ExercisesCompanion.insert(
        name: 'Lunges',
        category: 'Kaki',
        assetMan: 'assets/Gif_PAPB_Man/Lunges_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Lunges_Woman.gif',
        instructions: const Value('1. Langkah ke depan.\n2. Tekuk lutut 90 derajat.\n3. Belakang lurus.\n4. Ganti kaki.'),
      ),
      ExercisesCompanion.insert(
        name: 'Body Saw',
        category: 'Inti',
        assetMan: 'assets/Gif_PAPB_Man/Body_saw_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Body_saw_Woman.gif',
        instructions: const Value('1. Posisi plank lengan.\n2. Dorong tubuh ke depan.\n3. Tarik ke belakang.\n4. Kencangkan perut.'),
      ),
      ExercisesCompanion.insert(
        name: 'Sit Up',
        category: 'Perut',
        assetMan: 'assets/Gif_PAPB_Man/Sit_Up_Man.gif',
        assetWoman: 'assets/Gif_PAPB_Woman/Sit_Up_Woman.gif',
        instructions: const Value('1. Tidur, lutut ditekuk.\n2. Angkat badan duduk.\n3. Turun perlahan.\n4. Ulangi.'),
      ),
    ];
    await batch((batch) => batch.insertAll(exercises, exercisesList));
  }

  // --- QUERIES ---
  Stream<List<Exercise>> watchAllExercises() => select(exercises).watch();
  Future<int> addExercise(ExercisesCompanion entry) => into(exercises).insert(entry);
  Stream<List<WorkoutPlan>> watchAllWorkoutPlans() => select(workoutPlans).watch();
  Future<int> addWorkoutLog(WorkoutLogsCompanion entry) => into(workoutLogs).insert(entry);
  Stream<List<WorkoutLog>> watchAllLogs() => (select(workoutLogs)..orderBy([(t) => OrderingTerm(expression: t.dateCompleted, mode: OrderingMode.desc)])).watch();
  Future<void> deletePlan(int planId) async {
    await transaction(() async {
      await (delete(planItems)..where((t) => t.planId.equals(planId))).go();
      await (delete(workoutPlans)..where((t) => t.id.equals(planId))).go();
    });
  }
  Future<WorkoutPlan> getPlanById(int id) => (select(workoutPlans)..where((t) => t.id.equals(id))).getSingle();

  Future<void> createNewPlan(String planName, int restSeconds, List<NewPlanItem> items) async {
    await transaction(() async {
      final planId = await into(workoutPlans).insert(WorkoutPlansCompanion(name: Value(planName), restDuration: Value(restSeconds)));
      for (final item in items) {
        await into(planItems).insert(PlanItemsCompanion(planId: Value(planId), exerciseId: Value(item.exerciseId), sets: Value(item.sets), reps: Value(item.reps), durationInSeconds: Value(item.durationInSeconds), exerciseOrder: Value(item.order)));
      }
    });
  }
  Future<void> updateExistingPlan(int planId, String newName, int newRest, List<NewPlanItem> newItems) async {
    await transaction(() async {
      await (update(workoutPlans)..where((t) => t.id.equals(planId))).write(WorkoutPlansCompanion(name: Value(newName), restDuration: Value(newRest)));
      await (delete(planItems)..where((t) => t.planId.equals(planId))).go();
      for (final item in newItems) {
        await into(planItems).insert(PlanItemsCompanion(planId: Value(planId), exerciseId: Value(item.exerciseId), sets: Value(item.sets), reps: Value(item.reps), durationInSeconds: Value(item.durationInSeconds), exerciseOrder: Value(item.order)));
      }
    });
  }
  Stream<List<PlanItemWithExercise>> watchPlanDetails(int planId) {
    return (select(planItems).join([innerJoin(exercises, exercises.id.equalsExp(planItems.exerciseId))])..where(planItems.planId.equals(planId))..orderBy([OrderingTerm.asc(planItems.exerciseOrder)])).map((row) => PlanItemWithExercise(item: row.readTable(planItems), exercise: row.readTable(exercises))).watch();
  }
}
LazyDatabase _openConnection() => LazyDatabase(() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  return NativeDatabase.createInBackground(File(p.join(dbFolder.path, 'db.sqlite')));
});
final AppDatabase db = AppDatabase();