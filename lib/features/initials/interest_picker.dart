import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';

class InterestPickerScreen extends StatefulWidget {
  const InterestPickerScreen({super.key});

  @override
  State<InterestPickerScreen> createState() => _InterestPickerScreenState();
}

class _InterestPickerScreenState extends State<InterestPickerScreen> {
  final List<String> _interests = [

    "Business & Entrepreneurship",
    "Finance & Investing",
    "Crypto & Blockchain",
    "Programming Basics",
    "Digital Marketing",
    "Frontend Development",
    "Backend Development",
    "Full Stack Development",
    "Mobile App Development",
    "UI/UX Design",
    "Artificial Intelligence",
    "Data Science",
  ];

  final Set<String> _selected = {};

  void _toggleInterest(String interest, bool selected) {
    setState(() {
      if (selected) {
        _selected.add(interest);
      } else {
        _selected.remove(interest);
      }
    });
  }

  void _continue() {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select at least one interest")),
      );
      return;
    }

    context.push('/register/avatar');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientScaffold(
      child: Scaffold(
        appBar: AppBar(title: const Text("Pick Your Interests"),
          actions: [
            TextButton(
              onPressed: () => context.push('/register/avatar'),
              child: const Text("Skip"),
            ),
          ],),

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER TEXT


              const SizedBox(height: 100),

              ///  BOTTOM PANEL
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,

                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),

                    border: Border(
                      top: BorderSide(
                        color: AppColors.red200,
                        width: 1,
                      ),
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          "Choose what you want to learn",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        /// CHIPS LIST
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10,
                              runSpacing: 10,
                              children: _interests.map((interest) {
                                final selected =
                                _selected.contains(interest);

                                return FilterChip(
                                  label: Text(
                                    interest,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                               avatarBorder: CircleBorder(),
                                  selected: selected,
                                  onSelected: (value) =>
                                      _toggleInterest(interest, value),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  side: BorderSide(
                                    color: selected
                                        ? Colors.red
                                        : AppColors.red200,
                                  ),

                                  shadowColor: Colors.transparent,
                                  selectedColor:
                                  const Color.fromRGBO(255, 0, 0, 0.2),

                                  backgroundColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,

                                  checkmarkColor: Colors.red,

                                  labelStyle: TextStyle(
                                    color:
                                    selected ? Colors.red : null,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        /// CONTINUE BUTTON
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _continue,
                              child: Text(
                                "Next (${_selected.length})",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}