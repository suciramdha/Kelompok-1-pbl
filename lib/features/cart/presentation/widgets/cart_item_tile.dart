import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/ui/app_network_image.dart';
import '../../../../core/ui/app_quantity_stepper.dart';
import '../../../../core/utils/rupiah.dart';
import '../models/cart_line_item.dart';

/// Baris item keranjang: thumbnail, judul, detail, harga, stepper, catatan.
class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemoveRequested,
    required this.onNoteTap,
  });

  final CartLineItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemoveRequested;
  final VoidCallback onNoteTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final width = MediaQuery.sizeOf(context).width;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;
    final stacked = width < 360 || largeText;

    final price = Text(
      formatRupiah(item.lineTotal),
      maxLines: 1,
      style: AppTypography.price.copyWith(color: scheme.primary),
    );

    final stepper = AppQuantityStepper(
      value: item.quantity,
      min: 1,
      max: 20,
      emphasizeIncrease: true,
      semanticItemName: item.name,
      onChanged: onQuantityChanged,
      onDecrementAtMin: onRemoveRequested,
      decrementAtMinSemanticLabel: 'Hapus ${item.name} dari keranjang',
    );

    return Container(
      padding: EdgeInsets.all(spacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: context.radius.mdRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Thumbnail(item: item),
              SizedBox(width: spacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      item.details,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: spacing.sm),
                    if (stacked)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          price,
                          SizedBox(height: spacing.xs),
                          stepper,
                        ],
                      )
                    else
                      Row(children: [price, const Spacer(), stepper]),
                  ],
                ),
              ),
            ],
          ),
          if (item.note != null) ...[
            SizedBox(height: spacing.xs),
            Semantics(
              button: true,
              label: 'Edit catatan ${item.name}. ${item.note}',
              onTap: onNoteTap,
              excludeSemantics: true,
              child: Material(
                color: scheme.surfaceContainerLowest,
                shape: RoundedRectangleBorder(
                  borderRadius: context.radius.baseRadius,
                  side: BorderSide(
                    color: scheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onNoteTap,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.sm,
                        vertical: spacing.xs + 2,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_note_rounded,
                            size: 16,
                            color: scheme.secondary,
                          ),
                          SizedBox(width: spacing.xs),
                          Expanded(
                            child: Text(
                              '"${item.note}"',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.item});

  final CartLineItem item;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final spiceLevel = item.spiceLevel;

    return Stack(
      children: [
        AppNetworkImage(
          url: RemoteImages.dish(item.imageSeed, width: 200, height: 200),
          width: 80,
          height: 80,
          borderRadius: context.radius.mdRadius,
          semanticLabel: 'Foto ${item.name}',
        ),
        if (spiceLevel != null)
          Positioned(
            top: spacing.xs,
            left: spacing.xs,
            child: _SpiceTag(level: spiceLevel),
          ),
      ],
    );
  }
}

class _SpiceTag extends StatelessWidget {
  const _SpiceTag({required this.level});

  final int level;

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
        color: scheme.primary,
        borderRadius: context.radius.fullRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            size: 12,
            color: scheme.onPrimary,
          ),
          const SizedBox(width: 2),
          Text(
            'Lv $level',
            style: textTheme.labelSmall?.copyWith(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
