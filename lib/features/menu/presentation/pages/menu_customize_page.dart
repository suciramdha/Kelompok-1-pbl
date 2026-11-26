import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/ui/app_note_field.dart';
import '../../../../core/ui/app_option_card.dart';
import '../../../../core/ui/app_section_header.dart';
import '../../../cart/presentation/models/cart_line_item.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../placeholder/presentation/placeholder_page.dart';
import '../mock/customize_mock.dart';
import '../providers/customize_provider.dart';
import '../widgets/customize_bottom_bar.dart';
import '../widgets/customize_info_section.dart';
import '../widgets/customize_spice_grid.dart';
import '../widgets/customize_toast.dart';
import '../widgets/customize_topping_row.dart';
import '../widgets/menu_hero.dart';

class MenuCustomizePage extends ConsumerStatefulWidget {
  const MenuCustomizePage({super.key, required this.id});

  final String id;

  @override
  ConsumerState<MenuCustomizePage> createState() => _MenuCustomizePageState();
}

class _MenuCustomizePageState extends ConsumerState<MenuCustomizePage> {
  final TextEditingController _noteController = TextEditingController();
  bool _showToast = false;
  Timer? _toastTimer;

  CustomizeModel? get _product => customizeById(widget.id);

  @override
  void dispose() {
    _toastTimer?.cancel();
    _noteController.dispose();
    super.dispose();
  }

  void _showAddedToast() {
    _toastTimer?.cancel();
    setState(() => _showToast = true);
    _toastTimer = Timer(context.motion.toast, () {
      if (!mounted) return;
      setState(() => _showToast = false);
    });
  }

  void _onQuantityChanged(String toppingId, int next) {
    final notifier = ref.read(customizeProvider.notifier);
    final current = ref.read(customizeProvider).quantityOf(toppingId);
    if (next > current) {
      notifier.incrementTopping(toppingId);
    } else if (next < current) {
      notifier.decrementTopping(toppingId);
    }
  }

  void _submit() {
    ref.read(customizeProvider.notifier).setNote(_noteController.text);
    final state = ref.read(customizeProvider);
    final validation = _validationMessage(state);
    if (validation != null) {
      _showValidation(validation);
      return;
    }
    final note = state.note.trim();
    ref
        .read(cartProvider.notifier)
        .addItem(
          CartLineItem(
            id: 'cart-${DateTime.now().microsecondsSinceEpoch}',
            name: state.product.name,
            details: _cartDetails(state),
            imageSeed: state.product.imageSeed,
            unitPrice: state.total,
            spiceLevel: state.spiceLevel,
            note: note.isEmpty ? null : note,
          ),
        );
    _showAddedToast();
  }

  String _cartDetails(CustomizeState state) {
    CustomizeKuahOption? kuah;
    for (final option in state.product.kuahOptions) {
      if (option.id == state.kuahId) {
        kuah = option;
        break;
      }
    }
    CustomizeSpiceLevel? spice;
    for (final level in state.product.spiceLevels) {
      if (level.level == state.spiceLevel) {
        spice = level;
        break;
      }
    }
    final toppingParts = <String>[];
    var toppingCount = 0;
    for (final group in state.product.toppingGroups) {
      for (final topping in group.toppings) {
        final quantity = state.quantityOf(topping.id);
        if (quantity <= 0) continue;
        toppingCount += quantity;
        toppingParts.add(
          quantity > 1 ? '${topping.name} ($quantity)' : topping.name,
        );
      }
    }
    final parts = <String>[];
    if (kuah != null) parts.add(kuah.name);
    if (spice != null) parts.add('Level ${spice.level} ${spice.name}');
    if (toppingParts.isNotEmpty) {
      parts.add('$toppingCount Topping: ${toppingParts.join(', ')}');
    }
    return parts.isEmpty ? state.product.description : parts.join(' • ');
  }

  String? _validationMessage(CustomizeState state) {
    if (state.kuahId == null) return 'Pilih jenis kuah seblak dulu ya.';
    if (state.spiceLevel == null) return 'Pilih tingkat kepedasan dulu ya.';
    if (state.unitCount == 0) {
      return 'Pilih minimal 1 topping prasmanan dulu ya.';
    }
    return null;
  }

  void _showValidation(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _share() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Fitur bagikan belum tersedia di prototype.'),
        ),
      );
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;
    final product = _product;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kustomisasi Seblak')),
        body: const PlaceholderPage(
          title: 'Kustomisasi Seblak',
          icon: Icons.tune_rounded,
        ),
      );
    }

    final state = ref.watch(customizeProvider);
    final notifier = ref.read(customizeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: largeText ? 72 : 64,
        titleSpacing: 0,
        shape: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        leading: IconButton(
          onPressed: _back,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'Kustomisasi Seblak',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: _share,
            tooltip: 'Bagikan Racikan',
            icon: Icon(Icons.share_outlined, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: context.spacing.xl),
            children: [
              MenuHero(
                imageUrl: RemoteImages.hero(
                  'seblak-prasmanan',
                  width: 900,
                  height: 675,
                ),
                semanticLabel: 'Foto Seblak Prasmanan',
                badges: const [
                  MenuHeroBadge(
                    label: 'Prasmanan Spesial',
                    icon: Icons.local_fire_department_rounded,
                    emphasized: true,
                  ),
                ],
              ),
              CustomizeInfoSection(
                name: product.name,
                cookTime: product.cookTime,
                description: product.description,
              ),
              _SectionBand(),
              _Section(
                header: AppSectionHeader(
                  title: 'Pilih Jenis Kuah Seblak',
                  accent: scheme.primary,
                  badgeLabel: 'Wajib',
                  description: 'Wajib pilih 1 jenis racikan kuah',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (
                      var index = 0;
                      index < product.kuahOptions.length;
                      index++
                    ) ...[
                      AppOptionCard(
                        title: product.kuahOptions[index].name,
                        tag: product.kuahOptions[index].tag,
                        description: product.kuahOptions[index].description,
                        trailingLabel: 'Gratis',
                        selected: state.kuahId == product.kuahOptions[index].id,
                        onTap: () =>
                            notifier.selectKuah(product.kuahOptions[index].id),
                      ),
                      if (index != product.kuahOptions.length - 1)
                        SizedBox(height: context.spacing.sm),
                    ],
                  ],
                ),
              ),
              SizedBox(height: context.spacing.xl),
              _Section(
                header: AppSectionHeader(
                  title: 'Tingkat Kepedasan (Cabe Rawit)',
                  accent: scheme.primary,
                  badgeLabel: 'Wajib',
                  description:
                      'Gilingan cabe rawit domba asli tanpa saus tiruan',
                ),
                child: CustomizeSpiceGrid(
                  levels: product.spiceLevels,
                  selectedLevel: state.spiceLevel,
                  onChanged: notifier.selectSpiceLevel,
                ),
              ),
              SizedBox(height: context.spacing.xl),
              _Section(
                header: AppSectionHeader(
                  title: 'Pilih Topping Prasmanan',
                  accent: scheme.secondary,
                  badgeLabel: 'Min. 1',
                  description:
                      'Pilih minimal 1 topping, lalu atur porsi sesukamu',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final group in product.toppingGroups) ...[
                      _CategoryHeader(icon: group.icon, label: group.label),
                      SizedBox(height: context.spacing.sm),
                      for (
                        var index = 0;
                        index < group.toppings.length;
                        index++
                      ) ...[
                        CustomizeToppingRow(
                          topping: group.toppings[index],
                          quantity: state.quantityOf(group.toppings[index].id),
                          onQuantityChanged: (value) => _onQuantityChanged(
                            group.toppings[index].id,
                            value,
                          ),
                        ),
                        if (index != group.toppings.length - 1)
                          SizedBox(height: context.spacing.sm),
                      ],
                      SizedBox(height: context.spacing.lg),
                    ],
                  ],
                ),
              ),
              _Section(
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.edit_note_rounded,
                          size: 20,
                          color: scheme.secondary,
                        ),
                        SizedBox(width: context.spacing.sm),
                        Expanded(
                          child: Text(
                            'Catatan untuk Penjual',
                            style: textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.spacing.xs),
                    Text(
                      'Contoh: Kuah dipisah / daun bawang banyakin ya mang...',
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                child: AppNoteField(
                  controller: _noteController,
                  maxLength: 120,
                ),
              ),
            ],
          ),
          Positioned(
            top: context.spacing.md,
            left: context.spacing.md,
            right: context.spacing.md,
            child: CustomizeToast(
              visible: _showToast,
              message: 'Racikan seblak ditambahkan ke keranjang!',
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomizeBottomBar(
        unitCount: state.unitCount,
        total: state.total,
        onSubmit: _submit,
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.header, required this.child});

  final Widget header;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          SizedBox(height: context.spacing.md),
          child,
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: scheme.secondary),
        SizedBox(width: context.spacing.xs),
        Expanded(
          child: Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: scheme.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionBand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: context.spacing.sm,
      margin: EdgeInsets.symmetric(vertical: context.spacing.md),
      color: scheme.surfaceContainerLow,
    );
  }
}
