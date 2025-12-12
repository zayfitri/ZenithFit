import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../database.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rencana Latihan Tersimpan'),
      ),
      body: StreamBuilder<List<WorkoutPlan>>(
        stream: db.watchAllWorkoutPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final plans = snapshot.data ?? [];

          if (plans.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Anda belum membuat rencana latihan.\n\nBuat satu di halaman Jelajah dengan menekan tombol "+".',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(
                    plan.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // TAMBAHAN: Menampilkan durasi istirahat di bawah nama
                  subtitle: Text('Istirahat: ${plan.restDuration} detik'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    tooltip: 'Hapus Rencana',
                    onPressed: () {
                      // Fitur Dialog Konfirmasi Anda (DIPERTAHANKAN)
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: const Text('Hapus Rencana'),
                            content: Text('Anda yakin ingin menghapus "${plan.name}"? Aksi ini tidak dapat dibatalkan.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Batal'),
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                onPressed: () {
                                  db.deletePlan(plan.id);
                                  Navigator.of(dialogContext).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  onTap: () {
                    // PERBAIKAN UTAMA: Menggunakan 'push' agar ada tombol Back
                    context.push('/plan/${plan.id}', extra: plan.name);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}