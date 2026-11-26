import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../mock/cart_mock.dart';
import 'cart_section_card.dart';

/// Kartu alamat pengantaran: label, tag alamat utama, catatan, dan badge UMKM.
class CartAddressCard extends StatelessWidget {
  const CartAddressCard({
    super.key,
    required this.address,
    required this.onEdit,
  });

  final CartAddress address;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    final location = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on_rounded, size: 22, color: scheme.primary),
        SizedBox(width: spacing.xs),
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
                    address.label,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  _PrimaryTag(label: address.tag),
                ],
              ),
              SizedBox(height: spacing.xs),
              Text(
                address.address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: spacing.sm),
        _EditAction(onTap: onEdit),
      ],
    );

    final note = Container(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.sm,
        vertical: spacing.sm,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: context.radius.baseRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.notes_rounded, size: 18, color: scheme.onSurfaceVariant),
          SizedBox(width: spacing.sm),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Catatan: ',
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: address.note),
                ],
              ),
              style: textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );

    return CartCardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          location,
          SizedBox(height: spacing.sm),
          note,
        ],
      ),
    );
  }
}

class _PrimaryTag extends StatelessWidget {
  const _PrimaryTag({required this.label});

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

class _EditAction extends StatelessWidget {
  const _EditAction({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return Semantics(
      button: true,
      label: 'Ubah alamat pengantaran',
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.radius.fullRadius,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.xs + 2,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: context.radius.fullRadius,
            ),
            child: Text(
              'Ubah',
              style: textTheme.labelMedium?.copyWith(
                color: scheme.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
