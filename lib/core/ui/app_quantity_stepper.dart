import 'package:flutter/material.dart';

import 'app_add_button.dart';

const double _kButtonSize = 32;

class AppQuantityStepper extends StatelessWidget {
  const AppQuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max,
    this.semanticItemName,
    this.collapseAtMin = false,
    this.emphasizeIncrease = false,
    this.onDecrementAtMin,
    this.decrementAtMinSemanticLabel,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;

  /// Batas atas qty; `null` berarti tanpa batas.
  final int? max;

  /// Nama item untuk label aksesibilitas, mis. `Tambah porsi Bakso Sapi`.
  final String? semanticItemName;

  /// Hanya untuk konteks di mana qty 0 cukup menampilkan tombol tambah saja;
  /// counter minus/nilai/plus muncul setelah qty bertambah.
  final bool collapseAtMin;

  /// Tombol tambah memakai `primary`/`onPrimary`, mengikuti Stitch Kustomisasi.
  final bool emphasizeIncrease;

  /// Dipanggil saat tombol `−` ditekan pada qty minimum, mis. untuk konfirmasi
  /// hapus item keranjang. Jika null, tombol `−` disabled pada qty minimum.
  final VoidCallback? onDecrementAtMin;

  /// Label a11y alternatif untuk tombol `−` pada qty minimum.
  final String? decrementAtMinSemanticLabel;

  String get _decreaseLabel {
    if (value <= min &&
        onDecrementAtMin != null &&
        decrementAtMinSemanticLabel != null) {
      return decrementAtMinSemanticLabel!;
    }
    return semanticItemName == null
        ? 'Kurangi porsi'
        : 'Kurangi porsi $semanticItemName';
  }

  String get _increaseLabel => semanticItemName == null
      ? 'Tambah porsi'
      : 'Tambah porsi $semanticItemName';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final canDecrease = value > min || onDecrementAtMin != null;
    final canIncrease = max == null || value < max!;

    if (collapseAtMin && value <= min && canIncrease) {
      return AppAddButton(
        visualSize: _kButtonSize,
        hitSize: _kButtonSize,
        semanticLabel: _increaseLabel,
        onPressed: () => onChanged(value + 1),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepButton(
          icon: Icons.remove_rounded,
          semanticLabel: _decreaseLabel,
          enabled: canDecrease,
          onTap: () {
            if (value > min) {
              onChanged(value - 1);
            } else {
              onDecrementAtMin?.call();
            }
          },
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 20),
          child: Text(
            '$value',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        _StepButton(
          icon: Icons.add_rounded,
          semanticLabel: _increaseLabel,
          enabled: canIncrease,
          backgroundColor: emphasizeIncrease ? scheme.primary : null,
          foregroundColor: emphasizeIncrease ? scheme.onPrimary : null,
          onTap: () => onChanged(value + 1),
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.semanticLabel,
    required this.onTap,
    this.enabled = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback onTap;
  final bool enabled;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final effectiveBackground = enabled
        ? (backgroundColor ?? scheme.surfaceContainerLowest)
        : scheme.surfaceContainerLowest;
    final effectiveForeground = enabled
        ? (foregroundColor ?? scheme.onSurface)
        : scheme.onSurface.withValues(alpha: 0.38);

    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel,
      child: SizedBox(
        width: _kButtonSize,
        height: _kButtonSize,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            customBorder: const CircleBorder(),
            child: Container(
              width: _kButtonSize,
              height: _kButtonSize,
              decoration: BoxDecoration(
                color: effectiveBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: effectiveForeground),
            ),
          ),
        ),
      ),
    );
  }
}
