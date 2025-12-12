import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../database.dart';

class CalendarTracker extends StatefulWidget {
  final List<WorkoutLog> logs;

  const CalendarTracker({super.key, required this.logs});

  @override
  State<CalendarTracker> createState() => _CalendarTrackerState();
}

class _CalendarTrackerState extends State<CalendarTracker> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Fungsi untuk mengecek apakah pada hari tertentu ada latihan
  List<WorkoutLog> _getEventsForDay(DateTime day) {
    return widget.logs.where((log) {
      return isSameDay(log.dateCompleted, day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: TableCalendar(
        locale: 'id_ID', // Ganti 'en_US' jika ingin bahasa inggris
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,

        // --- LOGIKA UTAMA ---
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: _getEventsForDay, // Ini yang mendeteksi data log

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },

        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },

        // --- STYLING (TEMA UNGU) ---
        headerStyle: const HeaderStyle(
          formatButtonVisible: false, // Hilangkan tombol "2 weeks"
          titleCentered: true,
          titleTextStyle: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 16),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.deepPurple),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.deepPurple),
        ),

        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: Colors.orange, // Warna titik default (kita ganti api di bawah)
            shape: BoxShape.circle,
          ),
        ),

        // --- KUSTOMISASI MARKER (IKON API 🔥) ---
        calendarBuilders: CalendarBuilders(
          // Marker adalah tanda kecil di bawah tanggal
          markerBuilder: (context, day, events) {
            if (events.isNotEmpty) {
              return Positioned(
                bottom: 1,
                child: const Icon(
                  Icons.local_fire_department, // IKON API
                  color: Colors.orange, // Warna Api
                  size: 16,
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}