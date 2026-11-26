import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/theme_context.dart';
import '../providers/profile_provider.dart';
import '../widgets/preference_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_section_card.dart';
import '../widgets/profile_summary_card.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _orderNotifications = true;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleOrderNotifications() {
    setState(() => _orderNotifications = !_orderNotifications);
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        ProfileHeader(
          onNotifications: () => _showMessage('Belum ada notifikasi baru.'),
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              context.spacing.margin,
              context.spacing.lg,
              context.spacing.margin,
              context.spacing.xl,
            ),
            children: [
              ProfileSummaryCard(
                name: profile.name,
                phone: profile.phone,
                email: profile.email,
                supportCount: profile.supportCount,
                onEditProfile: () => context.push(AppRoutes.profileEdit),
              ),
              SizedBox(height: context.spacing.lg),
              _FavoritesCard(
                count: profile.favoriteCount,
                summary: profile.favoriteSummary,
                onTap: () =>
                    _showMessage('Menu favorit belum tersedia di prototype.'),
              ),
              SizedBox(height: context.spacing.xl),
              ProfileSectionCard(
                title: 'Preferensi',
                trailing: Text(
                  'Transaksi Aman',
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                children: [
                  PreferenceTile(
                    icon: Icons.location_on_outlined,
                    title: 'Alamat Tersimpan',
                    trailing: _PillBadge(
                      label: 'Utama',
                      background: scheme.secondaryFixed,
                      foreground: scheme.onSecondaryFixed,
                    ),
                    showChevron: true,
                    onTap: () => _showMessage(
                      'Ubah alamat belum tersedia di prototype.',
                    ),
                  ),
                  PreferenceTile(
                    icon: Icons.receipt_long_outlined,
                    title: 'Riwayat Transaksi & E-Nota',
                    showChevron: true,
                    onTap: () => _showMessage(
                      'Riwayat transaksi belum tersedia di prototype.',
                    ),
                  ),
                  PreferenceTile(
                    icon: Icons.notifications_active_outlined,
                    title: 'Notifikasi Pesanan & Promo',
                    trailing: _OrderNotificationSwitch(
                      label: 'Notifikasi Pesanan & Promo',
                      value: _orderNotifications,
                      onChanged: (value) =>
                          setState(() => _orderNotifications = value),
                    ),
                    onTap: _toggleOrderNotifications,
                  ),
                ],
              ),
              SizedBox(height: context.spacing.xl),
              ProfileSectionCard(
                title: 'Lainnya',
                children: [
                  PreferenceTile(
                    icon: Icons.support_agent_rounded,
                    title: 'Chat Admin Warung 24 Jam',
                    iconColor: scheme.primary,
                    titleTrailing: const _LiveDot(),
                    showChevron: true,
                    onTap: () =>
                        _showMessage('Chat admin belum tersedia di prototype.'),
                  ),
                  PreferenceTile(
                    icon: Icons.description_outlined,
                    title: 'Ketentuan Pemesanan & Mitra UMKM',
                    showChevron: true,
                    onTap: () => _showMessage(
                      'Ketentuan pemesanan belum tersedia di prototype.',
                    ),
                  ),
                  PreferenceTile(
                    icon: Icons.star_rounded,
                    title: 'Beri Nilai Aplikasi Seblak Lokuak',
                    iconColor: scheme.secondaryContainer,
                    showChevron: true,
                    onTap: () => _showMessage(
                      'Beri nilai aplikasi belum tersedia di prototype.',
                    ),
                  ),
                  PreferenceTile(
                    icon: Icons.info_outline_rounded,
                    title: 'Seblak Lokuak',
                    trailing: Text(
                      'Terbaru',
                      style: textTheme.labelSmall?.copyWith(
                        color: scheme.outline,
                      ),
                    ),
                    backgroundColor: scheme.surfaceContainerLow.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.spacing.xl),
              _LogoutButton(
                onPressed: () => _showMessage(
                  'Keluar dari akun belum tersedia di prototype.',
                ),
              ),
              SizedBox(height: context.spacing.md),
              Text(
                'ID Pengguna: ${profile.userId} • '
                'Terdaftar sejak ${profile.memberSince}',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FavoritesCard extends StatelessWidget {
  const _FavoritesCard({
    required this.count,
    required this.summary,
    required this.onTap,
  });

  final int count;
  final String summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: context.radius.lgRadius,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(context.spacing.lg),
          child: Row(
            children: [
              ExcludeSemantics(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: context.radius.baseRadius,
                  ),
                  child: Icon(
                    Icons.favorite_rounded,
                    size: 22,
                    color: scheme.primary,
                  ),
                ),
              ),
              SizedBox(width: context.spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu Favorit Saya ($count)',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: context.spacing.xs),
                    Text(
                      summary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.spacing.sm),
              ExcludeSemantics(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: context.radius.baseRadius,
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderNotificationSwitch extends StatelessWidget {
  const _OrderNotificationSwitch({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final duration = reduceMotion ? Duration.zero : context.motion.fast;

    return Semantics(
      label: label,
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: duration,
          curve: context.motion.standard,
          width: 48,
          height: 24,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: value ? scheme.primary : scheme.surfaceContainerHighest,
            borderRadius: context.radius.fullRadius,
          ),
          child: AnimatedAlign(
            duration: duration,
            curve: context.motion.standard,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: scheme.onPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatefulWidget {
  const _LogoutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<_LogoutButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    return Semantics(
      button: true,
      child: InkWell(
        onTap: widget.onPressed,
        onHighlightChanged: (pressed) => setState(() => _pressed = pressed),
        borderRadius: context.radius.lgRadius,
        child: AnimatedScale(
          scale: _pressed && !reduceMotion ? 0.98 : 1,
          duration: reduceMotion ? Duration.zero : context.motion.fast,
          curve: context.motion.standard,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 48),
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.lg,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: context.radius.lgRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExcludeSemantics(
                  child: Icon(
                    Icons.logout_rounded,
                    size: 20,
                    color: scheme.primary,
                  ),
                ),
                SizedBox(width: context.spacing.sm),
                Flexible(
                  child: Text(
                    'Keluar dari Akun',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: scheme.primary,
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

class _PillBadge extends StatelessWidget {
  const _PillBadge({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm,
        vertical: context.spacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radius.fullRadius,
      ),
      child: Text(
        label,
        maxLines: 1,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: foreground, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _LiveDot extends StatelessWidget {
  const _LiveDot();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ExcludeSemantics(
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: scheme.secondaryContainer,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
