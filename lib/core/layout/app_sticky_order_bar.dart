import 'package:flutter/material.dart';

import '../../app/theme/app_typography.dart';
import '../../app/theme/theme_context.dart';
import '../../core/ui/app_button.dart';
import '../../core/utils/rupiah.dart';

class AppStickyOrderBar extends StatelessWidget {
  const AppStickyOrderBar({
    super.key,
    required this.itemCount,
    required this.total,
    required this.onTap,
  });

  final int itemCount;
  final int total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final compact = MediaQuery.sizeOf(context).width < 360;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final cartIcon = _CartIcon(itemCount: itemCount, textTheme: textTheme);
    final price = Text(
      formatRupiah(total),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.price.copyWith(color: scheme.primary),
    );

    final content = largeText
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  cartIcon,
                  const SizedBox(width: 10),
                  Expanded(child: price),
                ],
              ),
              const SizedBox(height: 8),
              AppButton(label: 'Lihat Pesanan', expand: true, onPressed: onTap),
            ],
          )
        : Row(
            children: [
              cartIcon,
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$itemCount Item di Keranjang',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    price,
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: compact ? 110 : 190),
                child: AppButton(
                  label: compact ? 'Lihat' : 'Lihat Pesanan',
                  icon: Icons.chevron_right_rounded,
                  onPressed: onTap,
                ),
              ),
            ],
          );

    return Container(
      margin: EdgeInsets.fromLTRB(
        context.spacing.md,
        0,
        context.spacing.md,
        context.spacing.sm,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: context.radius.lgRadius,
        border: Border.all(color: context.elevation.borderColor),
        boxShadow: context.elevation.floating,
      ),
      child: content,
    );
  }
}

class _CartIcon extends StatelessWidget {
  const _CartIcon({required this.itemCount, required this.textTheme});

  final int itemCount;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: context.radius.mdRadius,
          ),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: scheme.onPrimary,
            size: 22,
          ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              shape: BoxShape.circle,
              border: Border.all(
                color: scheme.surfaceContainerLowest,
                width: 2,
              ),
            ),
            child: Text(
              '$itemCount',
              style: textTheme.labelSmall?.copyWith(
                color: scheme.onSecondaryContainer,
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
