import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import 'reminder.dart';
import 'notifier_service.dart';

class ReminderController extends ChangeNotifier {
  final Box<Reminder> box = Hive.box<Reminder>('reminders');

  List<Reminder> get reminders => box.values.toList();

  /// CREATE REMINDER
  Future<void> addReminder(Reminder reminder) async {
    await box.put(reminder.id, reminder);

    await NotificationService.instance.scheduleNotification(
      id: reminder.id,
      title: reminder.title,
      body: "Reminder is due",
      scheduledDate: reminder.dateTime,
    );

    notifyListeners();
  }

  /// DELETE REMINDER
  Future<void> deleteReminder(int id) async {
    await box.delete(id);

    await NotificationService.instance.cancel(id);

    notifyListeners();
  }

  /// UPDATE REMINDER
  Future<void> updateReminder(Reminder reminder) async {
    await box.put(reminder.id, reminder);

    await NotificationService.instance.cancel(reminder.id);

    await NotificationService.instance.scheduleNotification(
      id: reminder.id,
      title: reminder.title,
      body: "Reminder updated",
      scheduledDate: reminder.dateTime,
    );

    notifyListeners();
  }
}