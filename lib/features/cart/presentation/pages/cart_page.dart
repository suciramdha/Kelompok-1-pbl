import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_button.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../mock/cart_mock.dart';
import '../models/cart_line_item.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_address_card.dart';
import '../widgets/cart_checkout_bar.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_section_card.dart';
import '../widgets/driver_note_card.dart';
import '../widgets/cart_item_note_sheet.dart';
import '../widgets/order_summary.dart';
import '../widgets/payment_method_card.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final TextEditingController _driverNoteController = TextEditingController();
  final Set<String> _selectedNoteTags = {cartDefaultDriverNoteTag};

  @override
  void dispose() {
    _driverNoteController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  Future<void> _confirmRemoveItem(CartLineItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final scheme = Theme.of(dialogContext).colorScheme;
        return AlertDialog(
          title: const Text('Hapus item?'),
          content: Text('${item.name} akan dihapus dari keranjang.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Batal'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: scheme.error),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) return;
    ref.read(cartProvider.notifier).removeItem(item.id);
    _showMessage('Item dihapus dari keranjang.');
  }

  Future<void> _openItemNoteDrawer(CartLineItem item) async {
    final note = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.radius.xl),
        ),
      ),
      builder: (context) => CartItemNoteSheet(initialNote: item.note ?? ''),
    );
    if (note == null || !mounted) return;
    ref.read(cartProvider.notifier).setItemNote(item.id, note);
  }

  void _setQuantity(String id, int quantity) {
    ref.read(cartProvider.notifier).setQuantity(id, quantity);
  }

  void _toggleNoteTag(String tag) {
    setState(() {
      if (!_selectedNoteTags.add(tag)) {
        _selectedNoteTags.remove(tag);
      }
    });
  }

  void _addMoreMenu() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final scheme = Theme.of(context).colorScheme;
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
          'Keranjang & Checkout',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () =>
                _showMessage('Pusat bantuan belum tersedia di prototype.'),
            tooltip: 'Bantuan',
            icon: Icon(
              Icons.help_outline_rounded,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      body: cart.isEmpty
          ? AppEmptyState(
              icon: Icons.shopping_bag_outlined,
              title: 'Keranjang masih kosong',
              message: 'Yuk pilih menu favoritmu dulu.',
              actionLabel: 'Kembali ke Beranda',
              onAction: () => context.go(AppRoutes.home),
            )
          : _CartContent(
              cart: cart,
              driverNoteController: _driverNoteController,
              selectedNoteTags: _selectedNoteTags,
              onToggleNoteTag: _toggleNoteTag,
              onQuantityChanged: _setQuantity,
              onRemoveRequested: _confirmRemoveItem,
              onEditItemNote: _openItemNoteDrawer,
              onAddMore: _addMoreMenu,
              onEditAddress: () =>
                  _showMessage('Ubah alamat belum tersedia di prototype.'),
              onSelectPayment: (id) =>
                  ref.read(cartProvider.notifier).selectPaymentMethod(id),
            ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : CartCheckoutBar(
              total: cart.total,
              onCheckout: () =>
                  _showMessage('Checkout belum tersedia di prototype.'),
            ),
    );
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({
    required this.cart,
    required this.driverNoteController,
    required this.selectedNoteTags,
    required this.onToggleNoteTag,
    required this.onQuantityChanged,
    required this.onRemoveRequested,
    required this.onEditItemNote,
    required this.onAddMore,
    required this.onEditAddress,
    required this.onSelectPayment,
  });

  final CartState cart;
  final TextEditingController driverNoteController;
  final Set<String> selectedNoteTags;
  final ValueChanged<String> onToggleNoteTag;
  final void Function(String id, int quantity) onQuantityChanged;
  final ValueChanged<CartLineItem> onRemoveRequested;
  final ValueChanged<CartLineItem> onEditItemNote;
  final VoidCallback onAddMore;
  final VoidCallback onEditAddress;
  final ValueChanged<String> onSelectPayment;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return SafeArea(
      top: false,
      bottom: false,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.symmetric(
          horizontal: spacing.margin,
          vertical: spacing.lg,
        ),
        children: [
          CartAddressCard(address: cartAddress, onEdit: onEditAddress),
          SizedBox(height: spacing.md),
          CartSectionCard(
            icon: Icons.restaurant_menu_rounded,
            title: 'Pesanan Kamu (${cart.lineCount} Menu)',
            children: [
              for (final item in cart.items)
                CartItemTile(
                  item: item,
                  onQuantityChanged: (quantity) =>
                      onQuantityChanged(item.id, quantity),
                  onRemoveRequested: () => onRemoveRequested(item),
                  onNoteTap: () => onEditItemNote(item),
                ),
              AppButton(
                label: 'Tambah Menu Lainnya',
                variant: AppButtonVariant.secondary,
                icon: Icons.add_circle_outline_rounded,
                expand: true,
                onPressed: onAddMore,
              ),
            ],
          ),
          SizedBox(height: spacing.md),
          DriverNoteCard(
            controller: driverNoteController,
            maxLength: 120,
            tags: cartDriverNoteTags,
            selectedTags: selectedNoteTags,
            onToggleTag: onToggleNoteTag,
          ),
          SizedBox(height: spacing.md),
          PaymentMethodCard(
            options: cartPaymentOptions,
            selectedId: cart.paymentMethodId,
            onSelect: onSelectPayment,
          ),
          SizedBox(height: spacing.md),
          OrderSummary(cart: cart),
        ],
      ),
    );
  }
}
