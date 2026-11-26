import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/utils/rupiah.dart';
import '../mock/menu_detail_mock.dart';

class MenuInfoSection extends StatelessWidget {
  const MenuInfoSection({super.key, required this.detail});

  final MenuDetailModel detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final titleAndMeta = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(detail.name, style: textTheme.headlineLarge),
        if (detail.cookTime != null) ...[
          SizedBox(height: context.spacing.xs),
          Wrap(
            spacing: context.spacing.xs,
            runSpacing: 2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.schedule_rounded, size: 14, color: scheme.secondary),
              Text(
                detail.cookTime!,
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ],
    );

    final priceColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (detail.originalPrice != null)
          Text(
            formatRupiah(detail.originalPrice!),
            style: textTheme.labelSmall?.copyWith(
              color: scheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        Text(
          formatRupiah(detail.price),
          style: AppTypography.price.copyWith(color: scheme.primary),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.spacing.margin,
        context.spacing.lg,
        context.spacing.margin,
        context.spacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (largeText) ...[
            titleAndMeta,
            SizedBox(height: context.spacing.sm),
            Align(alignment: Alignment.centerRight, child: priceColumn),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: titleAndMeta),
                SizedBox(width: context.spacing.md),
                priceColumn,
              ],
            ),
          SizedBox(height: context.spacing.xs),
          Text(
            detail.description,
            style: textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
