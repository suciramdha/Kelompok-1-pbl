import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

class AppCategoryChip extends StatelessWidget {
  const AppCategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected
            ? scheme.secondaryContainer
            : scheme.surfaceContainerLow,
        borderRadius: context.radius.fullRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.radius.fullRadius,
          child: AnimatedContainer(
            duration: context.motion.fast,
            curve: context.motion.standard,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: context.radius.fullRadius,
              border: Border.all(
                color: selected
                    ? scheme.secondaryContainer
                    : scheme.outlineVariant,
              ),
            ),
            child: Text(
              label,
              maxLines: 1,
              style: textTheme.labelLarge?.copyWith(
                color: selected
                    ? scheme.onSecondaryContainer
                    : scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
