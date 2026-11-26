import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lokuak/app/theme/app_radius.dart';
import 'package:lokuak/app/theme/app_spacing.dart';
import 'package:lokuak/app/theme/app_theme.dart';
import 'package:lokuak/app/theme/app_typography.dart';

void main() {
  test('theme memakai token Seblak Lokuak', () {
    final theme = AppTheme.light;

    expect(theme.colorScheme.primary, const Color(0xFFAF101A));
    expect(theme.colorScheme.secondaryContainer, const Color(0xFFFD6C00));
    expect(theme.colorScheme.surface, const Color(0xFFFFF8F5));
    expect(theme.scaffoldBackgroundColor, const Color(0xFFFFF8F5));
    expect(theme.textTheme.bodyLarge?.fontFamily, AppTypography.fontFamily);
    expect(theme.extension<AppSpacing>()?.md, 12);
    expect(theme.extension<AppRadius>()?.lg, 16);
  });
}
