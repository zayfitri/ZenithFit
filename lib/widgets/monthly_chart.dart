import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../database.dart';

class MonthlyChart extends StatefulWidget {
  final List<WorkoutLog> logs;

  const MonthlyChart({required this.logs, super.key});

  @override
  State<MonthlyChart> createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  // Tahun yang sedang dilihat (Default: Tahun sekarang)
  int _focusedYear = DateTime.now().year;

  void _changeYear(int offset) {
    setState(() {
      _focusedYear += offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Siapkan data untuk 12 Bulan (Jan - Des)
    final List<int> monthlyCounts = List.filled(12, 0);

    // 2. Filter Log berdasarkan Tahun yang dipilih (_focusedYear)
    for (var log in widget.logs) {
      if (log.dateCompleted.year == _focusedYear) {
        int monthIndex = log.dateCompleted.month - 1; // Jan=0
        monthlyCounts[monthIndex]++;
      }
    }

    // 3. Cari nilai tertinggi
    int maxCount = 0;
    for (var count in monthlyCounts) {
      if (count > maxCount) maxCount = count;
    }
    double maxY = (maxCount < 5) ? 5.0 : maxCount.toDouble() + 2;

    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- HEADER NAVIGASI TAHUN ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () => _changeYear(-1), // Tahun sebelumnya
                ),
                Column(
                  children: [
                    Text(
                      'Rekapan Tahun $_focusedYear',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Total latihan per bulan',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () => _changeYear(1), // Tahun berikutnya
                ),
              ],
            ),

            const SizedBox(height: 24),

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
                          '${rod.toY.round()} Selesai',
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
                          const style = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10);
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Jan'; break;
                            case 2: text = 'Mar'; break;
                            case 4: text = 'Mei'; break;
                            case 6: text = 'Jul'; break;
                            case 8: text = 'Sep'; break;
                            case 10: text = 'Nov'; break;
                            default: text = '';
                          }
                          return SideTitleWidget(meta: meta, space: 4, child: Text(text, style: style));
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: List.generate(12, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: monthlyCounts[index].toDouble(),
                          // Highlight jika Bulan ini (di Tahun sekarang)
                          color: (index == (DateTime.now().month - 1) && _focusedYear == DateTime.now().year)
                              ? Colors.amber
                              : Colors.white,
                          width: 12,
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