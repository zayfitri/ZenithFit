import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../database.dart';

// Helper Class untuk form input
class ExerciseSelection {
  final Exercise exercise;
  final TextEditingController setsController = TextEditingController(text: '3');
  final TextEditingController repsController = TextEditingController(text: '10');
  final TextEditingController durationController = TextEditingController(text: '30');
  bool isRepsBased = true; // True = Reps, False = Timer

  ExerciseSelection({required this.exercise});

  void dispose() {
    setsController.dispose();
    repsController.dispose();
    durationController.dispose();
  }
}

class CreatePlanScreen extends StatefulWidget {
  final int? planId; // Jika null = Buat Baru, Jika ada isi = Edit

  const CreatePlanScreen({super.key, this.planId});

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  final _nameController = TextEditingController();
  final _restController = TextEditingController(text: '30'); // Default 30 detik

  List<ExerciseSelection> _selectedExercises = [];
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit && widget.planId != null) {
      _loadExistingPlan(widget.planId!);
    }
    _isInit = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _restController.dispose();
    for (var selection in _selectedExercises) {
      selection.dispose();
    }
    super.dispose();
  }

  // Load Data jika mode EDIT
  Future<void> _loadExistingPlan(int id) async {
    final plan = await db.getPlanById(id);
    _nameController.text = plan.name;
    _restController.text = plan.restDuration.toString();

    final details = await db.watchPlanDetails(id).first;

    setState(() {
      _selectedExercises = details.map((e) {
        final selection = ExerciseSelection(exercise: e.exercise);
        selection.setsController.text = e.item.sets.toString();

        if (e.item.durationInSeconds != null) {
          selection.isRepsBased = false;
          selection.durationController.text = e.item.durationInSeconds.toString();
        } else {
          selection.isRepsBased = true;
          selection.repsController.text = (e.item.reps ?? 10).toString();
        }
        return selection;
      }).toList();
    });
  }

  // --- POPUP PILIH GERAKAN ---
  void _showExerciseSelectionDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Agar bisa full screen
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, controller) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Pilih Gerakan"),
                leading: const CloseButton(),
              ),
              body: StreamBuilder<List<Exercise>>(
                stream: db.watchAllExercises(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final allExercises = snapshot.data!;

                  return ListView.builder(
                    controller: controller,
                    itemCount: allExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = allExercises[index];
                      return ListTile(
                        // Tampilkan Gambar Kecil (Preview)
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            exercise.assetMan, // Default ambil gambar cowok buat preview
                            width: 50, height: 50, fit: BoxFit.cover,
                            errorBuilder: (c,e,s) => const Icon(Icons.fitness_center),
                          ),
                        ),
                        title: Text(exercise.name),
                        subtitle: Text(exercise.category),
                        onTap: () {
                          setState(() {
                            _selectedExercises.add(ExerciseSelection(exercise: exercise));
                          });
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  // --- SIMPAN DATA KE DATABASE ---
  Future<void> _savePlan() async {
    final planName = _nameController.text;
    final restTime = int.tryParse(_restController.text) ?? 30;

    // VALIDASI 1: Data Kosong
    if (planName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nama rencana wajib diisi!'), backgroundColor: Colors.red));
      return;
    }
    if (_selectedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Minimal harus ada 1 gerakan!'), backgroundColor: Colors.red));
      return;
    }

    final List<NewPlanItem> itemsToSave = [];
    for (int i = 0; i < _selectedExercises.length; i++) {
      final selection = _selectedExercises[i];
      final sets = int.tryParse(selection.setsController.text) ?? 0;
      final reps = int.tryParse(selection.repsController.text) ?? 0;
      final duration = int.tryParse(selection.durationController.text) ?? 0;

      // VALIDASI 2: Angka Nol
      if (sets <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Set pada gerakan ke-${i+1} tidak boleh 0!'), backgroundColor: Colors.red));
        return;
      }
      if (selection.isRepsBased && reps <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Repetisi pada gerakan ke-${i+1} tidak boleh 0!'), backgroundColor: Colors.red));
        return;
      }
      if (!selection.isRepsBased && duration <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Durasi pada gerakan ke-${i+1} tidak boleh 0!'), backgroundColor: Colors.red));
        return;
      }

      itemsToSave.add(NewPlanItem(
        exerciseId: selection.exercise.id,
        sets: sets,
        reps: selection.isRepsBased ? reps : null,
        durationInSeconds: selection.isRepsBased ? null : duration,
        order: i,
      ));
    }

    if (widget.planId == null) {
      // Create Baru
      await db.createNewPlan(planName, restTime, itemsToSave);
    } else {
      // Update Lama
      await db.updateExistingPlan(widget.planId!, planName, restTime, itemsToSave);
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rencana berhasil disimpan!'), backgroundColor: Colors.green));
    context.pop(); // Kembali ke layar sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.planId == null ? 'Buat Rencana Baru' : 'Edit Rencana'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.deepPurple),
            onPressed: _savePlan,
            tooltip: 'Simpan',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- NAMA RENCANA ---
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Rencana (Contoh: Kaki Kuat)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 16),

            // --- WAKTU ISTIRAHAT ---
            TextField(
              controller: _restController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Waktu Istirahat Antar Set',
                border: OutlineInputBorder(),
                suffixText: 'Detik',
                prefixIcon: Icon(Icons.timer_outlined, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 16),

            // --- TOMBOL TAMBAH ---
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: _showExerciseSelectionDialog,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Gerakan'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple.shade50,
                  foregroundColor: Colors.deepPurple,
                ),
              ),
            ),
            const Divider(height: 32),

            // --- LIST GERAKAN ---
            Expanded(
              child: _selectedExercises.isEmpty
                  ? const Center(child: Text("Belum ada gerakan. Tekan tombol Tambah."))
                  : ListView.builder(
                itemCount: _selectedExercises.length,
                itemBuilder: (context, index) {
                  return _buildExerciseCard(_selectedExercises[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- KARTU INPUT PER GERAKAN ---
  Widget _buildExerciseCard(ExerciseSelection selection, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Kartu (Nama & Hapus)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${index + 1}. ${selection.exercise.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      selection.dispose();
                      _selectedExercises.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Baris Input Sets & Toggle Mode
            Row(
              children: [
                // Input Sets
                Expanded(
                  child: TextField(
                    controller: selection.setsController,
                    decoration: const InputDecoration(
                      labelText: 'Sets',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(width: 16),

                // Toggle Button (Reps vs Timer)
                ToggleButtons(
                  isSelected: [selection.isRepsBased, !selection.isRepsBased],
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: Colors.deepPurple,
                  color: Colors.deepPurple,
                  constraints: const BoxConstraints(minHeight: 40, minWidth: 60),
                  onPressed: (int btnIndex) {
                    setState(() {
                      selection.isRepsBased = (btnIndex == 0);
                    });
                  },
                  children: const [
                    Text('Reps'),
                    Text('Timer'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Input Detail (Reps atau Detik)
            if (selection.isRepsBased)
              TextField(
                controller: selection.repsController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Repetisi',
                  border: OutlineInputBorder(),
                  isDense: true,
                  suffixText: 'Reps',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              )
            else
              TextField(
                controller: selection.durationController,
                decoration: const InputDecoration(
                  labelText: 'Durasi Timer',
                  border: OutlineInputBorder(),
                  isDense: true,
                  suffixText: 'Detik',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
          ],
        ),
      ),
    );
  }
}