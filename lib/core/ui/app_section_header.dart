import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

/// Nada pill badge pada [AppSectionHeader].
enum AppSectionBadgeTone {
  /// Menandai section yang wajib diisi (pill `secondary-fixed`).
  required,

  /// Menandai section opsional/bebas (pill `surface-container-high`).
  optional,
}

/// Header section dengan aksen bar, judul, pill badge opsional, dan deskripsi.
///
/// Meniru header "Tingkat Kepedasan" pada desain Stitch: bar aksen tipis di
/// kiri judul, pill status di kanan, deskripsi di bawahnya. Tidak memakai
/// margin luar; jarak antar section diatur oleh pemanggil.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
    required this.accent,
    this.badgeLabel,
    this.badgeTone = AppSectionBadgeTone.required,
    this.description,
  });

  final String title;
  final Color accent;
  final String? badgeLabel;
  final AppSectionBadgeTone badgeTone;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final titleRow = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Container(
            width: 8,
            height: 20,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: context.radius.fullRadius,
            ),
          ),
        ),
        SizedBox(width: context.spacing.sm),
        Expanded(
          child: Text(title, maxLines: 3, style: textTheme.headlineMedium),
        ),
        if (badgeLabel != null && !largeText) ...[
          SizedBox(width: context.spacing.sm),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: _BadgePill(label: badgeLabel!, tone: badgeTone),
          ),
        ],
      ],
    );

    return Semantics(
      header: true,
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badgeLabel != null && largeText) ...[
            titleRow,
            SizedBox(height: context.spacing.xs),
            _BadgePill(label: badgeLabel!, tone: badgeTone),
          ] else
            titleRow,
          if (description != null) ...[
            SizedBox(height: context.spacing.xs),
            Text(
              description!,
              style: textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({required this.label, required this.tone});

  final String label;
  final AppSectionBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isRequired = tone == AppSectionBadgeTone.required;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: isRequired ? scheme.secondaryFixed : scheme.surfaceContainerHigh,
        borderRadius: context.radius.fullRadius,
      ),
      child: Text(
        label,
        maxLines: 1,
        style: textTheme.labelSmall?.copyWith(
          color: isRequired ? scheme.onSecondaryFixed : scheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
