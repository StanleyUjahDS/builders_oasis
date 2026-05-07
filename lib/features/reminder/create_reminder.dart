import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '/core/theme/app_colors.dart';
import '/features/reminder/reminder_service/reminder.dart';
import '/features/reminder/reminder_service/notifier_service.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';

class CreateReminderScreen extends StatefulWidget {
  const CreateReminderScreen({super.key});

  @override
  State<CreateReminderScreen> createState() =>
      _CreateReminderScreenState();
}

class _CreateReminderScreenState
    extends State<CreateReminderScreen> {
  final TextEditingController titleController =
  TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  bool isSaving = false;

  Border customBorder() {
    return Border(
      top: BorderSide(
        color: AppColors.red200.withValues(alpha: 0.6),
        width: 1.5,
      ),
      bottom: BorderSide(
        color: AppColors.red200.withValues(alpha: 0.6),
        width: 1.5,
      ),
      left: BorderSide.none,
      right: BorderSide.none,
    );
  }

  /// PICK DATE
  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  /// PICK TIME
  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  /// SAVE REMINDER
  Future<void> saveReminder() async {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a title"),
        ),
      );
      return;
    }

    setState(() => isSaving = true);

    try {
      final dateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (dateTime.isBefore(DateTime.now())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cannot set past reminder"),
          ),
        );
        return;
      }

      final box = Hive.box<Reminder>('reminders');

      final int id =
      box.isEmpty ? 0 : box.keys.cast<int>().last + 1;

      final reminder = Reminder(
        id: id,
        title: title,
        dateTime: dateTime,
      );

      await box.put(id, reminder);

      await NotificationService.instance
          .scheduleNotification(
        id: id,
        title: title,
        body: "Reminder is due now",
        scheduledDate: dateTime,
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text("Create Reminder"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              /// TITLE
              Text(
                "Title",
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius:
                  BorderRadius.circular(12),
                  border: customBorder(),
                ),

                child: TextField(
                  controller: titleController,

                  decoration: InputDecoration(
                    hintText:
                    "Enter reminder title",

                    hintStyle: theme
                        .textTheme.bodyMedium
                        ?.copyWith(
                      color: theme
                          .textTheme.bodyMedium
                          ?.color
                          ?.withValues(
                        alpha: 0.5,
                      ),
                    ),

                    border: InputBorder.none,

                    contentPadding:
                    const EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// DATE
              Text(
                "Date",
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: pickDate,

                child: Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: theme.cardColor,

                    borderRadius:
                    BorderRadius.circular(12),

                    border: customBorder(),
                  ),

                  child: Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",

                    style:
                    theme.textTheme.bodyMedium,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// TIME
              Text(
                "Time",
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: pickTime,

                child: Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: theme.cardColor,

                    borderRadius:
                    BorderRadius.circular(12),

                    border: customBorder(),
                  ),

                  child: Text(
                    selectedTime.format(context),

                    style:
                    theme.textTheme.bodyMedium,
                  ),
                ),
              ),

              const Spacer(),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed:
                  isSaving ? null : saveReminder,

                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.red500,

                    padding:
                    const EdgeInsets.all(16),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),

                  child: isSaving
                      ? const SizedBox(
                    height: 20,
                    width: 20,

                    child:
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    "Save Reminder",
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final testTime =
                    DateTime.now().add(const Duration(seconds: 10));

                    await NotificationService.instance.scheduleNotification(
                      id: 1001,
                      title: "Scheduled Test",
                      body: "This should appear after 10 seconds",
                      scheduledDate: testTime,
                    );
                  },
                  child: const Text("Test Schedule"),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}