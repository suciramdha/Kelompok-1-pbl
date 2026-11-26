import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/layout/app_sticky_order_bar.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../mock/home_mock.dart';
import '../providers/home_filter_provider.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/featured_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/home_header.dart';
import '../widgets/menu_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(homeFilterProvider);
    final cart = ref.watch(cartProvider);

    void showInfo(String message) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }

    void openDish(DishModel dish) {
      context.push(AppRoutes.menuPath(dish.id));
    }

    final sections = <Widget>[
      if (selected == HomeCategory.all || selected == HomeCategory.seblak) ...[
        _FeaturedSection(
          dish: featuredDish,
          onTap: () => context.push(AppRoutes.menuPath(featuredDish.id)),
        ),
        SizedBox(height: context.spacing.lg),
      ],
      if (selected == HomeCategory.all || selected == HomeCategory.food) ...[
        MenuSection(
          title: 'Makanan & Menu Pedas',
          icon: Icons.restaurant_menu_rounded,
          dishes: foodDishes,
          onDishTap: openDish,
        ),
        SizedBox(height: context.spacing.lg),
      ],
      if (selected == HomeCategory.all || selected == HomeCategory.snack) ...[
        MenuSection(
          title: 'Camilan Renyah & Teman Ngedot',
          icon: Icons.cookie_outlined,
          dishes: snackDishes,
          layout: MenuSectionLayout.snackGrid,
          onDishTap: openDish,
        ),
        SizedBox(height: context.spacing.lg),
      ],
      if (selected == HomeCategory.all || selected == HomeCategory.drink) ...[
        MenuSection(
          title: 'Pereda Pedas & Minuman Segar',
          icon: Icons.local_drink_outlined,
          dishes: drinkDishes,
          onDishTap: openDish,
        ),
        SizedBox(height: context.spacing.lg),
      ],
    ];

    return Column(
      children: [
        HomeHeader(
          onNotifications: () => showInfo('Belum ada notifikasi baru.'),
          onChangeAddress: () =>
              showInfo('Ubah alamat belum tersedia di prototype.'),
        ),
        Expanded(
          child: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      context.spacing.margin,
                      context.spacing.lg,
                      context.spacing.margin,
                      0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: HeroBanner(
                        onCta: () =>
                            context.push(AppRoutes.menuPath(featuredDish.id)),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: context.spacing.lg),
                  ),
                  SliverToBoxAdapter(
                    child: CategoryFilterBar(
                      selected: selected,
                      onSelected: (category) => ref
                          .read(homeFilterProvider.notifier)
                          .select(category),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      context.spacing.margin,
                      context.spacing.lg,
                      context.spacing.margin,
                      0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(sections),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 108)),
                ],
              ),
              if (cart.itemCount > 0)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AppStickyOrderBar(
                    itemCount: cart.itemCount,
                    total: cart.total,
                    onTap: () => context.push(AppRoutes.cart),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeaturedSection extends StatelessWidget {
  const _FeaturedSection({required this.dish, required this.onTap});

  final DishModel dish;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
              child: Icon(
                Icons.local_fire_department_rounded,
                size: 18,
                color: scheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Menu Juara & Best Seller',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        FeaturedCard(
          dish: dish,
          imageUrl: RemoteImages.dish(dish.imageSeed, width: 900, height: 600),
          onTap: onTap,
        ),
      ],
    );
  }
}
