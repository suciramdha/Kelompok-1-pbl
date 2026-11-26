import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lokuak/features/home/presentation/mock/home_mock.dart';
import 'package:lokuak/features/home/presentation/providers/home_filter_provider.dart';

void main() {
  test('filter Beranda bisa berubah', () {
    final container = ProviderContainer.test();

    expect(container.read(homeFilterProvider), HomeCategory.all);

    container.read(homeFilterProvider.notifier).select(HomeCategory.drink);

    expect(container.read(homeFilterProvider), HomeCategory.drink);
  });
}
