// MOCK ONLY — state keranjang sementara.
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/cart_mock.dart';
import '../models/cart_line_item.dart';

class CartState {
  const CartState({
    required this.items,
    this.deliveryFee = cartDeliveryFee,
    this.serviceFee = cartServiceFee,
    this.distanceLabel = cartDistanceLabel,
    this.paymentMethodId = cartDefaultPaymentMethodId,
  });

  final List<CartLineItem> items;
  final int deliveryFee;
  final int serviceFee;
  final String distanceLabel;
  final String paymentMethodId;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  int get lineCount => items.length;

  int get subtotal => items.fold(0, (sum, item) => sum + item.lineTotal);

  int get total => isEmpty ? 0 : subtotal + deliveryFee + serviceFee;

  bool get isEmpty => items.isEmpty;

  CartState copyWith({List<CartLineItem>? items, String? paymentMethodId}) {
    return CartState(
      items: items ?? this.items,
      deliveryFee: deliveryFee,
      serviceFee: serviceFee,
      distanceLabel: distanceLabel,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }
}

class CartNotifier extends Notifier<CartState> {
  @override
  CartState build() => const CartState(items: <CartLineItem>[]);

  void addItem(CartLineItem item) {
    final index = state.items.indexWhere(
      (existing) =>
          existing.name == item.name &&
          existing.details == item.details &&
          existing.note == item.note &&
          existing.unitPrice == item.unitPrice,
    );
    if (index < 0) {
      final quantity = item.quantity.clamp(1, 20);
      final normalized = quantity == item.quantity
          ? item
          : item.copyWith(quantity: quantity);
      state = state.copyWith(
        items: List.unmodifiable([...state.items, normalized]),
      );
      return;
    }
    final next = [...state.items];
    next[index] = next[index].copyWith(
      quantity: (next[index].quantity + item.quantity).clamp(1, 20),
    );
    state = state.copyWith(items: List.unmodifiable(next));
  }

  void setQuantity(String id, int quantity) {
    final index = state.items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final next = [...state.items];
    next[index] = next[index].copyWith(quantity: quantity.clamp(1, 20));
    state = state.copyWith(items: List.unmodifiable(next));
  }

  void incrementItem(String id) {
    final item = _itemById(id);
    if (item == null) return;
    setQuantity(id, item.quantity + 1);
  }

  void decrementItem(String id) {
    final item = _itemById(id);
    if (item == null) return;
    setQuantity(id, item.quantity - 1);
  }

  void removeItem(String id) {
    final next = state.items.where((item) => item.id != id).toList();
    state = state.copyWith(items: List.unmodifiable(next));
  }

  void selectPaymentMethod(String id) {
    if (!cartPaymentOptions.any((option) => option.id == id)) return;
    state = state.copyWith(paymentMethodId: id);
  }

  void setItemNote(String id, String value) {
    final index = state.items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final trimmed = value.trim();
    final next = [...state.items];
    next[index] = next[index].withNote(trimmed.isEmpty ? null : trimmed);
    state = state.copyWith(items: List.unmodifiable(next));
  }

  CartLineItem? _itemById(String id) {
    for (final item in state.items) {
      if (item.id == id) return item;
    }
    return null;
  }
}

final cartProvider = NotifierProvider<CartNotifier, CartState>(
  CartNotifier.new,
);
