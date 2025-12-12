import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database.dart';
import '../widgets/calendar_tracker.dart'; // Widget Kalender
import '../widgets/monthly_chart.dart';   // Widget Grafik Tahunan

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Riwayat & Streak 🔥', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: StreamBuilder<List<WorkoutLog>>(
        stream: db.watchAllLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final logs = snapshot.data ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- BAGIAN 1: KALENDER STREAK (API) ---
                const Text(
                  "Kalender Latihan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                const SizedBox(height: 12),
                CalendarTracker(logs: logs),

                const SizedBox(height: 24),

                // --- BAGIAN 2: STATISTIK TAHUNAN (BARU DITAMBAHKAN) ---
                const Text(
                  "Statistik Tahunan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                const SizedBox(height: 12),

                // Container Ungu untuk Grafik Tahunan
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple, // Background Ungu
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
                    ],
                  ),
                  child: MonthlyChart(logs: logs), // Panggil Widget Grafik
                ),

                const SizedBox(height: 24),

                // --- BAGIAN 3: DAFTAR RIWAYAT ---
                const Text(
                    "Detail Riwayat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)
                ),
                const SizedBox(height: 12),

                if (logs.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Belum ada data latihan.\nAyo mulai bakar kalori! 🔥',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true, // Agar bisa digulung
                    physics: const NeverScrollableScrollPhysics(), // Scroll ikut parent
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      String formattedDate;
                      try {
                        // Format tanggal Indonesia
                        formattedDate = DateFormat('EEEE, d MMM yyyy • HH:mm', 'id_ID').format(log.dateCompleted);
                      } catch (e) {
                        formattedDate = log.dateCompleted.toString();
                      }

                      return Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.local_fire_department, color: Colors.orange),
                          ),
                          title: Text(
                            log.planName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(formattedDate),
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 32), // Padding bawah agar tidak mentok
              ],
            ),
          );
        },
      ),
    );
  }
}