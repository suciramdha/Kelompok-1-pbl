import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../mock/cart_mock.dart';
import 'cart_section_card.dart';

/// Section metode pembayaran single-select.
class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.options,
    required this.selectedId,
    required this.onSelect,
  });

  final List<CartPaymentOption> options;
  final String selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return CartSectionCard(
      icon: Icons.payments_rounded,
      title: 'Metode Pembayaran',
      gap: context.spacing.sm,
      trailing: Text(
        'Pilih 1 metode',
        style: textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
      ),
      children: [
        for (final option in options)
          _PaymentOptionRow(
            option: option,
            selected: option.id == selectedId,
            onTap: () => onSelect(option.id),
          ),
      ],
    );
  }
}

class _PaymentOptionRow extends StatelessWidget {
  const _PaymentOptionRow({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final CartPaymentOption option;
  final bool selected;
  final VoidCallback onTap;

  IconData get _icon => switch (option.id) {
    'qris' => Icons.qr_code_2_rounded,
    'cash' => Icons.local_atm_rounded,
    _ => Icons.account_balance_wallet_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final tag = option.tag;

    final label =
        '${option.title}. ${option.subtitle}${tag != null ? '. $tag' : ''}';

    return Semantics(
      button: true,
      checked: selected,
      inMutuallyExclusiveGroup: true,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: selected ? scheme.surfaceContainerLow : scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: context.radius.mdRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(spacing.md),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selected
                        ? scheme.surfaceContainerLowest
                        : scheme.surfaceContainer,
                    borderRadius: context.radius.baseRadius,
                  ),
                  child: Icon(
                    _icon,
                    size: 24,
                    color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(width: spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: spacing.sm,
                        runSpacing: spacing.xs,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            option.title,
                            style: textTheme.labelLarge?.copyWith(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (tag != null) _FeeTag(label: tag),
                        ],
                      ),
                      SizedBox(height: spacing.xs),
                      Text(
                        option.subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spacing.sm),
                _SelectionIndicator(selected: selected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: selected ? scheme.primary : scheme.surfaceContainer,
        shape: BoxShape.circle,
        border: selected ? null : Border.all(color: scheme.outlineVariant),
      ),
      alignment: Alignment.center,
      child: selected
          ? Icon(Icons.check_rounded, size: 14, color: scheme.onPrimary)
          : null,
    );
  }
}

class _FeeTag extends StatelessWidget {
  const _FeeTag({required this.label});

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
        style: textTheme.labelSmall?.copyWith(
          color: scheme.onSecondaryFixed,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
