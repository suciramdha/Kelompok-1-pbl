import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lokuak/app/theme/app_theme.dart';
import 'package:lokuak/core/ui/app_spice_selector.dart';
import 'package:lokuak/core/ui/app_temperature_selector.dart';
import 'package:lokuak/core/ui/app_topping_tile.dart';
import 'package:lokuak/features/cart/presentation/providers/cart_provider.dart';
import 'package:lokuak/features/home/presentation/mock/home_mock.dart';
import 'package:lokuak/features/menu/presentation/mock/menu_detail_mock.dart';
import 'package:lokuak/features/menu/presentation/pages/menu_detail_page.dart';

Future<void> pumpDetail(
  WidgetTester tester, {
  String id = 'mie-rawit-hijau',
  Size size = const Size(390, 844),
  double textScale = 1,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light,
        home: MediaQuery(
          data: MediaQueryData(
            size: size,
            textScaler: TextScaler.linear(textScale),
          ),
          child: MenuDetailPage(id: id),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  test('semua menu Beranda punya data detail sesuai matriks', () {
    for (final dish in [...foodDishes, ...snackDishes, ...drinkDishes]) {
      expect(menuDetailById(dish.id), isNotNull, reason: dish.id);
    }

    expect(menuDetailById('seblak-prasmanan-komplit'), isNull);

    expect(menuDetailById('mie-jontor')!.spiceOptions, isNotEmpty);
    expect(menuDetailById('mie-jontor')!.toppings, isNotEmpty);
    expect(menuDetailById('mie-narako')!.spiceOptions, isNotEmpty);
    expect(menuDetailById('mie-narako')!.toppings, isNotEmpty);

    expect(menuDetailById('nasi-goreng-spesial')!.spiceOptions, isEmpty);
    expect(menuDetailById('nasi-goreng-spesial')!.toppings, isNotEmpty);

    expect(menuDetailById('jus-jeruk')!.toppings, isEmpty);
    expect(menuDetailById('jus-jeruk')!.temperatureOptions, [
      'Dingin',
      'Panas',
    ]);

    expect(menuDetailById('nuget-crispy')!.spiceOptions, isEmpty);
    expect(menuDetailById('nuget-crispy')!.toppings, isEmpty);
    expect(menuDetailById('nuget-crispy')!.temperatureOptions, isEmpty);
  });

  testWidgets('menu di luar scope memakai placeholder', (tester) async {
    await pumpDetail(tester, id: 'seblak-prasmanan-komplit');

    expect(find.text('Detail Menu'), findsNWidgets(2));
    expect(
      find.text('Halaman ini akan diimplementasikan pada tahap berikutnya.'),
      findsOneWidget,
    );
  });

  testWidgets('header detail memakai badge dan metadata revisi', (
    tester,
  ) async {
    await pumpDetail(tester);

    expect(find.text('Terlaris #2'), findsOneWidget);
    expect(find.text('15-20 Menit Masak'), findsOneWidget);

    expect(find.text('100% Halal'), findsNothing);
    expect(find.text('Pedas Gurih Bikin Nagih'), findsNothing);
    expect(find.text('4.9'), findsNothing);
    expect(find.text('(850+ ulasan)'), findsNothing);
    expect(find.text('Seblak Lokuak'), findsNothing);
  });

  testWidgets('Mie Jontor menampilkan level dan topping', (tester) async {
    await pumpDetail(tester, id: 'mie-jontor');

    expect(find.text('Mie Jontor'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Level 2 - Pedas Nampol'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      tester
          .widget<AppSpiceSelector>(find.byType(AppSpiceSelector))
          .selectedLevel,
      isNull,
    );

    await tester.scrollUntilVisible(
      find.text('Topping Tambahan'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byType(AppToppingTile), findsWidgets);
  });

  testWidgets('Jus Jeruk menampilkan suhu Dingin dan Panas', (tester) async {
    await pumpDetail(tester, id: 'jus-jeruk');

    expect(find.text('Jus Jeruk'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Suhu Penyajian'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    final selector = find.byType(AppTemperatureSelector);
    expect(selector, findsOneWidget);
    expect(tester.widget<AppTemperatureSelector>(selector).selected, isNull);

    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();

    expect(find.text('Pilih suhu penyajian dulu ya.'), findsOneWidget);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MenuDetailPage)),
    );
    expect(container.read(cartProvider).itemCount, 0);

    await tester.tap(find.text('Panas'));
    await tester.pump();

    expect(tester.widget<AppTemperatureSelector>(selector).selected, 'Panas');
    expect(find.byType(AppToppingTile), findsNothing);

    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();

    expect(container.read(cartProvider).itemCount, 1);
  });

  testWidgets('Camilan hanya menampilkan info, catatan, dan bottom bar', (
    tester,
  ) async {
    await pumpDetail(tester, id: 'nuget-crispy');

    await tester.scrollUntilVisible(
      find.text('Catatan untuk Penjual'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Catatan untuk Penjual'), findsOneWidget);
    expect(find.byType(AppSpiceSelector), findsNothing);
    expect(find.byType(AppToppingTile), findsNothing);
    expect(find.byType(AppTemperatureSelector), findsNothing);
    expect(find.text('Tambah ke Keranjang'), findsOneWidget);
  });

  testWidgets('detail Mie Rawit menghitung total dan menambah keranjang', (
    tester,
  ) async {
    await pumpDetail(tester);

    expect(find.text('Mie Rawit Hijau'), findsOneWidget);
    expect(find.text('Rp 12.000'), findsWidgets);
    expect(find.text('Rp 15.000'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Level 2 - Pedas Nampol'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Level 2 - Pedas Nampol'), findsOneWidget);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MenuDetailPage)),
    );

    // Tanpa level pedas, CTA harus menampilkan validasi.
    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();
    expect(find.text('Pilih tingkat kepedasan dulu ya.'), findsOneWidget);
    expect(container.read(cartProvider).itemCount, 0);

    await tester.tap(find.text('Level 2 - Pedas Nampol'));
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('Telur Mata Sapi / Dadar Ekstra'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Telur Mata Sapi / Dadar Ekstra'));
    await tester.pump();

    expect(find.text('Rp 16.000'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pump();

    expect(find.text('Rp 32.000'), findsOneWidget);

    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();

    final toastOpacity = tester.widget<AnimatedOpacity>(
      find
          .ancestor(
            of: find.text('Mie Rawit Hijau masuk ke keranjang!'),
            matching: find.byType(AnimatedOpacity),
          )
          .first,
    );
    expect(toastOpacity.opacity, 1);

    expect(container.read(cartProvider).itemCount, 2);
    expect(container.read(cartProvider).total, 42000);

    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pump(const Duration(milliseconds: 300));
  });

  testWidgets('catatan dibatasi 120 karakter', (tester) async {
    await pumpDetail(tester);

    await tester.scrollUntilVisible(
      find.byType(TextField),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(find.byType(TextField), 'a' * 130);
    await tester.pump();

    expect(find.text('120/120'), findsOneWidget);
  });

  testWidgets('share dan favorite memberi feedback', (tester) async {
    await pumpDetail(tester);

    await tester.tap(find.byTooltip('Bagikan Menu'));
    await tester.pump();

    expect(
      find.text('Fitur bagikan belum tersedia di prototype.'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Hapus dari favorit'));
    await tester.pump();

    expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
  });

  testWidgets('detail aman di 320 dan text scale 2.0', (tester) async {
    await pumpDetail(tester, size: const Size(320, 568), textScale: 2);

    expect(tester.takeException(), isNull);
  });
}
