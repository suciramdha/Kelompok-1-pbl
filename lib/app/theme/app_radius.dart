import 'package:flutter/material.dart';

@immutable
class AppRadius extends ThemeExtension<AppRadius> {
  const AppRadius({
    required this.sm,
    required this.base,
    required this.md,
    required this.lg,
    required this.xl,
    required this.full,
  });

  final double sm;
  final double base;
  final double md;
  final double lg;
  final double xl;
  final double full;

  static const standard = AppRadius(
    sm: 4,
    base: 8,
    md: 12,
    lg: 16,
    xl: 24,
    full: 999,
  );

  static AppRadius of(BuildContext context) =>
      Theme.of(context).extension<AppRadius>() ?? standard;

  BorderRadius get smRadius => BorderRadius.circular(sm);
  BorderRadius get baseRadius => BorderRadius.circular(base);
  BorderRadius get mdRadius => BorderRadius.circular(md);
  BorderRadius get lgRadius => BorderRadius.circular(lg);
  BorderRadius get xlRadius => BorderRadius.circular(xl);
  BorderRadius get fullRadius => BorderRadius.circular(full);

  @override
  AppRadius copyWith({
    double? sm,
    double? base,
    double? md,
    double? lg,
    double? xl,
    double? full,
  }) {
    return AppRadius(
      sm: sm ?? this.sm,
      base: base ?? this.base,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      full: full ?? this.full,
    );
  }

  @override
  AppRadius lerp(ThemeExtension<AppRadius>? other, double t) {
    if (other is! AppRadius) return this;
    return AppRadius(
      sm: _lerp(sm, other.sm, t),
      base: _lerp(base, other.base, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      full: _lerp(full, other.full, t),
    );
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
