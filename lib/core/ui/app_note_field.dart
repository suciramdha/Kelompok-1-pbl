import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

class AppNoteField extends StatelessWidget {
  const AppNoteField({
    super.key,
    required this.controller,
    this.maxLength = 120,
    this.hintText = 'Tulis instruksi khusus buat juru masak warung di sini...',
    this.minLines = 3,
    this.maxLines = 3,
    this.showCounter = true,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
  });

  final TextEditingController controller;
  final int maxLength;
  final String hintText;
  final int minLines;
  final int maxLines;

  /// `false` menyembunyikan counter karakter (mis. catatan satu baris).
  final bool showCounter;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: controller,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: TextCapitalization.sentences,
      style: textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textTheme.bodyMedium?.copyWith(color: scheme.outlineVariant),
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        contentPadding: EdgeInsets.all(context.spacing.md),
        border: OutlineInputBorder(
          borderRadius: context.radius.mdRadius,
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: context.radius.mdRadius,
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: context.radius.mdRadius,
          borderSide: BorderSide(color: scheme.secondaryContainer, width: 2),
        ),
      ),
      buildCounter:
          (context, {required currentLength, required isFocused, maxLength}) {
            if (!showCounter) return null;
            return Text(
              '$currentLength/$maxLength',
              style: textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            );
          },
    );
  }
}
