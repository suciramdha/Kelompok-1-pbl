import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_network_image.dart';

class MenuHeroBadge {
  const MenuHeroBadge({
    required this.label,
    required this.icon,
    this.emphasized = false,
  });

  final String label;
  final IconData icon;
  final bool emphasized;
}

class MenuHero extends StatelessWidget {
  const MenuHero({
    super.key,
    required this.imageUrl,
    required this.semanticLabel,
    required this.badges,
  });

  final String imageUrl;
  final String semanticLabel;
  final List<MenuHeroBadge> badges;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = math.min(constraints.maxWidth * 3 / 4, 320.0);

        return SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(url: imageUrl, semanticLabel: semanticLabel),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      scheme.shadow.withValues(alpha: 0.16),
                      scheme.onSurface.withValues(alpha: 0),
                      scheme.onSurface.withValues(alpha: 0.78),
                    ],
                    stops: const [0, 0.45, 1],
                  ),
                ),
              ),
              Positioned(
                top: context.spacing.md,
                left: context.spacing.md,
                right: context.spacing.md,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: context.spacing.xs + 2,
                  runSpacing: context.spacing.xs + 2,
                  children: [
                    for (final badge in badges) _HeroBadgePill(badge: badge),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HeroBadgePill extends StatelessWidget {
  const _HeroBadgePill({required this.badge});

  final MenuHeroBadge badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final background = badge.emphasized
        ? scheme.primary
        : scheme.surfaceContainerHigh;
    final foreground = badge.emphasized
        ? scheme.onPrimary
        : scheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radius.fullRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badge.icon, size: 14, color: foreground),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              badge.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
