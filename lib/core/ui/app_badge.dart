import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

enum AppBadgeTone { neutral, brand, success, secondary, danger }

/// Pill status ringkas untuk label singkat (mis. "Tersedia", "Promo").
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.icon,
    this.tone = AppBadgeTone.neutral,
  });

  final String label;

  /// Ikon dekoratif di kiri label; tidak dibacakan ke screen reader.
  final IconData? icon;
  final AppBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    final (background, foreground) = switch (tone) {
      AppBadgeTone.neutral => (
        scheme.surfaceContainer,
        scheme.onSurfaceVariant,
      ),
      AppBadgeTone.brand => (scheme.primaryFixed, scheme.onPrimaryFixedVariant),
      AppBadgeTone.success => (scheme.surfaceContainer, scheme.tertiary),
      AppBadgeTone.secondary => (
        scheme.secondaryFixed,
        scheme.onSecondaryFixedVariant,
      ),
      AppBadgeTone.danger => (scheme.errorContainer, scheme.onErrorContainer),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.sm,
        vertical: spacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radius.fullRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            ExcludeSemantics(child: Icon(icon, size: 14, color: foreground)),
            SizedBox(width: spacing.xs),
          ],
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}
