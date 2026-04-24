import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color success;
  final Color warning;

  const AppThemeExtension({
    required this.success,
    required this.warning,
  });

  @override
  AppThemeExtension copyWith({
    Color? success,
    Color? warning,
  }) {
    return AppThemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppThemeExtension lerp(
      ThemeExtension<AppThemeExtension>? other,
      double t,
      ) {
    if (other is! AppThemeExtension) return this;

    return AppThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}