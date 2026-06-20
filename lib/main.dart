import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:provider/provider.dart';

import '/features/reminder/reminder_service/reminder.dart';
import '/features/reminder/reminder_service/notifier_service.dart';

import '/features/auth/providers/auth_provider.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ReminderAdapter());
  await Hive.openBox<Reminder>('reminders');

  tz.initializeTimeZones();

  await NotificationService.instance.init();
  await NotificationService.instance.requestPermissions();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider()..init(),
        ),
      ],
      child: const BuildersOasisApp(),
    ),
  );
}