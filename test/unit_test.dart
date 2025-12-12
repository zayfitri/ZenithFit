// import 'package:drift/drift.dart'; // Perlu import drift untuk pakai 'Value' & 'Companion'
// import 'package:flutter_test/flutter_test.dart';
// import 'package:zenithfit/database.dart'; // Sesuaikan dengan nama package Anda
//
// void main() {
//   late AppDatabase database;
//
//   // Dijalankan SEBELUM tes dimulai
//   setUp(() {
//     // KUNCI DARI DOSEN: Pakai inMemory agar database HP aman
//     database = AppDatabase.inMemory();
//   });
//
//   // Dijalankan SETELAH tes selesai
//   tearDown(() async {
//     await database.close();
//   });
//
//   group('Unit Test - Logika Database', () {
//
//     // --- TES 1: MENAMBAH EXERCISE ---
//     test('CRUD: Bisa menambah Exercise baru', () async {
//       const dummyExercise = ExercisesCompanion(
//         name: Value('Tes Push Up'),
//         category: Value('Dada'),
//         imageUrl: Value('http://gambar-palsu.com/img.gif'),
//       );
//
//       // 2. ACTION (Masukkan ke DB)
//       await database.addExercise(dummyExercise);
//
//       // 3. ASSERT (Cek Hasil)
//       final allExercises = await database.watchAllExercises().first;
//       expect(allExercises.length, 1);
//       expect(allExercises.first.name, 'Tes Push Up');
//     });
//
//     // --- TES 2: MEMBUAT RENCANA (PLAN) ---
//     test('CRUD: Bisa membuat Plan dengan Rest Duration', () async {
//       // 1. DATA DUMMY (Dibuat langsung di sini)
//       const dummyPlan = WorkoutPlansCompanion(
//         name: Value('Latihan Senin Pagi'),
//         restDuration: Value(45), // Kita tes fitur baru restDuration
//       );
//
//       // 2. ACTION (Masukkan ke DB)
//       await database.into(database.workoutPlans).insert(dummyPlan);
//
//       // 3. ASSERT (Cek Hasil)
//       final allPlans = await database.watchAllWorkoutPlans().first;
//       expect(allPlans.length, 1);
//       expect(allPlans.first.name, 'Latihan Senin Pagi');
//       expect(allPlans.first.restDuration, 45); // Pastikan angka 45 tersimpan
//     });
//
//     // --- TES 3: LOGIKA NEWPLANITEM ---
//     test('Model: NewPlanItem menyimpan data logic dengan benar', () {
//       // 1. DATA DUMMY
//       final item = NewPlanItem(
//           exerciseId: 99,
//           sets: 4,
//           reps: 12,
//           order: 1
//       );
//
//       // 2. ASSERT (Cek Logic)
//       expect(item.sets, 4);
//       expect(item.reps, 12);
//       expect(item.durationInSeconds, null);
//     });
//   });
// }