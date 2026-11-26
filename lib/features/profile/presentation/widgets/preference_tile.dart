import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';

/// Baris pengaturan pada kartu section Profil.
///
/// Tidak memiliki deskripsi/subtitle: hanya ikon, judul, dan trailing opsional.
/// Divider antar baris dimiliki oleh [ProfileSectionCard], bukan oleh tile.
class PreferenceTile extends StatelessWidget {
  const PreferenceTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.titleTrailing,
    this.showChevron = false,
    this.iconColor,
    this.backgroundColor,
  });

  /// Ukuran ikon leading; dipakai juga oleh section card untuk inset divider.
  static const double iconSize = 24;

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;

  /// Elemen dekoratif setelah judul, misalnya titik status.
  final Widget? titleTrailing;
  final bool showChevron;

  /// Warna ikon leading; default `onSurfaceVariant`.
  final Color? iconColor;

  /// Latar baris opsional, misalnya untuk baris versi aplikasi.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      button: onTap != null,
      child: Container(
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.radius.baseRadius,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 56),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.spacing.md,
                vertical: context.spacing.md,
              ),
              child: Row(
                children: [
                  ExcludeSemantics(
                    child: Icon(
                      icon,
                      size: iconSize,
                      color: iconColor ?? scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(width: context.spacing.md),
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                        if (titleTrailing != null)
                          Padding(
                            padding: EdgeInsets.only(left: context.spacing.xs),
                            child: titleTrailing,
                          ),
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    SizedBox(width: context.spacing.sm),
                    trailing!,
                  ],
                  if (showChevron) ...[
                    SizedBox(width: context.spacing.xs),
                    ExcludeSemantics(
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
