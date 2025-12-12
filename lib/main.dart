import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';
import 'services/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // 1. Pastikan binding Flutter siap sebelum melakukan inisialisasi async
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);


  // 2. Inisialisasi Service Notifikasi
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'ZenithFit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Saya pertahankan tema pilihan Anda
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true, // Opsional: Agar tampilan lebih modern
      ),
    );
  }
}

// --- UBAH MENJADI STATEFUL WIDGET AGAR BISA INIT STATE ---
class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({required this.child, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    // 3. Minta Izin Notifikasi saat aplikasi pertama kali dibuka
    NotificationService().requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child, // Akses child menggunakan widget.child
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Utama'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Jadwal'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_rounded), label: 'Jelajah'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Progres'),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue, // Biar kelihatan aktif
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    // Menggunakan GoRouterState untuk menentukan tab aktif
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/schedule')) return 1;
    if (location.startsWith('/explore')) return 2;
    if (location.startsWith('/progress')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0: context.go('/home'); break;
      case 1: context.go('/schedule'); break;
      case 2: context.go('/explore'); break;
      case 3: context.go('/progress'); break;
    }
  }
}