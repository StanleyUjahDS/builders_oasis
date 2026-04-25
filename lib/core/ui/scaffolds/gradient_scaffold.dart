import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget child;

  const GradientScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primary = theme.colorScheme.primary;
    final surface = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          gradient:LinearGradient(
            colors: isDark
                ? [
              surface,
              Color.lerp(primary, surface, 0.93)!,
            ]
                : [
              surface,
              Color.lerp(primary, surface, 0.8)!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),

        child: child,
      ),
    );
  }
}