import 'package:flutter/material.dart';

@immutable
class AppMotion extends ThemeExtension<AppMotion> {
  const AppMotion({
    required this.fast,
    required this.normal,
    required this.slow,
    required this.toast,
    required this.standard,
  });

  final Duration fast;
  final Duration normal;
  final Duration slow;
  final Duration toast;
  final Curve standard;

  static const defaultMotion = AppMotion(
    fast: Duration(milliseconds: 150),
    normal: Duration(milliseconds: 250),
    slow: Duration(milliseconds: 400),
    toast: Duration(milliseconds: 2400),
    standard: Curves.easeInOut,
  );

  static AppMotion of(BuildContext context) =>
      Theme.of(context).extension<AppMotion>() ?? defaultMotion;

  @override
  AppMotion copyWith({
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Duration? toast,
    Curve? standard,
  }) {
    return AppMotion(
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      toast: toast ?? this.toast,
      standard: standard ?? this.standard,
    );
  }

  @override
  AppMotion lerp(ThemeExtension<AppMotion>? other, double t) => this;
}
