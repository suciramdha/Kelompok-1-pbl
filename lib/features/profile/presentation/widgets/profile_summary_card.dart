import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/ui/app_network_image.dart';

/// Kartu ringkasan profil: foto, nama, kontak, aksi ubah profil, dan banner
/// dukungan warung lokal.
class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.supportCount,
    required this.onEditProfile,
  });

  final String name;
  final String phone;
  final String email;
  final int supportCount;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(context.spacing.lg + context.spacing.xs),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: context.radius.lgRadius,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppNetworkImage(
                url: RemoteImages.avatar('siti-rahmawati', size: 200),
                width: 72,
                height: 72,
                borderRadius: context.radius.fullRadius,
                semanticLabel: 'Foto profil $name',
                errorWidget: Container(
                  width: 72,
                  height: 72,
                  color: scheme.surfaceContainerLow,
                  alignment: Alignment.center,
                  child: Text(
                    'SR',
                    style: textTheme.titleLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: context.spacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineMedium,
                    ),
                    SizedBox(height: context.spacing.xs),
                    Text(
                      phone,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: context.spacing.xs),
                    Text(
                      email,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.spacing.sm),
              _EditProfileButton(onPressed: onEditProfile),
            ],
          ),
          SizedBox(height: context.spacing.lg),
          _SupportBanner(supportCount: supportCount),
        ],
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: 'Ubah profil',
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          customBorder: RoundedRectangleBorder(
            borderRadius: context.radius.baseRadius,
          ),
          child: SizedBox(
            width: 48,
            height: 48,
            child: Center(
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: context.radius.baseRadius,
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SupportBanner extends StatelessWidget {
  const _SupportBanner({required this.supportCount});

  final int supportCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: context.radius.mdRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Icon(
              Icons.verified_rounded,
              size: 18,
              color: scheme.secondary,
            ),
          ),
          SizedBox(width: context.spacing.sm),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
                children: [
                  const TextSpan(text: 'Telah mendukung '),
                  TextSpan(
                    text: '$supportCount pesanan',
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: ' warung seblak & rawit lokal'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
