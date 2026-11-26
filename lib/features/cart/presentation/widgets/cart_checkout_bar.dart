import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_button.dart';
import '../../../../core/utils/rupiah.dart';

/// Sticky bar checkout di `Scaffold.bottomNavigationBar`.
class CartCheckoutBar extends StatelessWidget {
  const CartCheckoutBar({
    super.key,
    required this.total,
    required this.onCheckout,
  });

  final int total;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final label = Text(
      'Total Pembayaran',
      style: textTheme.titleMedium?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
    final amount = Text(
      formatRupiah(total),
      maxLines: 1,
      style: textTheme.headlineLarge?.copyWith(
        color: scheme.primary,
        fontWeight: FontWeight.w800,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
        ),
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: spacing.md),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            spacing.margin,
            spacing.md,
            spacing.margin,
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (largeText) ...[
                label,
                SizedBox(height: spacing.xs),
                Align(alignment: Alignment.centerRight, child: amount),
              ] else
                Row(
                  children: [
                    Expanded(child: label),
                    SizedBox(width: spacing.sm),
                    amount,
                  ],
                ),
              SizedBox(height: spacing.md),
              AppButton(
                label: 'Pesan Sekarang',
                icon: Icons.arrow_forward_rounded,
                expand: true,
                onPressed: onCheckout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
