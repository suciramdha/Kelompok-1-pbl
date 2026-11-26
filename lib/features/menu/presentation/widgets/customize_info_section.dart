import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';

class CustomizeInfoSection extends StatelessWidget {
  const CustomizeInfoSection({
    super.key,
    required this.name,
    this.cookTime,
    required this.description,
  });

  final String name;
  final String? cookTime;
  final String description;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.spacing.margin,
        context.spacing.lg,
        context.spacing.margin,
        context.spacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: textTheme.headlineLarge),
          if (cookTime != null) ...[
            SizedBox(height: context.spacing.xs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.schedule_rounded, size: 14, color: scheme.secondary),
                SizedBox(width: context.spacing.xs),
                Flexible(
                  child: Text(
                    cookTime!,
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: context.spacing.xs),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
