import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_button.dart';

/// Drawer edit catatan item: textarea borderless setinggi sheet.
class CartItemNoteSheet extends StatefulWidget {
  const CartItemNoteSheet({super.key, required this.initialNote});

  final String initialNote;

  @override
  State<CartItemNoteSheet> createState() => _CartItemNoteSheetState();
}

class _CartItemNoteSheetState extends State<CartItemNoteSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNote)
      ..selection = TextSelection.collapsed(offset: widget.initialNote.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom;
    final height = (media.size.height - media.padding.top - keyboard) * 0.9;

    return AnimatedPadding(
      duration: context.motion.fast,
      curve: context.motion.standard,
      padding: EdgeInsets.only(bottom: keyboard),
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: spacing.md, bottom: spacing.sm),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.outlineVariant,
                    borderRadius: context.radius.fullRadius,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                spacing.lg,
                0,
                spacing.sm,
                spacing.sm,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Tambah Catatan untuk Pembelian',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Tutup',
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: scheme.outlineVariant.withValues(alpha: 0.6),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  spacing.lg,
                  spacing.md,
                  spacing.lg,
                  0,
                ),
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  style: textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'tulis permintaan khusus di sini ya',
                    hintStyle: textTheme.bodyLarge?.copyWith(
                      color: scheme.outlineVariant,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spacing.lg),
              child: AppButton(label: 'Simpan', expand: true, onPressed: _save),
            ),
          ],
        ),
      ),
    );
  }
}
