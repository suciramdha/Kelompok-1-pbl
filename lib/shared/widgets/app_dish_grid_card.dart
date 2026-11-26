import 'package:flutter/material.dart';

import '../../app/theme/app_typography.dart';
import '../../app/theme/theme_context.dart';
import '../../core/ui/app_network_image.dart';
import '../../core/ui/app_spice_level_badge.dart';
import '../../core/utils/rupiah.dart';

class AppDishGridCard extends StatelessWidget {
  const AppDishGridCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.onTap,
    this.spiceLevel,
    this.spiceLabel,
  });

  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final VoidCallback onTap;
  final int? spiceLevel;
  final String? spiceLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: AppNetworkImage(url: imageUrl, semanticLabel: name),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          maxLines: 1,
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
                        const Spacer(),
                        Text(
                          formatRupiah(price),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.price.copyWith(
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
