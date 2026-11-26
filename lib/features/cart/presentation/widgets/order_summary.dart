import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/utils/rupiah.dart';
import '../providers/cart_provider.dart';
import 'cart_section_card.dart';

/// Section rincian pembayaran: subtotal, ongkir, biaya layanan, total akhir.
class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key, required this.cart});

  final CartState cart;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final spacing = context.spacing;

    return CartSectionCard(
      icon: Icons.receipt_long_rounded,
      title: 'Rincian Pembayaran',
      gap: spacing.sm,
      children: [
        _SummaryRow(
          label: 'Subtotal Pesanan (${cart.itemCount} Item)',
          amount: cart.subtotal,
        ),
        _SummaryRow(
          label: 'Ongkos Kirim',
          amount: cart.deliveryFee,
          labelTrailing: _DistanceTag(label: cart.distanceLabel),
        ),
        _SummaryRow(
          label: 'Biaya Layanan & Kemasan',
          amount: cart.serviceFee,
          labelTrailing: Icon(
            Icons.eco_rounded,
            size: 16,
            color: scheme.onSurfaceVariant,
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: scheme.outlineVariant.withValues(alpha: 0.6),
        ),
        _TotalRow(total: cart.total),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.amount,
    this.labelTrailing,
  });

  final String label;
  final int amount;
  final Widget? labelTrailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final stacked = _isStacked(context);

    final labelText = Text(
      label,
      style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
    );
    final trailing = labelTrailing;
    final labelWidget = trailing == null
        ? labelText
        : Wrap(
            spacing: spacing.xs,
            runSpacing: 2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [labelText, trailing],
          );
    final amountText = Text(
      formatRupiah(amount),
      maxLines: 1,
      style: textTheme.bodyMedium?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelWidget,
          SizedBox(height: spacing.xs),
          Align(alignment: Alignment.centerRight, child: amountText),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: labelWidget),
        SizedBox(width: spacing.sm),
        amountText,
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final stacked = _isStacked(context);

    final label = Text(
      'Total Akhir',
      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    );
    final amount = Text(
      formatRupiah(total),
      maxLines: 1,
      style: textTheme.headlineLarge?.copyWith(
        color: scheme.primary,
        fontWeight: FontWeight.w800,
      ),
    );

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label,
          SizedBox(height: spacing.xs),
          Align(alignment: Alignment.centerRight, child: amount),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: label),
        SizedBox(width: spacing.sm),
        amount,
      ],
    );
  }
}

class _DistanceTag extends StatelessWidget {
  const _DistanceTag({required this.label});

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
        color: scheme.surfaceContainerHigh,
        borderRadius: context.radius.fullRadius,
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
      ),
    );
  }
}

bool _isStacked(BuildContext context) {
  final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;
  return largeText || MediaQuery.sizeOf(context).width < 340;
}
