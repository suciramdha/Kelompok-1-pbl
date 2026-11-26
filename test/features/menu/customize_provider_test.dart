import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lokuak/features/menu/presentation/mock/customize_mock.dart';
import 'package:lokuak/features/menu/presentation/providers/customize_provider.dart';

void main() {
  test('mock Seblak Prasmanan lengkap', () {
    final product = customizeById(kSeblakPrasmananId);

    expect(product, isNotNull);
    expect(product!.kuahOptions, hasLength(3));
    expect(product.spiceLevels, hasLength(6));
    expect(product.toppingGroups, hasLength(3));
    expect(
      product.toppingGroups.fold<int>(
        0,
        (sum, group) => sum + group.toppings.length,
      ),
      14,
    );
    expect(customizeById('mie-rawit-hijau'), isNull);
  });

  test('state awal kosong tanpa kuah dan level', () {
    final container = ProviderContainer.test();
    final state = container.read(customizeProvider);

    expect(state.kuahId, isNull);
    expect(state.spiceLevel, isNull);
    expect(state.quantities, isEmpty);
    expect(state.unitCount, 0);
    expect(state.total, 0);
  });

  test('pilih kuah dan level pedas', () {
    final container = ProviderContainer.test();
    final notifier = container.read(customizeProvider.notifier);

    notifier.selectKuah('segar');
    notifier.selectSpiceLevel(4);

    expect(container.read(customizeProvider).kuahId, 'segar');
    expect(container.read(customizeProvider).spiceLevel, 4);

    notifier.selectKuah('tidak-ada');
    notifier.selectSpiceLevel(9);

    expect(container.read(customizeProvider).kuahId, 'segar');
    expect(container.read(customizeProvider).spiceLevel, 4);
  });

  test('qty, total, dan jumlah racikan dihitung per unit', () {
    final container = ProviderContainer.test();
    final notifier = container.read(customizeProvider.notifier);

    notifier.incrementTopping('dumpling-keju');
    notifier.incrementTopping('dumpling-keju');
    notifier.incrementTopping('chikuwa-ikan');

    final state = container.read(customizeProvider);

    expect(state.quantityOf('dumpling-keju'), 2);
    expect(state.quantityOf('chikuwa-ikan'), 1);
    expect(state.unitCount, 3);
    expect(state.total, 7000 + 3000);
  });

  test('qty dibatasi 0..maxQty', () {
    final container = ProviderContainer.test();
    final notifier = container.read(customizeProvider.notifier);

    for (var i = 0; i < 25; i++) {
      notifier.incrementTopping('dumpling-keju');
    }

    expect(container.read(customizeProvider).quantityOf('dumpling-keju'), 20);

    for (var i = 0; i < 25; i++) {
      notifier.decrementTopping('dumpling-keju');
    }

    final state = container.read(customizeProvider);
    expect(state.quantityOf('dumpling-keju'), 0);
    expect(state.quantities.containsKey('dumpling-keju'), isFalse);
    expect(state.total, 0);
  });

  test('state quantity tidak dimutasi di tempat', () {
    final container = ProviderContainer.test();
    final before = container.read(customizeProvider);

    container.read(customizeProvider.notifier).incrementTopping('ceker-ayam');

    final after = container.read(customizeProvider);
    expect(before.quantities, isEmpty);
    expect(after.quantities, isNot(same(before.quantities)));
    expect(after.quantities['ceker-ayam'], 1);
  });

  test('catatan dan reset', () {
    final container = ProviderContainer.test();
    final notifier = container.read(customizeProvider.notifier);

    notifier.setNote('Kuah dipisah');
    notifier.incrementTopping('telur-ayam');

    expect(container.read(customizeProvider).note, 'Kuah dipisah');
    expect(container.read(customizeProvider).unitCount, 1);

    notifier.reset();

    final state = container.read(customizeProvider);
    expect(state.note, isEmpty);
    expect(state.quantities, isEmpty);
    expect(state.kuahId, isNull);
    expect(state.spiceLevel, isNull);
  });
}
