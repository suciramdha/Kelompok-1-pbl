import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.ordersBadgeCount = 3,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final int ordersBadgeCount;

  static const _items = [
    (
      label: 'Beranda',
      icon: Icons.storefront_outlined,
      active: Icons.storefront,
    ),
    (
      label: 'Pesanan',
      icon: Icons.receipt_long_outlined,
      active: Icons.receipt_long,
    ),
    (
      label: 'Profil',
      icon: Icons.person_outline_rounded,
      active: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.95),
            border: Border(
              top: BorderSide(
                color: scheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            boxShadow: context.elevation.header,
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 72,
              child: Row(
                children: [
                  for (var index = 0; index < _items.length; index++)
                    Expanded(
                      child: _NavItem(
                        label: _items[index].label,
                        icon: currentIndex == index
                            ? _items[index].active
                            : _items[index].icon,
                        selected: currentIndex == index,
                        badgeCount: index == 1 ? ordersBadgeCount : null,
                        textTheme: textTheme,
                        onTap: () => onTap(index),
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

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.textTheme,
    required this.onTap,
    this.badgeCount,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final TextTheme textTheme;
  final VoidCallback onTap;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, size: 24, color: color),
                  if (badgeCount != null)
                    Positioned(
                      right: -8,
                      top: -5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          borderRadius: context.radius.fullRadius,
                        ),
                        child: Text(
                          '$badgeCount',
                          style: textTheme.labelSmall?.copyWith(
                            color: scheme.onPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
