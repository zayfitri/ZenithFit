import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenithfit/screens/create_plan_screen.dart'; // Sesuaikan package

void main() {
  group('Widget Test - Elemen UI', () {

    Future<void> pumpCreatePlanScreen(WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CreatePlanScreen(),
      ));
    }

    testWidgets('UI: Menampilkan judul halaman "Buat Rencana Baru"', (WidgetTester tester) async {
      await pumpCreatePlanScreen(tester);
      expect(find.text('Buat Rencana Baru'), findsOneWidget);
    });

    testWidgets('UI: Menampilkan input Nama dan Waktu Istirahat', (WidgetTester tester) async {
      await pumpCreatePlanScreen(tester);
      expect(find.widgetWithText(TextField, 'Nama Rencana'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Waktu Istirahat (detik)'), findsOneWidget);
    });

    testWidgets('UI: Menampilkan tombol "Tambah Gerakan"', (WidgetTester tester) async {
      await pumpCreatePlanScreen(tester);
      expect(find.text('Tambah Gerakan'), findsOneWidget);
    });
  });
}