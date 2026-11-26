import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

enum AppButtonVariant { primary, secondary, neutral, onBrand, ghost, danger }

enum AppButtonIconPosition { leading, trailing }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.iconPosition = AppButtonIconPosition.leading,
    this.isLoading = false,
    this.expand = false,
    this.labelMaxLines = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final AppButtonIconPosition iconPosition;
  final bool isLoading;
  final bool expand;
  final int labelMaxLines;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final enabled = onPressed != null && !isLoading;

    final (background, foreground, border) = switch (variant) {
      AppButtonVariant.primary => (scheme.primary, scheme.onPrimary, null),
      AppButtonVariant.secondary => (
        scheme.surfaceContainerLow,
        scheme.secondary,
        scheme.outlineVariant,
      ),
      AppButtonVariant.neutral => (
        scheme.surfaceContainerLow,
        scheme.onSurface,
        scheme.outlineVariant,
      ),
      AppButtonVariant.onBrand => (scheme.onPrimary, scheme.primary, null),
      AppButtonVariant.ghost => (Colors.transparent, scheme.primary, null),
      AppButtonVariant.danger => (scheme.error, scheme.onError, null),
    };

    final disabledBackground = scheme.onSurface.withValues(alpha: 0.12);
    final disabledForeground = scheme.onSurface.withValues(alpha: 0.38);
    final effectiveForeground = enabled ? foreground : disabledForeground;
    final effectiveLabelStyle = textTheme.labelLarge?.copyWith(
      color: effectiveForeground,
      fontWeight: FontWeight.w700,
    );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: effectiveForeground,
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null &&
            iconPosition == AppButtonIconPosition.leading) ...[
          Icon(icon, size: 18, color: effectiveForeground),
          const SizedBox(width: 8),
        ],
        if (expand)
          Flexible(
            child: Text(
              label,
              maxLines: labelMaxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: effectiveLabelStyle,
            ),
          )
        else
          Text(
            label,
            maxLines: labelMaxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: effectiveLabelStyle,
          ),
        if (!isLoading &&
            icon != null &&
            iconPosition == AppButtonIconPosition.trailing) ...[
          const SizedBox(width: 8),
          Icon(icon, size: 18, color: effectiveForeground),
        ],
      ],
    );

    final style = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.zero),
      padding: WidgetStatePropertyAll(padding),
      tapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: context.radius.baseRadius),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return disabledBackground;
        return background;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return disabledForeground;
        return foreground;
      }),
      iconColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return disabledForeground;
        return foreground;
      }),
      side: border == null
          ? null
          : WidgetStateProperty.resolveWith((states) {
              return BorderSide(
                color: states.contains(WidgetState.disabled)
                    ? scheme.outlineVariant.withValues(alpha: 0.5)
                    : border,
              );
            }),
      textStyle: WidgetStatePropertyAll(effectiveLabelStyle),
    );

    final button = switch (variant) {
      AppButtonVariant.secondary || AppButtonVariant.neutral => OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: style,
        child: content,
      ),
      AppButtonVariant.ghost => TextButton(
        onPressed: enabled ? onPressed : null,
        style: style,
        child: content,
      ),
      _ => FilledButton(
        onPressed: enabled ? onPressed : null,
        style: style,
        child: content,
      ),
    };

    return Semantics(
      button: true,
      enabled: enabled,
      label: isLoading ? 'Memuat' : label,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}
