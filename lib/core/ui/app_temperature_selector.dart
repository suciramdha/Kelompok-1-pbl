import 'package:flutter/material.dart';

import '../../app/theme/theme_context.dart';

class AppTemperatureSelector extends StatelessWidget {
  const AppTemperatureSelector({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<String> options;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < options.length; index++) ...[
          _TemperatureCard(
            label: options[index],
            selected: options[index] == selected,
            onTap: () => onChanged(options[index]),
          ),
          if (index != options.length - 1) SizedBox(height: context.spacing.md),
        ],
      ],
    );
  }
}

class _TemperatureCard extends StatelessWidget {
  const _TemperatureCard({
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
    final icon = switch (label.toLowerCase()) {
      'dingin' => Icons.ac_unit_rounded,
      'panas' => Icons.local_fire_department_rounded,
      _ => Icons.thermostat_rounded,
    };

    return Semantics(
      button: true,
      inMutuallyExclusiveGroup: true,
      checked: selected,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: selected
            ? scheme.primaryFixed.withValues(alpha: 0.2)
            : scheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: context.radius.mdRadius,
          side: BorderSide(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(context.spacing.lg),
            child: Row(
              children: [
                _RadioIndicator(selected: selected),
                SizedBox(width: context.spacing.md),
                Icon(icon, size: 20, color: scheme.secondary),
                SizedBox(width: context.spacing.sm),
                Expanded(child: Text(label, style: textTheme.titleMedium)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: selected ? scheme.primary : scheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: selected ? scheme.onPrimary : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
