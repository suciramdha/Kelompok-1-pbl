import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/constants/remote_images.dart';
import '../../../../core/ui/app_note_field.dart';
import '../../../../core/ui/app_spice_selector.dart';
import '../../../../core/ui/app_temperature_selector.dart';
import '../../../../core/ui/app_topping_tile.dart';
import '../../../cart/presentation/models/cart_line_item.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../placeholder/presentation/placeholder_page.dart';
import '../mock/menu_detail_mock.dart';
import '../widgets/detail_bottom_bar.dart';
import '../widgets/menu_hero.dart';
import '../widgets/menu_info_section.dart';

class MenuDetailPage extends ConsumerStatefulWidget {
  const MenuDetailPage({super.key, required this.id});

  final String id;

  @override
  ConsumerState<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends ConsumerState<MenuDetailPage> {
  MenuDetailModel? _detail;
  int _quantity = 1;
  int? _selectedSpiceLevel;
  String? _selectedTemperature;
  final Set<String> _selectedToppingIds = {};
  final TextEditingController _noteController = TextEditingController();
  bool _favorite = true;
  bool _showToast = false;
  Timer? _toastTimer;

  @override
  void initState() {
    super.initState();
    _detail = menuDetailById(widget.id);
    _selectedSpiceLevel = null;
    _selectedTemperature = null;
  }

  @override
  void didUpdateWidget(covariant MenuDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _toastTimer?.cancel();
      _detail = menuDetailById(widget.id);
      _selectedSpiceLevel = null;
      _selectedTemperature = null;
      _quantity = 1;
      _selectedToppingIds.clear();
      _noteController.clear();
      _favorite = true;
      _showToast = false;
    }
  }

  @override
  void dispose() {
    _toastTimer?.cancel();
    _noteController.dispose();
    super.dispose();
  }

  int _unitPrice(MenuDetailModel detail) {
    final toppingTotal = detail.toppings
        .where((topping) => _selectedToppingIds.contains(topping.id))
        .fold(0, (sum, topping) => sum + topping.price);
    return detail.price + toppingTotal;
  }

  int _total(MenuDetailModel detail) => _unitPrice(detail) * _quantity;

  String _cartDetails(MenuDetailModel detail) {
    final parts = <String>[
      ...detail.spiceOptions
          .where((option) => option.level == _selectedSpiceLevel)
          .map((option) => option.title),
      if (_selectedTemperature != null) 'Suhu $_selectedTemperature',
      ...detail.toppings
          .where((topping) => _selectedToppingIds.contains(topping.id))
          .map((topping) => topping.name),
    ];
    return parts.isEmpty ? detail.description : parts.join(' • ');
  }

  void _toggleTopping(String id) {
    setState(() {
      if (!_selectedToppingIds.add(id)) {
        _selectedToppingIds.remove(id);
      }
    });
  }

  void _addToCart(MenuDetailModel detail) {
    final validation = _validationMessage(detail);
    if (validation != null) {
      _showValidation(validation);
      return;
    }
    final note = _noteController.text.trim();
    ref
        .read(cartProvider.notifier)
        .addItem(
          CartLineItem(
            id: 'cart-${DateTime.now().microsecondsSinceEpoch}',
            name: detail.name,
            details: _cartDetails(detail),
            imageSeed: detail.imageSeed,
            unitPrice: _unitPrice(detail),
            quantity: _quantity,
            note: note.isEmpty ? null : note,
            spiceLevel: _selectedSpiceLevel,
          ),
        );
    _showAddedToast();
  }

  String? _validationMessage(MenuDetailModel detail) {
    if (detail.spiceOptions.isNotEmpty && _selectedSpiceLevel == null) {
      return 'Pilih tingkat kepedasan dulu ya.';
    }
    if (detail.temperatureOptions.isNotEmpty && _selectedTemperature == null) {
      return 'Pilih suhu penyajian dulu ya.';
    }
    return null;
  }

  void _showValidation(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _showAddedToast() {
    _toastTimer?.cancel();
    setState(() => _showToast = true);
    _toastTimer = Timer(context.motion.toast, () {
      if (!mounted) return;
      setState(() => _showToast = false);
    });
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
    final detail = _detail;

    if (detail == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Menu')),
        body: const PlaceholderPage(
          title: 'Detail Menu',
          icon: Icons.restaurant_menu_rounded,
        ),
      );
    }

    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

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
          'Detail Menu',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: _share,
            tooltip: 'Bagikan Menu',
            icon: Icon(Icons.share_outlined, color: scheme.onSurfaceVariant),
          ),
          IconButton(
            onPressed: () => setState(() => _favorite = !_favorite),
            tooltip: _favorite ? 'Hapus dari favorit' : 'Simpan ke favorit',
            icon: Icon(
              _favorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: _favorite ? scheme.primary : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: context.spacing.xl),
            children: [
              MenuHero(
                imageUrl: RemoteImages.dish(
                  detail.imageSeed,
                  width: 900,
                  height: 675,
                ),
                semanticLabel: 'Foto ${detail.name}',
                badges: detail.heroBadges,
              ),
              MenuInfoSection(detail: detail),
              if (detail.spiceOptions.isNotEmpty) ...[
                _SectionDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.margin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SectionHeader(
                        accent: scheme.primary,
                        title: 'Tingkat Kepedasan',
                        badgeLabel: 'Wajib Pilih 1',
                      ),
                      SizedBox(height: context.spacing.sm),
                      Text(
                        'Pilih level uleg rawit hijau sesuai batas ketahanan lidahmu.',
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: context.spacing.md),
                      AppSpiceSelector(
                        options: detail.spiceOptions,
                        selectedLevel: _selectedSpiceLevel,
                        onChanged: (level) =>
                            setState(() => _selectedSpiceLevel = level),
                      ),
                    ],
                  ),
                ),
              ],
              if (detail.toppings.isNotEmpty) ...[
                _SectionDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.margin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SectionHeader(
                        accent: scheme.secondary,
                        title: 'Topping Tambahan',
                        badgeLabel: 'Opsional',
                      ),
                      SizedBox(height: context.spacing.md),
                      for (
                        var index = 0;
                        index < detail.toppings.length;
                        index++
                      ) ...[
                        AppToppingTile(
                          title: detail.toppings[index].name,
                          description: detail.toppings[index].description,
                          price: detail.toppings[index].price,
                          value: _selectedToppingIds.contains(
                            detail.toppings[index].id,
                          ),
                          onChanged: (_) =>
                              _toggleTopping(detail.toppings[index].id),
                        ),
                        if (index != detail.toppings.length - 1)
                          SizedBox(height: context.spacing.sm),
                      ],
                    ],
                  ),
                ),
              ],
              if (detail.temperatureOptions.isNotEmpty) ...[
                _SectionDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.margin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SectionHeader(
                        accent: scheme.tertiary,
                        icon: Icons.thermostat_rounded,
                        title: 'Suhu Penyajian',
                        badgeLabel: 'Wajib Pilih 1',
                      ),
                      SizedBox(height: context.spacing.md),
                      AppTemperatureSelector(
                        options: detail.temperatureOptions,
                        selected: _selectedTemperature,
                        onChanged: (value) =>
                            setState(() => _selectedTemperature = value),
                      ),
                    ],
                  ),
                ),
              ],
              _SectionDivider(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacing.margin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionHeader(
                      accent: scheme.secondary,
                      icon: Icons.edit_note_rounded,
                      title: 'Catatan untuk Penjual',
                    ),
                    SizedBox(height: context.spacing.sm),
                    Text(
                      'Contoh: Telurnya matang banget ya mang, jangan pakai bawang goreng.',
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: context.spacing.sm),
                    AppNoteField(
                      controller: _noteController,
                      maxLength: detail.noteMaxLength,
                    ),
                    SizedBox(height: context.spacing.lg),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: context.spacing.md,
            left: context.spacing.md,
            right: context.spacing.md,
            child: _AddedToast(visible: _showToast, name: detail.name),
          ),
        ],
      ),
      bottomNavigationBar: DetailBottomBar(
        quantity: _quantity,
        total: _total(detail),
        onQuantityChanged: (quantity) => setState(() => _quantity = quantity),
        onAdd: () => _addToCart(detail),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.accent,
    required this.title,
    this.badgeLabel,
    this.icon,
  });

  final Color accent;
  final String title;
  final String? badgeLabel;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    final accentMark = icon != null
        ? Icon(icon, size: 20, color: accent)
        : Container(
            width: 2,
            height: 20,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: context.radius.fullRadius,
            ),
          );
    final badge = badgeLabel == null
        ? null
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: scheme.secondaryFixed,
              borderRadius: context.radius.fullRadius,
            ),
            child: Text(
              badgeLabel!,
              style: textTheme.labelSmall?.copyWith(
                color: scheme.onSecondaryFixed,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
    final titleRow = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        accentMark,
        SizedBox(width: context.spacing.sm),
        Expanded(child: Text(title, style: textTheme.headlineMedium)),
      ],
    );

    if (largeText && badge != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRow,
          SizedBox(height: context.spacing.xs),
          badge,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        accentMark,
        SizedBox(width: context.spacing.sm),
        Expanded(child: Text(title, style: textTheme.headlineMedium)),
        if (badge != null) ...[SizedBox(width: context.spacing.sm), badge],
      ],
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

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

class _AddedToast extends StatelessWidget {
  const _AddedToast({required this.visible, required this.name});

  final bool visible;
  final String name;

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
                        Icons.local_fire_department_rounded,
                        size: 18,
                        color: scheme.tertiaryFixedDim,
                      ),
                      SizedBox(width: context.spacing.sm),
                      Flexible(
                        child: Text(
                          '$name masuk ke keranjang!',
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
