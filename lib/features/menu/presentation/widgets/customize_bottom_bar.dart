import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_button.dart';
import '../../../../core/utils/rupiah.dart';

class CustomizeBottomBar extends StatelessWidget {
  const CustomizeBottomBar({
    super.key,
    required this.unitCount,
    required this.total,
    required this.onSubmit,
  });

  final int unitCount;
  final int total;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final summary = Semantics(
      label: 'Total racikan $unitCount topping',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_bag_rounded, size: 18, color: scheme.secondary),
          SizedBox(width: context.spacing.xs),
          Flexible(
            child: Text(
              'Total Racikan ($unitCount Topping)',
              maxLines: 2,
              style: textTheme.labelLarge?.copyWith(
                color: scheme.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    final totalColumn = Semantics(
      label: 'Total harga ${formatRupiah(total)}',
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total Harga',
            style: textTheme.labelSmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          Text(
            formatRupiah(total),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.price.copyWith(color: scheme.primary),
          ),
        ],
      ),
    );

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.95),
            border: Border(
              top: BorderSide(
                color: scheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            boxShadow: context.elevation.header,
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.spacing.margin,
                context.spacing.md,
                context.spacing.margin,
                context.spacing.sm,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (largeText) ...[
                    summary,
                    SizedBox(height: context.spacing.xs),
                    Align(alignment: Alignment.centerRight, child: totalColumn),
                  ] else
                    Row(
                      children: [
                        Expanded(child: summary),
                        SizedBox(width: context.spacing.md),
                        totalColumn,
                      ],
                    ),
                  SizedBox(height: context.spacing.sm),
                  AppButton(
                    label: 'Tambah ke Keranjang',
                    icon: Icons.shopping_bag_outlined,
                    expand: true,
                    labelMaxLines: 2,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacing.lg,
                      vertical: 15,
                    ),
                    onPressed: onSubmit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
