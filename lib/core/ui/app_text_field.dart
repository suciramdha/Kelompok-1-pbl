import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

/// Field group lengkap untuk form: baris label, input, dan helper/error.
///
/// Memakai [TextFormField] sehingga [validator] berjalan di dalam [Form].
/// Label [labelTrailing] biasanya berisi aksi kecil (mis. "Lupa kata sandi").
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.leadingIcon,
    this.labelTrailing,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.maxLength,
    this.helperText,
    this.focusNode,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;

  /// Ikon dekoratif di kiri input; tidak dibacakan ke screen reader.
  final IconData? leadingIcon;

  /// Slot di kanan baris label.
  final Widget? labelTrailing;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final bool obscureText;

  /// Bila diisi, counter karakter bawaan disembunyikan (tanpa counter palsu).
  final int? maxLength;

  /// Teks bantuan di bawah input; tertimpa oleh pesan validasi saat error.
  final String? helperText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final radius = context.radius;
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final effectiveForeground = (readOnly || !enabled)
        ? scheme.onSurfaceVariant
        : scheme.onSurface;

    final labelText = Text(
      label,
      style: textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
    );

    final Widget labelRow;
    if (labelTrailing == null) {
      labelRow = labelText;
    } else if (textScale > 1.5) {
      labelRow = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          labelText,
          SizedBox(height: spacing.xs),
          labelTrailing!,
        ],
      );
    } else {
      labelRow = Row(
        children: [
          Expanded(child: labelText),
          SizedBox(width: spacing.sm),
          labelTrailing!,
        ],
      );
    }

    final border = OutlineInputBorder(
      borderRadius: radius.baseRadius,
      borderSide: BorderSide(color: scheme.outlineVariant),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        labelRow,
        SizedBox(height: spacing.xs),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            enabled: enabled,
            readOnly: readOnly,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autofillHints: autofillHints,
            validator: validator,
            onChanged: onChanged,
            textCapitalization: textCapitalization,
            obscureText: obscureText,
            maxLength: maxLength,
            style: textTheme.bodyMedium?.copyWith(color: effectiveForeground),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: scheme.surfaceContainerLow,
              contentPadding: EdgeInsets.only(
                left: leadingIcon == null ? spacing.lg : 0,
                right: spacing.lg,
                top: spacing.md,
                bottom: spacing.md,
              ),
              counterText: maxLength == null ? null : '',
              helperText: helperText,
              helperStyle: textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              errorStyle: textTheme.bodySmall?.copyWith(color: scheme.error),
              errorMaxLines: 2,
              prefixIcon: leadingIcon == null
                  ? null
                  : ExcludeSemantics(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: spacing.sm),
                        child: Icon(
                          leadingIcon,
                          size: 20,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 48,
              ),
              border: border,
              enabledBorder: border,
              focusedBorder: OutlineInputBorder(
                borderRadius: radius.baseRadius,
                borderSide: BorderSide(
                  color: scheme.secondaryContainer,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: radius.baseRadius,
                borderSide: BorderSide(color: scheme.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: radius.baseRadius,
                borderSide: BorderSide(color: scheme.error, width: 2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: radius.baseRadius,
                borderSide: BorderSide(
                  color: scheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
