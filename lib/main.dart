import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import '/features/reminder/reminder_service/reminder.dart';
import '/features/reminder/reminder_service/notifier_service.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ReminderAdapter());
  await Hive.openBox<Reminder>('reminders');

  // ✅ TIMEZONE (CORRECT SIMPLE SETUP)
  tz.initializeTimeZones();

  // IMPORTANT: DO NOT setLocalLocation manually
  // tz.local is handled automatically

  await NotificationService.instance.init();
  await NotificationService.instance.requestPermissions();

  runApp(const BuildersOasisApp());
}