import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../database.dart'; // Import database
import '../settings_manager.dart'; // Import Settings Global (Untuk Ganti Gender)

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Bungkus dengan ValueListenableBuilder agar UI berubah saat tombol Gender ditekan
    return ValueListenableBuilder<bool>(
      valueListenable: isMaleMode,
      builder: (context, isMale, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Jelajah Gerakan'),
            actions: [
              // 2. TOMBOL GANTI GENDER (Pria / Wanita)
              Row(
                children: [
                  Icon(
                    isMale ? Icons.man : Icons.woman,
                    color: isMale ? Colors.blue : Colors.pink,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isMale ? "Pria" : "Wanita",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: isMale,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blue[100],
                    inactiveThumbColor: Colors.pink,
                    inactiveTrackColor: Colors.pink[100],
                    onChanged: (val) {
                      isMaleMode.value = val; // Ubah state global
                    },
                  ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Tombol Tambah Rencana (Dipertahankan dari kode lama Anda)
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.push('/create-plan');
            },
            tooltip: 'Buat Rencana Baru',
            child: const Icon(Icons.add),
          ),

          // Ambil data dari database
          body: StreamBuilder<List<Exercise>>(
            stream: db.watchAllExercises(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final exercises = snapshot.data ?? [];

              if (exercises.isEmpty) {
                return const Center(child: Text('Belum ada data gerakan.'));
              }

              // Tampilan Grid (Kotak-kotak)
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 Kolom
                  childAspectRatio: 0.8, // Perbandingan lebar:tinggi
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];

                  // 3. LOGIKA PEMILIHAN ASET (Pria vs Wanita)
                  // Kita pilih path berdasarkan gender yang sedang aktif
                  final assetPath = isMale ? exercise.assetMan : exercise.assetWoman;

                  return _buildExerciseCard(context, exercise, assetPath);
                },
              );
            },
          ),
        );
      },
    );
  }

  // Widget Kartu Gerakan
  // Saya tambahkan parameter 'assetPath' agar kartu tahu harus menampilkan gambar cowok/cewek
  Widget _buildExerciseCard(BuildContext context, Exercise exercise, String assetPath) {
    return Card(
      clipBehavior: Clip.antiAlias, // Agar gambar tidak keluar dari sudut bulat
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Saat diklik, munculkan detail instruksi (Pop-up)
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Agar bisa tinggi
            builder: (context) => _buildDetailSheet(context, exercise, assetPath),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. GAMBAR GIF (Bagian Atas)
            Expanded(
              child: Image.asset(
                assetPath, // MENGGUNAKAN ASET LOKAL
                fit: BoxFit.cover,

                // Error handler jika file tidak ditemukan
                errorBuilder: (ctx, err, stack) => Container(
                  color: Colors.grey[800],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, color: Colors.white),
                      Text("File Hilang", style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),

            // 2. TEKS NAMA (Bagian Bawah)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    exercise.category,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan Pop-up Detail Instruksi
  Widget _buildDetailSheet(BuildContext context, Exercise exercise, String assetPath) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7, // Tinggi awal 70% layar
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(24),
            children: [
              // Garis handle kecil
              Center(
                child: Container(
                  width: 40, height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2)),
                ),
              ),

              Text(exercise.name, style: Theme.of(context).textTheme.headlineMedium),
              Text(exercise.category, style: const TextStyle(color: Colors.blueAccent)),
              const SizedBox(height: 24),

              // GIF Besar di Detail
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  assetPath, // ASET LOKAL
                  errorBuilder: (context, error, stackTrace) =>
                  const SizedBox(height: 200, child: Center(child: Text("Gambar tidak ditemukan"))),
                ),
              ),

              const SizedBox(height: 24),
              const Text("Cara Melakukan:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text(
                exercise.instructions ?? "Tidak ada instruksi.",
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        );
      },
    );
  }
}