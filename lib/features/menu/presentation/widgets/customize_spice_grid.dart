import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../mock/customize_mock.dart';

class CustomizeSpiceGrid extends StatelessWidget {
  const CustomizeSpiceGrid({
    super.key,
    required this.levels,
    required this.selectedLevel,
    required this.onChanged,
  });

  final List<CustomizeSpiceLevel> levels;
  final int? selectedLevel;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final gap = context.spacing.sm;
    final singleColumn = MediaQuery.textScalerOf(context).scale(1) > 1.5;
    final columns = singleColumn ? 1 : 2;

    return Padding(
      padding: EdgeInsets.only(top: context.spacing.sm),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final rows = <Widget>[];

          for (var start = 0; start < levels.length; start += columns) {
            if (start > 0) rows.add(SizedBox(height: gap));

            rows.add(
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var offset = 0; offset < columns; offset++) ...[
                      if (offset > 0) SizedBox(width: gap),
                      Expanded(
                        child: start + offset < levels.length
                            ? _SpiceCard(
                                level: levels[start + offset],
                                selected:
                                    levels[start + offset].level ==
                                    selectedLevel,
                                onTap: () =>
                                    onChanged(levels[start + offset].level),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }

          return Column(children: rows);
        },
      ),
    );
  }
}

class _SpiceCard extends StatelessWidget {
  const _SpiceCard({
    required this.level,
    required this.selected,
    required this.onTap,
  });

  final CustomizeSpiceLevel level;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final (tileColor, iconColor, labelColor) = _levelColors(
      scheme,
      level.level,
    );
    final resolvedTileColor = selected
        ? scheme.onPrimary.withValues(alpha: 0.2)
        : tileColor;
    final resolvedIconColor = selected ? scheme.onPrimary : iconColor;
    final resolvedLabelColor = selected ? scheme.onPrimary : labelColor;
    final titleColor = selected ? scheme.onPrimary : scheme.onSurface;
    final descriptionColor = selected
        ? scheme.primaryFixedDim
        : scheme.onSurfaceVariant;

    return Semantics(
      button: true,
      inMutuallyExclusiveGroup: true,
      checked: selected,
      label:
          'Level ${level.level}. ${level.name}. ${level.description}'
          '${level.recommended ? '. Rekomendasi' : ''}',
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: selected ? scheme.primary : scheme.surfaceContainerLow,
        borderRadius: context.radius.mdRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.radius.mdRadius,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.all(context.spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: resolvedTileColor,
                            borderRadius: context.radius.baseRadius,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            level.icon,
                            size: 16,
                            color: resolvedIconColor,
                          ),
                        ),
                        SizedBox(width: context.spacing.sm),
                        const Spacer(),
                        Text(
                          'Lvl ${level.level}',
                          maxLines: 1,
                          style: textTheme.labelSmall?.copyWith(
                            color: resolvedLabelColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.spacing.sm),
                    Text(
                      level.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        color: titleColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      level.description,
                      style: textTheme.bodySmall?.copyWith(
                        color: descriptionColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (level.recommended)
                Positioned(
                  top: -context.spacing.sm,
                  right: context.spacing.sm,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.secondaryFixed,
                      borderRadius: context.radius.fullRadius,
                    ),
                    child: Text(
                      'REKOMENDASI',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: scheme.onSecondaryFixed,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

(Color, Color, Color) _levelColors(ColorScheme scheme, int level) {
  return switch (level) {
    0 => (
      scheme.surfaceContainer,
      scheme.onSurfaceVariant,
      scheme.onSurfaceVariant,
    ),
    1 => (scheme.secondaryFixed, scheme.secondary, scheme.secondary),
    2 || 3 => (scheme.primaryFixed, scheme.primary, scheme.primary),
    4 => (scheme.primaryContainer, scheme.onPrimary, scheme.primary),
    5 => (scheme.inverseSurface, scheme.secondaryFixed, scheme.error),
    _ => (
      scheme.surfaceContainer,
      scheme.onSurfaceVariant,
      scheme.onSurfaceVariant,
    ),
  };
}
