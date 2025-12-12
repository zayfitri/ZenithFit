import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Ikon default (pastikan @mipmap/ic_launcher ada)
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        print('Notifikasi diklik: ${details.payload}');
      },
    );
  }

  Future<void> requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int secondsFromNow,
  }) async {

    // 1. Tunggu dulu (Logic Timer)
    await Future.delayed(Duration(seconds: secondsFromNow));

    // 2. Tampilkan Notifikasi INSTANT dengan Prioritas TINGGI
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          // --- KUNCI PERBAIKAN DI SINI ---
          'zenithfit_channel_v2', // GANTI ID (Biar Android reset setting)
          'Notifikasi Penting',   // Ganti Nama
          channelDescription: 'Saluran untuk notifikasi pop-up',

          // Agar Muncul di Layar (Heads-up Notification)
          importance: Importance.max,
          priority: Priority.high,

          // Agar Bunyi & Getar
          playSound: true,
          enableVibration: true,

          // Agar layar menyala (opsional)
          fullScreenIntent: true,
        ),
      ),
    );
  }
}