import 'package:flutter/material.dart';

@immutable
class AppElevation extends ThemeExtension<AppElevation> {
  const AppElevation({
    required this.card,
    required this.floating,
    required this.sheet,
    required this.header,
    required this.borderColor,
    required this.scrimColor,
  });

  final List<BoxShadow> card;
  final List<BoxShadow> floating;
  final List<BoxShadow> sheet;
  final List<BoxShadow> header;
  final Color borderColor;
  final Color scrimColor;

  static const standard = AppElevation(
    card: [
      BoxShadow(color: Color(0x0F2B2118), blurRadius: 8, offset: Offset(0, 2)),
    ],
    floating: [
      BoxShadow(color: Color(0x1FD32F2F), blurRadius: 20, offset: Offset(0, 8)),
    ],
    sheet: [
      BoxShadow(
        color: Color(0x292B2118),
        blurRadius: 36,
        offset: Offset(0, 16),
      ),
    ],
    header: [
      BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 1)),
    ],
    borderColor: Color(0x0A2B2118),
    scrimColor: Color(0x7A2B2118),
  );

  static AppElevation of(BuildContext context) =>
      Theme.of(context).extension<AppElevation>() ?? standard;

  @override
  AppElevation copyWith({
    List<BoxShadow>? card,
    List<BoxShadow>? floating,
    List<BoxShadow>? sheet,
    List<BoxShadow>? header,
    Color? borderColor,
    Color? scrimColor,
  }) {
    return AppElevation(
      card: card ?? this.card,
      floating: floating ?? this.floating,
      sheet: sheet ?? this.sheet,
      header: header ?? this.header,
      borderColor: borderColor ?? this.borderColor,
      scrimColor: scrimColor ?? this.scrimColor,
    );
  }

  @override
  AppElevation lerp(ThemeExtension<AppElevation>? other, double t) => this;
}
