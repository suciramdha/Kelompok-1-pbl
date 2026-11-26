import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_note_field.dart';
import 'cart_section_card.dart';

/// Section catatan driver: quick tag multi-select + field instruksi tambahan.
class DriverNoteCard extends StatelessWidget {
  const DriverNoteCard({
    super.key,
    required this.controller,
    required this.maxLength,
    required this.tags,
    required this.selectedTags,
    required this.onToggleTag,
  });

  final TextEditingController controller;
  final int maxLength;
  final List<String> tags;
  final Set<String> selectedTags;
  final ValueChanged<String> onToggleTag;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return CartSectionCard(
      icon: Icons.delivery_dining_rounded,
      title: 'Catatan untuk Driver',
      gap: spacing.sm,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var index = 0; index < tags.length; index++) ...[
                if (index > 0) SizedBox(width: spacing.sm),
                _NoteTag(
                  label: tags[index],
                  selected: selectedTags.contains(tags[index]),
                  onTap: () => onToggleTag(tags[index]),
                ),
              ],
            ],
          ),
        ),
        AppNoteField(
          controller: controller,
          maxLength: maxLength,
          hintText: 'Tulis instruksi tambahan bagi driver...',
          minLines: 1,
          maxLines: 1,
          showCounter: false,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

class _NoteTag extends StatelessWidget {
  const _NoteTag({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.radius.fullRadius,
          child: SizedBox(
            height: 48,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.lg,
                  vertical: spacing.sm,
                ),
                decoration: BoxDecoration(
                  color: selected ? scheme.primary : scheme.surfaceContainerLow,
                  borderRadius: context.radius.fullRadius,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selected) ...[
                      Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: scheme.onPrimary,
                      ),
                      SizedBox(width: spacing.xs),
                    ],
                    Text(
                      label,
                      maxLines: 1,
                      style: textTheme.labelMedium?.copyWith(
                        color: selected ? scheme.onPrimary : scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
