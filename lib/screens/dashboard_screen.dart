import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../database.dart';
import '../widgets/weekly_chart.dart';
import '../services/notification_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // --- LOGIKA PEMILIH JAM (FORMAT 24 JAM & TEMA UNGU) ---
  Future<void> _pickTimeAndSchedule(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        // MEMAKSA FORMAT 24 JAM (AM/PM HILANG)
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.deepPurple, // Warna Jarum & Seleksi Ungu
                onPrimary: Colors.white,
                surface: Colors.white,      // Background Jam Putih
                onSurface: Colors.black,    // Angka Hitam
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepPurple, // Tombol OK/Cancel Ungu
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    // Logic Notifikasi (TETAP SAMA)
    if (pickedTime != null) {
      final now = DateTime.now();
      DateTime scheduledDate = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      final int secondsDiff = scheduledDate.difference(now).inSeconds;

      NotificationService().scheduleNotification(
        id: 99,
        title: 'Waktunya Latihan! ⏰',
        body: 'Halo! Sudah jam ${pickedTime.format(context)}, yuk mulai bakar kalori!',
        secondsFromNow: secondsDiff,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pengingat diatur jam ${pickedTime.format(context)}'),
            backgroundColor: Colors.deepPurple, // Snackbar Ungu
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Background Abu Muda
      appBar: AppBar(
        title: const Text('ZenithFit Dashboard', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SAPAAN ---
            Text(
              'Halo, Atlet! 👋',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple, // Judul Ungu
              ),
            ),
            const Text(
              'Siap untuk menjadi lebih kuat hari ini?',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // --- BAGIAN CHART & STATISTIK ---
            StreamBuilder<List<WorkoutLog>>(
              stream: db.watchAllLogs(),
              builder: (context, snapshot) {
                final logs = snapshot.data ?? [];

                return Column(
                  children: [
                    // KOTAK GRAFIK (MINGGUAN) - DIBUNGKUS WARNA UNGU
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple, // <-- BACKGROUND UNGU
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
                        ],
                      ),
                      // Catatan: Jika batang grafik masih biru, itu settingan di file weekly_chart.dart
                      // Tapi kotaknya sekarang sudah ungu.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Aktivitas Minggu Ini", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 16),
                          WeeklyChart(logs: logs),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            title: 'Selesai',
                            value: logs.length.toString(),
                            icon: Icons.check_circle_outline,
                            color: Colors.deepPurple, // Ikon Ungu
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StreamBuilder<List<WorkoutPlan>>(
                            stream: db.watchAllWorkoutPlans(),
                            builder: (context, snapshotPlans) {
                              final count = snapshotPlans.data?.length ?? 0;
                              return _buildStatCard(
                                title: 'Rencana',
                                value: count.toString(),
                                icon: Icons.assignment_outlined,
                                color: Colors.deepPurpleAccent, // Ikon Ungu Terang
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // --- AKTIVITAS TERAKHIR ---
            const Text('Aktivitas Terakhir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            StreamBuilder<List<WorkoutLog>>(
              stream: db.watchAllLogs(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Card(
                      color: Colors.white,
                      child: Padding(padding: EdgeInsets.all(16.0), child: Text('Belum ada riwayat.'))
                  );
                }
                final lastLog = snapshot.data!.first;

                return Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.deepPurple, // Bulat Ungu
                      child: Icon(Icons.history, color: Colors.white),
                    ),
                    title: Text(lastLog.planName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(DateFormat('EEEE, d MMM • HH:mm').format(lastLog.dateCompleted)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/progress'),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // --- TOMBOL AKSI ---
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => context.go('/schedule'),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Mulai Latihan'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple, // Tombol Ungu
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _pickTimeAndSchedule(context),
                icon: const Icon(Icons.notifications_active),
                label: const Text('Atur Pengingat Harian'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: Colors.deepPurple, // Teks Ungu
                  side: const BorderSide(color: Colors.deepPurple),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Widget Statistik (Background Putih, Aksen Ungu)
  Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
    );
  }
}