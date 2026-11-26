import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';

class CustomizeToast extends StatelessWidget {
  const CustomizeToast({
    super.key,
    required this.visible,
    required this.message,
  });

  final bool visible;
  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ExcludeSemantics(
      excluding: !visible,
      child: IgnorePointer(
        child: AnimatedSlide(
          duration: context.motion.normal,
          curve: context.motion.standard,
          offset: visible ? Offset.zero : const Offset(0, -0.2),
          child: AnimatedOpacity(
            duration: context.motion.fast,
            opacity: visible ? 1 : 0,
            child: Center(
              child: Semantics(
                liveRegion: true,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.lg,
                    vertical: context.spacing.sm + 2,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.inverseSurface,
                    borderRadius: context.radius.fullRadius,
                    boxShadow: context.elevation.floating,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        size: 20,
                        color: scheme.secondaryFixed,
                      ),
                      SizedBox(width: context.spacing.sm),
                      Flexible(
                        child: Text(
                          message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelMedium?.copyWith(
                            color: scheme.onInverseSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
