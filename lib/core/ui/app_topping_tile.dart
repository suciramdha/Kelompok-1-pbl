import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';
import '../utils/rupiah.dart';

class AppToppingTile extends StatelessWidget {
  const AppToppingTile({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final int price;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;
    final priceLabel = '+${formatRupiah(price)}';

    final priceText = Text(
      priceLabel,
      maxLines: 1,
      style: textTheme.labelLarge?.copyWith(
        color: scheme.secondary,
        fontWeight: FontWeight.w700,
      ),
    );

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CheckBox(value: value),
        SizedBox(width: context.spacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleMedium),
              SizedBox(height: 2),
              Text(
                description,
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        if (!largeText) ...[SizedBox(width: context.spacing.sm), priceText],
      ],
    );

    return Semantics(
      button: true,
      checked: value,
      label: '$title. $description. $priceLabel',
      onTap: () => onChanged(!value),
      excludeSemantics: true,
      child: Material(
        color: value ? scheme.surfaceContainer : scheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: context.radius.mdRadius,
          side: BorderSide(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onChanged(!value),
          child: Padding(
            padding: EdgeInsets.all(context.spacing.lg),
            child: largeText
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      content,
                      SizedBox(height: context.spacing.sm),
                      Align(alignment: Alignment.centerRight, child: priceText),
                    ],
                  )
                : content,
          ),
        ),
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: context.motion.fast,
      curve: context.motion.standard,
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: value
            ? scheme.secondaryContainer
            : scheme.surfaceContainerHighest,
        borderRadius: context.radius.baseRadius,
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.check_rounded,
        size: 16,
        color: value ? scheme.onSecondaryContainer : Colors.transparent,
      ),
    );
  }
}
