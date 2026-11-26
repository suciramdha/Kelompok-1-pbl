import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/ui/app_network_image.dart';
import '../../../../core/ui/app_umkm_badge.dart';

/// Header tetap halaman Profil, mengikuti perlakuan visual [HomeHeader].
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.onNotifications});

  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.92),
            border: Border(
              bottom: BorderSide(
                color: scheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            boxShadow: context.elevation.header,
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.spacing.margin,
                context.spacing.sm,
                context.spacing.sm,
                context.spacing.md,
              ),
              child: Row(
                children: [
                  ExcludeSemantics(
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius: context.radius.mdRadius,
                      ),
                      child: Icon(
                        Icons.local_fire_department_rounded,
                        color: scheme.onPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                  SizedBox(width: context.spacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: context.spacing.xs,
                          runSpacing: context.spacing.xs,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Seblak Lokuak',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const AppUmkmBadge(),
                          ],
                        ),
                        SizedBox(height: context.spacing.xs),
                        Text(
                          'Akun & pengaturan',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onNotifications,
                    tooltip: 'Notifikasi',
                    iconSize: 24,
                    style: IconButton.styleFrom(
                      fixedSize: const Size(48, 48),
                      minimumSize: const Size(48, 48),
                      maximumSize: const Size(48, 48),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: scheme.onSurfaceVariant,
                    ),
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                  SizedBox(width: context.spacing.xs),
                  AppNetworkImage(
                    url: RemoteImages.avatar('siti-rahmawati', size: 120),
                    width: 32,
                    height: 32,
                    borderRadius: context.radius.fullRadius,
                    semanticLabel: 'Foto profil Siti Rahmawati',
                    errorWidget: Container(
                      width: 32,
                      height: 32,
                      color: scheme.surfaceContainer,
                      alignment: Alignment.center,
                      child: Text(
                        'SR',
                        style: textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
