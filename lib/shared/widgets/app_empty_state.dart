import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';
import '../../core/ui/app_button.dart';

/// Empty state layar penuh: ikon, judul, pesan, dan CTA opsional.
///
/// Konten berada dalam scroll view agar aman saat text scale 2.0 dan keyboard
/// terbuka pada layar 320 dp.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: context.radius.xlRadius,
                ),
                child: Icon(icon, size: 34, color: scheme.primary),
              ),
              SizedBox(height: spacing.lg),
              Semantics(
                header: true,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: spacing.sm),
              Text(
                message,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                SizedBox(height: spacing.xl),
                AppButton(label: actionLabel!, onPressed: onAction),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
