import 'package:flutter/material.dart';

class AppAddButton extends StatelessWidget {
  const AppAddButton({
    super.key,
    required this.onPressed,
    required this.semanticLabel,
    this.visualSize = 48,
    this.hitSize = 48,
  });

  final VoidCallback onPressed;
  final String semanticLabel;
  final double visualSize;
  final double hitSize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: SizedBox(
        width: hitSize,
        height: hitSize,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Center(
              child: Container(
                width: visualSize,
                height: visualSize,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: scheme.onPrimary,
                  size: visualSize * 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
