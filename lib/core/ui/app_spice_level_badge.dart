import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

class AppSpiceLevelBadge extends StatelessWidget {
  const AppSpiceLevelBadge({
    super.key,
    required this.label,
    required this.level,
  });

  final String label;
  final int level;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final (background, foreground) = switch (level) {
      >= 4 => (scheme.primaryContainer, scheme.onPrimaryContainer),
      3 => (scheme.secondaryContainer, scheme.onSecondaryContainer),
      _ => (scheme.tertiaryFixed, scheme.onTertiaryFixed),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radius.fullRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            size: 12,
            color: foreground,
          ),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
