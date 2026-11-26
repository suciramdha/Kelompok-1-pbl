import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lokuak/features/cart/presentation/models/cart_line_item.dart';
import 'package:lokuak/features/cart/presentation/providers/cart_provider.dart';

void main() {
  test('cart kosong secara default', () {
    final container = ProviderContainer.test();

    final cart = container.read(cartProvider);
    expect(cart.isEmpty, isTrue);
    expect(cart.itemCount, 0);
    expect(cart.lineCount, 0);
    expect(cart.subtotal, 0);
    expect(cart.total, 0);
  });

  test('cart menambah item dan total', () {
    final container = ProviderContainer.test();

    container
        .read(cartProvider.notifier)
        .addItem(
          const CartLineItem(
            id: 'test-item',
            name: 'Es Teh Test',
            details: 'Manis sedang',
            imageSeed: 'teh-es-jumbo',
            unitPrice: 12000,
          ),
        );

    expect(container.read(cartProvider).itemCount, 1);
    expect(container.read(cartProvider).total, 22000);
  });

  test('cart menambah beberapa porsi sekaligus', () {
    final container = ProviderContainer.test();

    container
        .read(cartProvider.notifier)
        .addItem(
          const CartLineItem(
            id: 'test-porsi',
            name: 'Porsi Test',
            details: 'Porsi ganda',
            imageSeed: 'seblak-prasmanan',
            unitPrice: 16000,
            quantity: 2,
          ),
        );

    expect(container.read(cartProvider).itemCount, 2);
    expect(container.read(cartProvider).total, 42000);
  });
}
