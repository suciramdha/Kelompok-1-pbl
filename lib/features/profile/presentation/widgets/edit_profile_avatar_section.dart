import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/ui/app_network_image.dart';

/// Bagian avatar halaman Edit Profil: foto bulat, badge kamera, aksi ubah
/// foto, dan keterangan format berkas.
class EditProfileAvatarSection extends StatelessWidget {
  const EditProfileAvatarSection({
    super.key,
    required this.name,
    required this.avatarSeed,
    required this.onChangePhoto,
  });

  final String name;
  final String avatarSeed;
  final VoidCallback onChangePhoto;

  static const _avatarSize = 96.0;
  static const _cameraBadgeSize = 36.0;
  static const _cameraBadgeInset = 6.0;
  static const _cameraIconSize = 19.0;

  /// Frame avatar diberi ruang [_cameraBadgeInset] di tiap sisi agar hit
  /// target 48 badge kamera seluruhnya berada di dalam Stack.
  static const _avatarFrameSize = _avatarSize + _cameraBadgeInset * 2;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return Column(
      children: [
        SizedBox(
          width: _avatarFrameSize,
          height: _avatarFrameSize,
          child: Stack(
            children: [
              Positioned(
                left: _cameraBadgeInset,
                top: _cameraBadgeInset,
                width: _avatarSize,
                height: _avatarSize,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: context.elevation.card,
                  ),
                  child: AppNetworkImage(
                    url: RemoteImages.avatar(avatarSeed, size: 240),
                    width: _avatarSize,
                    height: _avatarSize,
                    borderRadius: context.radius.fullRadius,
                    semanticLabel: 'Foto profil $name',
                    errorWidget: Container(
                      width: _avatarSize,
                      height: _avatarSize,
                      color: scheme.surfaceContainerLow,
                      alignment: Alignment.center,
                      child: Text(
                        _initialsOf(name),
                        style: textTheme.headlineMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: _CameraBadgeButton(
                  size: _cameraBadgeSize,
                  iconSize: _cameraIconSize,
                  onPressed: onChangePhoto,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spacing.md),
        _ChangePhotoButton(onPressed: onChangePhoto),
        SizedBox(height: spacing.xs),
        Text(
          'Format JPG, PNG maks. 5MB',
          textAlign: TextAlign.center,
          style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

/// Badge kamera: lingkaran visual 36 di dalam hit target 48.
class _CameraBadgeButton extends StatelessWidget {
  const _CameraBadgeButton({
    required this.size,
    required this.iconSize,
    required this.onPressed,
  });

  final double size;
  final double iconSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: 'Ubah foto profil',
      onTap: onPressed,
      excludeSemantics: true,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.photo_camera_rounded,
                size: iconSize,
                color: scheme.onSecondaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChangePhotoButton extends StatelessWidget {
  const _ChangePhotoButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return Semantics(
      button: true,
      child: InkWell(
        onTap: onPressed,
        borderRadius: context.radius.baseRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Ubah Foto Profil',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: spacing.sm),
                ExcludeSemantics(
                  child: Icon(
                    Icons.edit_rounded,
                    size: 18,
                    color: scheme.primary,
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

/// Inisial dua huruf dari nama lengkap; dipakai saat foto gagal dimuat.
String _initialsOf(String name) {
  final words = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();
  if (words.isEmpty) return '?';
  if (words.length == 1) return words.first.substring(0, 1).toUpperCase();
  return (words.first.substring(0, 1) + words.last.substring(0, 1))
      .toUpperCase();
}
