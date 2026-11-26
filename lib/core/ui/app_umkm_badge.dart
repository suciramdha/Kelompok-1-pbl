import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

class AppUmkmBadge extends StatelessWidget {
  const AppUmkmBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: scheme.secondaryFixed,
        borderRadius: context.radius.fullRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            size: 12,
            color: scheme.onSecondaryFixed,
          ),
          const SizedBox(width: 3),
          Text(
            'UMKM',
            style: textTheme.labelSmall?.copyWith(
              color: scheme.onSecondaryFixed,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
