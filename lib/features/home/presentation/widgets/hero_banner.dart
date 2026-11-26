import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/ui/app_button.dart';
import '../../../../core/ui/app_network_image.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key, required this.onCta});

  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;
    final compact = MediaQuery.sizeOf(context).width < 360 || largeText;
    final imageSize = compact ? 126.0 : 158.0;

    return ClipRRect(
      borderRadius: context.radius.xlRadius,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [scheme.primary, scheme.primaryContainer],
          ),
        ),
        child: Stack(
          children: [
            if (!largeText)
              Positioned(
                right: -24,
                bottom: -24,
                child: AppNetworkImage(
                  url: RemoteImages.hero('seblak-prasmanan'),
                  width: imageSize,
                  height: imageSize,
                  borderRadius: context.radius.fullRadius,
                  semanticLabel: 'Ilustrasi Seblak Prasmanan',
                ),
              ),
            Padding(
              padding: EdgeInsets.all(context.spacing.lg),
              child: FractionallySizedBox(
                alignment: Alignment.topLeft,
                widthFactor: largeText ? 1 : (compact ? 0.62 : 0.64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.onPrimary.withValues(alpha: 0.18),
                        borderRadius: context.radius.fullRadius,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_fire_department_rounded,
                            size: 13,
                            color: scheme.onPrimary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              compact
                                  ? 'PROMO SPESIAL'
                                  : 'PROMO SPESIAL HARI INI',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: scheme.onPrimary,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: compact ? 8 : 10),
                    Text(
                      'Seblak Prasmanan Juara',
                      style:
                          (compact
                                  ? textTheme.headlineMedium
                                  : textTheme.headlineLarge)
                              ?.copyWith(
                                color: scheme.onPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                    SizedBox(height: compact ? 4 : 6),
                    Text(
                      compact
                          ? 'Bebas racik topping & level pedas. Mulai Rp10rb!'
                          : 'Bebas racik topping & level pedas cabai rawit asli. Mulai 10rb langsung kenyang poll!',
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onPrimary.withValues(alpha: 0.9),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: compact ? 12 : 14),
                    AppButton(
                      label: compact ? 'Coba' : 'Coba Sekarang',
                      icon: Icons.arrow_forward_rounded,
                      iconPosition: AppButtonIconPosition.trailing,
                      variant: AppButtonVariant.onBrand,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      onPressed: onCta,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
