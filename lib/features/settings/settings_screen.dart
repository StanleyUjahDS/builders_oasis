import 'package:flutter/material.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GradientScaffold(
      child: Scaffold(
        body: Center(
          child: Text('Home Screen'),
        ),
      ),
    );
  }
}