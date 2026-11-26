import 'package:flutter/material.dart';

import '../../../../core/ui/app_category_chip.dart';
import '../mock/home_mock.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final HomeCategory selected;
  final ValueChanged<HomeCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < categories.length; index++) ...[
            AppCategoryChip(
              label: categories[index].label,
              selected: categories[index] == selected,
              onTap: () => onSelected(categories[index]),
            ),
            if (index != categories.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
