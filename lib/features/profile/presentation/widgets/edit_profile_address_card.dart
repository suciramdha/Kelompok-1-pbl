import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_badge.dart';

/// Kartu "Alamat Pengiriman Utama" pada halaman Edit Profil: alamat terpilih
/// dan tombol menuju pengelolaan daftar alamat.
class EditProfileAddressCard extends StatelessWidget {
  const EditProfileAddressCard({
    super.key,
    required this.addressLabel,
    required this.address,
    required this.onManageAddresses,
  });

  final String addressLabel;
  final String address;
  final VoidCallback onManageAddresses;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final titleRow = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(
          child: Icon(
            Icons.location_on_rounded,
            size: 22,
            color: scheme.primary,
          ),
        ),
        SizedBox(width: spacing.sm),
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              'Alamat Pengiriman Utama',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );

    const badge = AppBadge(label: 'Utama', tone: AppBadgeTone.brand);

    final Widget header;
    if (largeText) {
      header = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRow,
          SizedBox(height: spacing.xs),
          badge,
        ],
      );
    } else {
      header = Row(
        children: [
          Expanded(child: titleRow),
          SizedBox(width: spacing.sm),
          badge,
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(spacing.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: context.radius.lgRadius,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          SizedBox(height: spacing.lg),
          Container(
            padding: EdgeInsets.all(spacing.md),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: context.radius.mdRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ExcludeSemantics(
                      child: Icon(
                        Icons.home_rounded,
                        size: 18,
                        color: scheme.secondary,
                      ),
                    ),
                    SizedBox(width: spacing.sm),
                    Expanded(
                      child: Text(
                        addressLabel,
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing.sm),
                Text(
                  address,
                  style: textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spacing.md),
          Semantics(
            button: true,
            child: Material(
              color: scheme.surfaceContainer,
              borderRadius: context.radius.baseRadius,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onManageAddresses,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.md,
                      vertical: spacing.sm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExcludeSemantics(
                          child: Icon(
                            Icons.edit_location_alt_rounded,
                            size: 18,
                            color: scheme.onSurface,
                          ),
                        ),
                        SizedBox(width: spacing.sm),
                        Flexible(
                          child: Text(
                            'Kelola Daftar Alamat',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: spacing.sm),
                        ExcludeSemantics(
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
                            color: scheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
