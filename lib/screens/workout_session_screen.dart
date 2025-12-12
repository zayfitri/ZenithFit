import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../database.dart';
import '../settings_manager.dart';

class WorkoutSessionScreen extends StatefulWidget {
  final int planId;
  final String planName;
  const WorkoutSessionScreen({required this.planId, required this.planName, super.key});
  @override
  State<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  List<PlanItemWithExercise> _items = [];
  int _currentItemIndex = 0;
  int _currentSet = 1;
  bool _isLoading = true;
  bool _isResting = false;
  Timer? _timer;
  int _secondsRemaining = 0;
  int _restDuration = 30;

  @override
  void initState() {
    super.initState();
    _loadWorkout();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  Future<void> _loadWorkout() async {
    final streamDetails = db.watchPlanDetails(widget.planId);
    final itemsData = await streamDetails.first;
    final planInfo = await db.getPlanById(widget.planId);
    if (mounted) {
      setState(() {
        _items = itemsData;
        _restDuration = planInfo.restDuration;
        _isLoading = false;
      });
      if (_items.isNotEmpty) _setupCurrentExercise();
    }
  }
  void _setupCurrentExercise() {
    if (_items.isEmpty) return;
    final currentItem = _items[_currentItemIndex].item;
    _timer?.cancel();
    setState(() {
      if (currentItem.durationInSeconds != null) {
        _secondsRemaining = currentItem.durationInSeconds!;
        _startTimer();
      } else {
        _secondsRemaining = 0;
      }
    });
  }
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
        if (_isResting) _finishRest();
        else _nextStep();
      }
    });
  }
  void _finishRest() {
    setState(() => _isResting = false);
    _setupCurrentExercise();
  }
  void _nextStep() {
    _timer?.cancel();
    final currentItem = _items[_currentItemIndex].item;
    if (_currentSet < currentItem.sets) {
      setState(() {
        _currentSet++;
        _isResting = true;
        _secondsRemaining = _restDuration;
        _startTimer();
      });
    } else {
      if (_currentItemIndex < _items.length - 1) {
        setState(() {
          _currentItemIndex++;
          _currentSet = 1;
          _isResting = true;
          _secondsRemaining = _restDuration;
          _startTimer();
        });
      } else {
        _finishWorkout(context);
      }
    }
  }
  void _skipRest() {
    _timer?.cancel();
    _finishRest();
  }
  Future<void> _finishWorkout(BuildContext context) async {
    await db.addWorkoutLog(WorkoutLogsCompanion(planName: drift.Value(widget.planName), dateCompleted: drift.Value(DateTime.now())));
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('🎉 Selamat! 🎉'),
        content: Text('Latihan "${widget.planName}" selesai.'),
        actions: [TextButton(onPressed: () { Navigator.of(ctx).pop(); context.go('/home'); }, child: const Text('Mantap'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_items.isEmpty) return Scaffold(appBar: AppBar(), body: const Center(child: Text('Kosong.')));

    final currentData = _items[_currentItemIndex];
    final currentExercise = currentData.exercise;
    final isTimer = currentData.item.durationInSeconds != null;

    return ValueListenableBuilder<bool>(
      valueListenable: isMaleMode,
      builder: (context, isMale, child) {
        final assetPath = isMale ? currentExercise.assetMan : currentExercise.assetWoman;

        return Scaffold(
          backgroundColor: Colors.white, // Background Utama Putih
          appBar: AppBar(
            title: Text(
              _isResting ? 'ISTIRAHAT' : '${currentExercise.name} (${_currentSet}/${currentData.item.sets})',
              style: TextStyle(color: _isResting ? Colors.deepPurple : Colors.black87),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: _isResting ? Colors.deepPurple : Colors.black87),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  color: Colors.white, // Background Gambar Putih
                  child: _isResting
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ikon Jam Ungu saat Istirahat
                      const Icon(Icons.timer_outlined, size: 80, color: Colors.deepPurple),
                      const SizedBox(height: 16),
                      Text(
                        'Ambil Napas...',
                        style: TextStyle(color: Colors.deepPurple[300], fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                      : Image.asset(
                    assetPath,
                    fit: BoxFit.contain,
                    errorBuilder: (ctx, err, stack) => const Center(child: Text("GIF tidak ditemukan")),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        _isResting || isTimer ? '${_secondsRemaining}s' : '${currentData.item.reps} Reps',
                        style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            // Warna teks berubah jadi Ungu saat istirahat
                            color: _isResting ? Colors.deepPurple : Colors.black87
                        )
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: FilledButton.icon(
                          onPressed: _isResting ? _skipRest : (isTimer ? null : _nextStep),
                          icon: Icon(_isResting ? Icons.skip_next : Icons.check),
                          label: Text(_isResting ? 'LEWATI' : (isTimer ? 'TAHAN...' : 'SELESAI SET'), style: const TextStyle(fontWeight: FontWeight.bold)),
                          // Tombol Ungu Elegan
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[50], // Abu sangat muda biar beda dikit
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Cara Melakukan:",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple[700])
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                  currentExercise.instructions ?? "Tidak ada instruksi.",
                                  style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87)
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}