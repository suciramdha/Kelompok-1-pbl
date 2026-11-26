import 'package:flutter/material.dart';

@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.margin,
    required this.marginMd,
    required this.marginLg,
    required this.gutter,
    required this.gutterSm,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double margin;
  final double marginMd;
  final double marginLg;
  final double gutter;
  final double gutterSm;

  static const standard = AppSpacing(
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    margin: 16,
    marginMd: 24,
    marginLg: 32,
    gutter: 16,
    gutterSm: 12,
  );

  static AppSpacing of(BuildContext context) =>
      Theme.of(context).extension<AppSpacing>() ?? standard;

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? margin,
    double? marginMd,
    double? marginLg,
    double? gutter,
    double? gutterSm,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      margin: margin ?? this.margin,
      marginMd: marginMd ?? this.marginMd,
      marginLg: marginLg ?? this.marginLg,
      gutter: gutter ?? this.gutter,
      gutterSm: gutterSm ?? this.gutterSm,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      xs: _lerp(xs, other.xs, t),
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      margin: _lerp(margin, other.margin, t),
      marginMd: _lerp(marginMd, other.marginMd, t),
      marginLg: _lerp(marginLg, other.marginLg, t),
      gutter: _lerp(gutter, other.gutter, t),
      gutterSm: _lerp(gutterSm, other.gutterSm, t),
    );
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
