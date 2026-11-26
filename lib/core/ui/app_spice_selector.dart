import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

class AppSpiceOption {
  const AppSpiceOption({
    required this.level,
    required this.title,
    required this.tag,
    required this.description,
    this.tagIcon,
  });

  final int level;
  final String title;
  final String tag;
  final String description;
  final IconData? tagIcon;
}

class AppSpiceSelector extends StatelessWidget {
  const AppSpiceSelector({
    super.key,
    required this.options,
    required this.selectedLevel,
    required this.onChanged,
  });

  final List<AppSpiceOption> options;
  final int? selectedLevel;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < options.length; index++) ...[
          _SpiceCard(
            option: options[index],
            selected: options[index].level == selectedLevel,
            onTap: () => onChanged(options[index].level),
          ),
          if (index != options.length - 1) SizedBox(height: context.spacing.md),
        ],
      ],
    );
  }
}

class _SpiceCard extends StatelessWidget {
  const _SpiceCard({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final AppSpiceOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;
    final tagBackground = option.level == 1
        ? scheme.surfaceContainerHigh
        : scheme.secondaryFixed;
    final tagForeground = option.level == 1
        ? scheme.onSurfaceVariant
        : scheme.onSecondaryFixed;

    return Semantics(
      button: true,
      inMutuallyExclusiveGroup: true,
      checked: selected,
      label: '${option.title}. ${option.tag}. ${option.description}. Termasuk',
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: selected
            ? scheme.primaryFixed.withValues(alpha: 0.2)
            : scheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: context.radius.mdRadius,
          side: BorderSide(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(context.spacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RadioIndicator(selected: selected),
                SizedBox(width: context.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: context.spacing.sm,
                        runSpacing: context.spacing.xs,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(option.title, style: textTheme.titleMedium),
                          _SpiceTag(
                            label: option.tag,
                            icon: option.tagIcon,
                            background: tagBackground,
                            foreground: tagForeground,
                          ),
                        ],
                      ),
                      SizedBox(height: context.spacing.xs),
                      Text(
                        option.description,
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      if (largeText) ...[
                        SizedBox(height: context.spacing.xs),
                        Text(
                          'Termasuk',
                          style: textTheme.labelMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!largeText) ...[
                  SizedBox(width: context.spacing.sm),
                  Text(
                    'Termasuk',
                    style: textTheme.labelMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: selected ? scheme.primary : scheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: selected ? scheme.onPrimary : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _SpiceTag extends StatelessWidget {
  const _SpiceTag({
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radius.fullRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: foreground),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            maxLines: 1,
            style: textTheme.labelSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
