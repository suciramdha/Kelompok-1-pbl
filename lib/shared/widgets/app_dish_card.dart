import 'package:flutter/material.dart';

import '../../app/theme/app_typography.dart';
import '../../app/theme/theme_context.dart';
import '../../core/ui/app_network_image.dart';
import '../../core/ui/app_spice_level_badge.dart';
import '../../core/utils/rupiah.dart';

class AppDishCard extends StatelessWidget {
  const AppDishCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.onTap,
    this.spiceLevel,
    this.spiceLabel,
    this.badge,
  });

  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final VoidCallback onTap;
  final int? spiceLevel;
  final String? spiceLabel;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final priceLabel = Text(
      formatRupiah(price),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.price.copyWith(color: scheme.primary),
    );

    return Semantics(
      button: true,
      label: 'Lihat detail $name',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: context.radius.lgRadius,
          boxShadow: context.elevation.card,
        ),
        child: Material(
          color: scheme.surfaceContainerLowest,
          shape: RoundedRectangleBorder(
            borderRadius: context.radius.lgRadius,
            side: BorderSide(color: context.elevation.borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppNetworkImage(
                        url: imageUrl,
                        width: 96,
                        height: 96,
                        borderRadius: context.radius.mdRadius,
                        semanticLabel: name,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (badge != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: scheme.primary,
                                  borderRadius: context.radius.fullRadius,
                                ),
                                child: Text(
                                  badge!,
                                  style: textTheme.labelSmall?.copyWith(
                                    color: scheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            if (spiceLabel != null && spiceLevel != null) ...[
                              const SizedBox(height: 6),
                              AppSpiceLevelBadge(
                                label: spiceLabel!,
                                level: spiceLevel!,
                              ),
                            ],
                            if (!largeText) ...[
                              const SizedBox(height: 6),
                              priceLabel,
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (largeText) ...[const SizedBox(height: 8), priceLabel],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
