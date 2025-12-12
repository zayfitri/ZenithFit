import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../database.dart';

// Kita copy kelas helper ini agar logika UI tetap jalan
class ExerciseSelection {
  final Exercise exercise;
  final TextEditingController setsController;
  final TextEditingController repsController;
  final TextEditingController durationController;
  bool isRepsBased;

  ExerciseSelection({
    required this.exercise,
    String sets = '3',
    String reps = '',
    String duration = '',
    this.isRepsBased = true,
  })  : setsController = TextEditingController(text: sets),
        repsController = TextEditingController(text: reps),
        durationController = TextEditingController(text: duration);

  void dispose() {
    setsController.dispose();
    repsController.dispose();
    durationController.dispose();
  }
}

class EditPlanScreen extends StatefulWidget {
  final int planId; // Kita butuh ID untuk tahu apa yang diedit

  const EditPlanScreen({required this.planId, super.key});

  @override
  State<EditPlanScreen> createState() => _EditPlanScreenState();
}

class _EditPlanScreenState extends State<EditPlanScreen> {
  final _nameController = TextEditingController();
  final _restTimeController = TextEditingController();

  List<ExerciseSelection> _selectedExercises = [];
  bool _isLoading = true; // Loading saat ambil data lama

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _restTimeController.dispose();
    for (var selection in _selectedExercises) {
      selection.dispose();
    }
    super.dispose();
  }

  // --- FUNGSI PENTING: AMBIL DATA LAMA ---
  Future<void> _loadExistingData() async {
    // 1. Ambil Info Plan (Nama & Rest)
    final plan = await db.getPlanById(widget.planId);
    _nameController.text = plan.name;
    _restTimeController.text = plan.restDuration.toString();

    // 2. Ambil Daftar Gerakan (Items)
    final itemsWithExercise = await db.watchPlanDetails(widget.planId).first;

    // 3. Konversi data database ke format UI
    final loadedList = itemsWithExercise.map((data) {
      final isTimer = data.item.durationInSeconds != null;

      return ExerciseSelection(
        exercise: data.exercise,
        sets: data.item.sets.toString(),
        reps: data.item.reps?.toString() ?? '',
        duration: data.item.durationInSeconds?.toString() ?? '',
        isRepsBased: !isTimer,
      );
    }).toList();

    setState(() {
      _selectedExercises = loadedList;
      _isLoading = false;
    });
  }

  void _showExerciseSelectionDialog() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return StreamBuilder<List<Exercise>>(
          stream: db.watchAllExercises(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final allExercises = snapshot.data!;
            return ListView.builder(
              itemCount: allExercises.length,
              itemBuilder: (context, index) {
                final exercise = allExercises[index];
                return ListTile(
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
        );
      },
    );
  }

  // --- FUNGSI SIMPAN PERUBAHAN ---
  Future<void> _updatePlan() async {
    final planName = _nameController.text;
    final restTime = int.tryParse(_restTimeController.text) ?? 30;

    if (planName.isEmpty || _selectedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Nama dan minimal 1 gerakan wajib diisi.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final List<NewPlanItem> itemsToSave = [];
    for (int i = 0; i < _selectedExercises.length; i++) {
      final selection = _selectedExercises[i];
      final sets = int.tryParse(selection.setsController.text) ?? 3;
      final reps = int.tryParse(selection.repsController.text);
      final duration = int.tryParse(selection.durationController.text);

      itemsToSave.add(NewPlanItem(
        exerciseId: selection.exercise.id,
        sets: sets,
        reps: selection.isRepsBased ? reps : null,
        durationInSeconds: selection.isRepsBased ? null : duration,
        order: i,
      ));
    }

    // Panggil fungsi UPDATE
    await db.updateExistingPlan(widget.planId, planName, restTime, itemsToSave);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Perubahan berhasil disimpan!'),
      backgroundColor: Colors.green,
    ));

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Rencana'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _updatePlan,
            tooltip: 'Simpan Perubahan',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Rencana',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _restTimeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Waktu Istirahat (detik)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
                suffixText: 'detik',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: _showExerciseSelectionDialog,
                child: const Text('Tambah Gerakan'),
              ),
            ),
            const Divider(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: _selectedExercises.length,
                itemBuilder: (context, index) {
                  final selection = _selectedExercises[index];
                  return _buildExerciseCard(selection, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(ExerciseSelection selection, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${index + 1}. ${selection.exercise.name}',
                  style: Theme.of(context).textTheme.titleLarge,
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: selection.setsController,
                    decoration: const InputDecoration(labelText: 'Sets', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(width: 16),
                ToggleButtons(
                  isSelected: [selection.isRepsBased, !selection.isRepsBased],
                  onPressed: (int idx) {
                    setState(() {
                      selection.isRepsBased = (idx == 0);
                    });
                  },
                  children: const [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Reps')),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Timer')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (selection.isRepsBased)
              TextField(
                controller: selection.repsController,
                decoration: const InputDecoration(labelText: 'Repetisi', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              )
            else
              TextField(
                controller: selection.durationController,
                decoration: const InputDecoration(labelText: 'Durasi (detik)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
          ],
        ),
      ),
    );
  }
}