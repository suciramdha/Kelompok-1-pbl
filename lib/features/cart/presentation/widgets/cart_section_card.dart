import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';

/// Permukaan kartu putih dengan border lembut khas section Cart.
class CartCardSurface extends StatelessWidget {
  const CartCardSurface({
    super.key,
    required this.child,
    this.padding,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding ?? EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: color ?? scheme.surfaceContainerLowest,
        borderRadius: context.radius.lgRadius,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: child,
    );
  }
}

/// Kartu section berjudul: header ikon + judul, lalu isi berjarak seragam.
class CartSectionCard extends StatelessWidget {
  const CartSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
    this.trailing,
    this.gap,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  /// Label kecil di kanan judul; turun ke bawah judul saat teks besar.
  final Widget? trailing;

  /// Jarak antar isi; default `spacing.md`.
  final double? gap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;
    final effectiveGap = gap ?? spacing.md;

    final titleWidget = Semantics(
      header: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: scheme.secondary),
          SizedBox(width: spacing.sm),
          Expanded(
            child: Text(
              title,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
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
          SizedBox(height: spacing.xs),
          trailing!,
        ],
      );
    } else {
      header = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: titleWidget),
          SizedBox(width: spacing.sm),
          trailing!,
        ],
      );
    }

    return CartCardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          for (final child in children) ...[
            SizedBox(height: effectiveGap),
            child,
          ],
        ],
      ),
    );
  }
}
