import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database.dart';

class WeeklyChart extends StatefulWidget {
  final List<WorkoutLog> logs;

  const WeeklyChart({required this.logs, super.key});

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  // Tanggal yang sedang dilihat (Default: Hari ini)
  DateTime _focusedDate = DateTime.now();

  // Fungsi untuk geser minggu
  void _changeWeek(int daysToAdd) {
    setState(() {
      _focusedDate = _focusedDate.add(Duration(days: daysToAdd));
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Tentukan Awal Minggu (Senin) dan Akhir Minggu (Minggu) dari _focusedDate
    // logic: kurangi hari ini dengan (weekday - 1) untuk dapat senin
    final startOfWeek = DateTime(_focusedDate.year, _focusedDate.month, _focusedDate.day)
        .subtract(Duration(days: _focusedDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6, hours: 23, minutes: 59));

    // 2. Siapkan data kosong (Senin=0 ... Minggu=6)
    final List<int> weeklyCounts = List.filled(7, 0);

    // 3. Filter Log sesuai range minggu yang dipilih
    for (var log in widget.logs) {
      if (log.dateCompleted.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
          log.dateCompleted.isBefore(endOfWeek.add(const Duration(seconds: 1)))) {

        // Mapping: Senin (1) -> Index 0, ..., Minggu (7) -> Index 6
        int index = log.dateCompleted.weekday - 1;
        weeklyCounts[index]++;
      }
    }

    // 4. Hitung skala grafik
    int maxCount = 0;
    for (var count in weeklyCounts) {
      if (count > maxCount) maxCount = count;
    }
    double maxY = (maxCount < 3) ? 3.0 : maxCount.toDouble() + 1;

    // Format Tanggal untuk Judul (Contoh: 12 Des - 18 Des)
    String rangeTitle = "${DateFormat('d MMM').format(startOfWeek)} - ${DateFormat('d MMM').format(endOfWeek)}";

    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- HEADER DENGAN NAVIGASI ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () => _changeWeek(-7), // Mundur 1 Minggu
                ),
                Column(
                  children: [
                    const Text(
                      'Aktivitas Mingguan',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      rangeTitle,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () => _changeWeek(7), // Maju 1 Minggu
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --- GRAFIK BATANG ---
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: maxY,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => Colors.deepPurpleAccent,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY.round()} Kali',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12);
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Sen'; break;
                            case 1: text = 'Sel'; break;
                            case 2: text = 'Rab'; break;
                            case 3: text = 'Kam'; break;
                            case 4: text = 'Jum'; break;
                            case 5: text = 'Sab'; break;
                            case 6: text = 'Min'; break;
                            default: text = '';
                          }
                          return SideTitleWidget(meta: meta, space: 4, child: Text(text, style: style));
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: List.generate(7, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: weeklyCounts[index].toDouble(),
                          // Highlight jika hari ini (dan minggu ini yang dipilih)
                          color: (index == (DateTime.now().weekday - 1) &&
                              startOfWeek.isBefore(DateTime.now()) &&
                              endOfWeek.isAfter(DateTime.now()))
                              ? Colors.amber
                              : Colors.white,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxY,
                            color: Colors.deepPurple[700],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}