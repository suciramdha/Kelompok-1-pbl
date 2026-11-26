import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../shared/widgets/app_dish_card.dart';
import '../../../../shared/widgets/app_dish_grid_card.dart';
import '../mock/home_mock.dart';

enum MenuSectionLayout { list, snackGrid }

class MenuSection extends StatelessWidget {
  const MenuSection({
    super.key,
    required this.title,
    required this.icon,
    required this.dishes,
    required this.onDishTap,
    this.layout = MenuSectionLayout.list,
  });

  final String title;
  final IconData icon;
  final List<DishModel> dishes;
  final ValueChanged<DishModel> onDishTap;
  final MenuSectionLayout layout;

  @override
  Widget build(BuildContext context) {
    if (dishes.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final useGrid =
        layout == MenuSectionLayout.snackGrid &&
        MediaQuery.sizeOf(context).width >= 360 &&
        MediaQuery.textScalerOf(context).scale(1) <= 1.25 &&
        dishes.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                borderRadius: context.radius.baseRadius,
              ),
              child: Icon(icon, size: 18, color: scheme.primary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                borderRadius: context.radius.fullRadius,
              ),
              child: Text(
                '${dishes.length} Menu',
                style: textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (useGrid)
          _SnackGrid(dishes: dishes, onDishTap: onDishTap)
        else
          _DishList(dishes: dishes, onDishTap: onDishTap),
      ],
    );
  }
}

class _DishList extends StatelessWidget {
  const _DishList({required this.dishes, required this.onDishTap});

  final List<DishModel> dishes;
  final ValueChanged<DishModel> onDishTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: dishes.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final dish = dishes[index];
        return AppDishCard(
          name: dish.name,
          description: dish.description,
          price: dish.price,
          imageUrl: RemoteImages.dish(dish.imageSeed),
          spiceLevel: dish.spiceLevel,
          spiceLabel: dish.spiceLabel,
          badge: dish.badge,
          onTap: () => onDishTap(dish),
        );
      },
    );
  }
}

class _SnackGrid extends StatelessWidget {
  const _SnackGrid({required this.dishes, required this.onDishTap});

  final List<DishModel> dishes;
  final ValueChanged<DishModel> onDishTap;

  @override
  Widget build(BuildContext context) {
    const gap = 12.0;
    const horizontalPadding = 10.0 * 2;
    const priceRowHeight = 26.0;
    const titleLineHeight = 22.0;
    const bodyLineHeight = 16.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(context).scale(1);
        final cardWidth = (constraints.maxWidth - gap) / 2;
        final imageHeight = cardWidth / 1.5;
        final cardHeight =
            imageHeight +
            horizontalPadding +
            (titleLineHeight * scale) +
            2 +
            (bodyLineHeight * scale) +
            8 +
            priceRowHeight;
        final gridCount = dishes.length.isOdd
            ? dishes.length - 1
            : dishes.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (gridCount > 0)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: gridCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: gap,
                  mainAxisSpacing: gap,
                  mainAxisExtent: cardHeight,
                ),
                itemBuilder: (context, index) {
                  final dish = dishes[index];
                  return AppDishGridCard(
                    name: dish.name,
                    description: dish.description,
                    price: dish.price,
                    imageUrl: RemoteImages.dish(dish.imageSeed),
                    spiceLevel: dish.spiceLevel,
                    spiceLabel: dish.spiceLabel,
                    onTap: () => onDishTap(dish),
                  );
                },
              ),
            if (dishes.length.isOdd) ...[
              if (gridCount > 0) const SizedBox(height: gap),
              Builder(
                builder: (context) {
                  final dish = dishes.last;
                  return AppDishCard(
                    name: dish.name,
                    description: dish.description,
                    price: dish.price,
                    imageUrl: RemoteImages.dish(dish.imageSeed),
                    spiceLevel: dish.spiceLevel,
                    spiceLabel: dish.spiceLabel,
                    badge: dish.badge,
                    onTap: () => onDishTap(dish),
                  );
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
