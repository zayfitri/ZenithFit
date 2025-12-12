import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../database.dart'; // Pastikan import ini ada

class PlanDetailScreen extends StatelessWidget {
  final int planId;
  final String planName;

  const PlanDetailScreen({
    required this.planId,
    required this.planName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planName),
        // --- TAMBAHAN BARU: TOMBOL EDIT ---
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Rencana Ini',
            onPressed: () {
              // Navigasi ke halaman Edit
              // Kita pakai context.push agar ada tombol 'Back' nanti
              context.push('/edit-plan/$planId');
            },
          ),
        ],
        // ----------------------------------
      ),
      // Gunakan stream agar tampilan otomatis berubah setelah di-edit
      body: StreamBuilder<List<PlanItemWithExercise>>(
        stream: db.watchPlanDetails(planId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(child: Text('Tidak ada gerakan dalam rencana ini.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final planItem = items[index].item;
              final exercise = items[index].exercise;

              // Logika subtitle dinamis (Set/Reps atau Timer)
              String subtitle;
              if (planItem.reps != null) {
                subtitle = "${planItem.sets} set  x  ${planItem.reps} reps";
              } else if (planItem.durationInSeconds != null) {
                subtitle = "${planItem.sets} set  x  ${planItem.durationInSeconds} detik";
              } else {
                subtitle = "${planItem.sets} set";
              }

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'), // Urutan
                  ),
                  title: Text(exercise.name),
                  subtitle: Text(
                    subtitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigasi ke sesi latihan (Mulai)
          context.push('/session/$planId', extra: planName);
        },
        icon: const Icon(Icons.play_arrow),
        label: const Text('Mulai Latihan'),
      ),
    );
  }
}