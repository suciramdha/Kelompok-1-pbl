import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

/// Kartu opsi single-select bergaya pill tanpa border.
///
/// Meniru kartu pilihan kuah pada desain Stitch: latar beige saat tidak
/// terpilih, `surface-container-highest` saat terpilih, dengan indikator radio
/// ring + dot. Aman dipakai dari 320 dp sampai text scale 2.0.
class AppOptionCard extends StatelessWidget {
  const AppOptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
    this.tag,
    this.trailingLabel,
    this.semanticLabel,
  });

  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;
  final String? tag;
  final String? trailingLabel;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final label =
        semanticLabel ??
        '$title${tag != null ? '. $tag' : ''}. $description'
            '${trailingLabel != null ? '. $trailingLabel' : ''}';

    return Semantics(
      button: true,
      inMutuallyExclusiveGroup: true,
      checked: selected,
      onTap: onTap,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: selected
            ? scheme.surfaceContainerHighest
            : scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: context.radius.mdRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(context.spacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          Text(
                            title,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (tag != null) _TagPill(label: tag!),
                        ],
                      ),
                      SizedBox(height: context.spacing.xs),
                      Text(
                        description,
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      if (largeText && trailingLabel != null) ...[
                        SizedBox(height: context.spacing.xs),
                        Text(
                          trailingLabel!,
                          style: textTheme.labelMedium?.copyWith(
                            color: scheme.onSurface,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!largeText && trailingLabel != null) ...[
                  SizedBox(width: context.spacing.sm),
                  Text(
                    trailingLabel!,
                    maxLines: 1,
                    style: textTheme.labelMedium?.copyWith(
                      color: scheme.onSurface,
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
        color: selected ? scheme.primary : scheme.surfaceContainerLowest,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: selected
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: scheme.onPrimary,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: scheme.secondaryFixed,
        borderRadius: context.radius.fullRadius,
      ),
      child: Text(
        label,
        maxLines: 1,
        style: textTheme.labelSmall?.copyWith(
          color: scheme.onSecondaryFixed,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
