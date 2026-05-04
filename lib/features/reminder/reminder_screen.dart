import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';

import '/features/reminder/reminder_service/reminder.dart';
import '/features/reminder/reminder_service/reminder_controller.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  int selectedWeek = 1;
  DateTime selectedDate = DateTime.now();

  final ReminderController controller = ReminderController();

  final List<String> weekOptions = [
    "Last Week",
    "This Week",
    "Next Week",
  ];

  String formatKey(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  String getDayName(DateTime date) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[date.weekday - 1];
  }

  List<Reminder> filterByDate(List<Reminder> reminders) {
    final key = formatKey(selectedDate);

    return reminders.where((r) {
      return formatKey(r.dateTime) == key;
    }).toList();
  }

  String formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
        ? 12
        : dateTime.hour;

    final minute =
    dateTime.minute.toString().padLeft(2, '0');

    final period =
    dateTime.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $period";
  }

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

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Reminder>('reminders');
   final  theme = Theme.of(context);

    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text("Reminders"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: ValueListenableBuilder(
          valueListenable: box.listenable(),

          builder: (context, Box<Reminder> box, _) {
            final allReminders = box.values.toList();

            final dayReminders =
            filterByDate(allReminders);

            final upcoming = dayReminders
                .where(
                  (r) => r.dateTime.isAfter(
                DateTime.now(),
              ),
            )
                .toList();

            return Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  // =========================
                  // WEEK SELECTOR
                  // =========================

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius:
                      BorderRadius.circular(12),
                    ),

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: selectedWeek,
                        elevation: 10,
                        dropdownColor:
                        theme.cardColor,

                        iconEnabledColor:
                       theme.primaryColor,

                        items: List.generate(
                          weekOptions.length,
                              (i) {
                            return DropdownMenuItem(
                              value: i,

                              child: Text(
                                weekOptions[i],

                                style:
                                const TextStyle(

                                ),
                              ),
                            );
                          },
                        ),

                        onChanged: (v) {
                          setState(() {
                            selectedWeek = v!;
                            selectedDate =
                                DateTime.now();
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // =========================
                  // UPCOMING REMINDERS
                  // =========================

                  SizedBox(
                    height: 150,

                    child: upcoming.isEmpty
                        ? Center(
                      child: Text(
                        "No upcoming reminders",

                      ),
                    )
                        : ListView.builder(
                      scrollDirection:
                      Axis.horizontal,

                      itemCount:
                      upcoming.length,

                      itemBuilder:
                          (context, index) {
                        final item =
                        upcoming[index];

                        return Container(
                          width: 200,

                          margin:
                          const EdgeInsets.only(
                            right: 12,
                          ),

                          padding:
                          const EdgeInsets.all(
                            16,
                          ),

                          decoration:
                          BoxDecoration(
                            color:theme.cardColor,

                            borderRadius:
                            BorderRadius
                                .circular(
                              16,
                            ),

                            border:
                            customBorder(),
                          ),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                            children: [

                              Text(
                                item.title,

                                style:
                                const TextStyle(

                                  fontWeight:
                                  FontWeight
                                      .bold,
                                ),
                              ),

                              Text(
                                formatTime(
                                  item.dateTime,
                                ),

                              ),

                              const Align(
                                alignment:
                                Alignment
                                    .bottomRight,

                                child: Icon(
                                  Icons.alarm,
                                  color: AppColors
                                      .red500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  // =========================
                  // DATE NAVIGATION
                  // =========================

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedDate =
                                selectedDate.subtract(
                                  const Duration(
                                    days: 1,
                                  ),
                                );
                          });
                        },

                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color:
                          AppColors.red500,
                          size: 18,
                        ),
                      ),

                      Column(
                        children: [

                          Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",

                          ),

                          Text(
                            getDayName(
                              selectedDate,
                            ),

                            style: TextStyle(

                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedDate =
                                selectedDate.add(
                                  const Duration(
                                    days: 1,
                                  ),
                                );
                          });
                        },

                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color:
                          AppColors.red500,
                          size: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // =========================
                  // HEADER
                  // =========================

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      const Text(
                        "Reminders",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color:
                          AppColors.red500,

                          borderRadius:
                          BorderRadius.circular(
                            10,
                          ),
                        ),

                        child: IconButton(
                          onPressed: () {
                            context.push(
                              '/create_reminder',
                            );
                          },

                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // =========================
                  // REMINDERS LIST
                  // =========================

                  Expanded(
                    child: allReminders.isEmpty
                        ? Center(
                      child: Text(
                        "No reminders yet",

                      ),
                    )
                        : ListView.builder(
                      itemCount:
                      allReminders.length,

                      itemBuilder:
                          (context, index) {
                        final item =
                        allReminders[index];

                        return Container(
                          margin:
                          const EdgeInsets.only(
                            bottom: 12,
                          ),

                          padding:
                          const EdgeInsets.all(
                            16,
                          ),

                          decoration:
                          BoxDecoration(
                            color: theme.cardColor,

                            borderRadius:
                            BorderRadius
                                .circular(
                              16,
                            ),

                            border:
                            customBorder(),
                          ),

                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                            children: [

                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                                children: [

                                  Text(
                                    item.title,

                                    style:
                                    const TextStyle(

                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 6,
                                  ),

                                  Text(
                                    "${item.dateTime.day}/${item.dateTime.month}/${item.dateTime.year} • ${formatTime(item.dateTime)}",

                                    style:
                                    TextStyle(
                                      fontSize:
                                      12,
                                    ),
                                  ),
                                ],
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),

                                onPressed:
                                    () async {
                                  await controller
                                      .deleteReminder(
                                    item.id,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}