import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import 'preference_tile.dart';

/// Judul section + kartu putih berisi baris pengaturan.
///
/// Divider di antara baris di-inset sejajar awal teks judul baris.
class ProfileSectionCard extends StatelessWidget {
  const ProfileSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.trailing,
  });

  final String title;
  final List<Widget> children;

  /// Catatan kecil di kanan judul; turun ke bawah judul saat teks besar.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final titleWidget = Semantics(
      header: true,
      child: Text(
        title,
        style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );

    final Widget header;
    if (trailing == null) {
      header = titleWidget;
    } else if (largeText) {
      header = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget,
          SizedBox(height: context.spacing.xs),
          trailing!,
        ],
      );
    } else {
      header = Row(
        children: [
          Expanded(child: titleWidget),
          SizedBox(width: context.spacing.sm),
          trailing!,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        SizedBox(height: context.spacing.md),
        Material(
          color: scheme.surfaceContainerLowest,
          shape: RoundedRectangleBorder(
            borderRadius: context.radius.lgRadius,
            side: BorderSide(color: scheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < children.length; index++) ...[
                if (index > 0)
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent:
                        context.spacing.md +
                        PreferenceTile.iconSize +
                        context.spacing.md,
                    endIndent: context.spacing.md,
                    color: scheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                children[index],
              ],
            ],
          ),
        ),
      ],
    );
  }
}
