import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lokuak/app/theme/app_theme.dart';
import 'package:lokuak/core/ui/app_option_card.dart';
import 'package:lokuak/features/cart/presentation/providers/cart_provider.dart';
import 'package:lokuak/features/menu/presentation/mock/customize_mock.dart';
import 'package:lokuak/features/menu/presentation/pages/menu_customize_page.dart';
import 'package:lokuak/features/menu/presentation/widgets/customize_spice_grid.dart';
import 'package:lokuak/features/menu/presentation/widgets/customize_topping_row.dart';

Future<void> pumpCustomize(
  WidgetTester tester, {
  String id = kSeblakPrasmananId,
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
          child: MenuCustomizePage(id: id),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('menampilkan hero, info, empat section, dan bottom bar', (
    tester,
  ) async {
    await pumpCustomize(tester);

    expect(find.text('Prasmanan Spesial'), findsOneWidget);
    expect(find.text('Seblak Prasmanan'), findsOneWidget);
    expect(find.text('10-15 Menit Masak'), findsOneWidget);

    expect(find.text('Pilih Jenis Kuah Seblak'), findsOneWidget);
    expect(find.text('Total Racikan (0 Topping)'), findsOneWidget);
    expect(find.text('Tambah ke Keranjang'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Tingkat Kepedasan (Cabe Rawit)'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Tingkat Kepedasan (Cabe Rawit)'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Pilih Topping Prasmanan'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Pilih Topping Prasmanan'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Catatan untuk Penjual'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Catatan untuk Penjual'), findsOneWidget);
  });

  testWidgets('kuah dan level pedas bersifat single-select', (tester) async {
    await pumpCustomize(tester);

    expect(
      tester
          .widget<AppOptionCard>(
            find.ancestor(
              of: find.text('Kuah Nyemek Gurih'),
              matching: find.byType(AppOptionCard),
            ),
          )
          .selected,
      isFalse,
    );

    await tester.scrollUntilVisible(
      find.text('Kuah Pedas Berkuah Segar'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Kuah Pedas Berkuah Segar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kuah Pedas Berkuah Segar'));
    await tester.pump();

    expect(
      tester
          .widget<AppOptionCard>(
            find.ancestor(
              of: find.text('Kuah Pedas Berkuah Segar'),
              matching: find.byType(AppOptionCard),
            ),
          )
          .selected,
      isTrue,
    );
    expect(
      tester
          .widget<AppOptionCard>(
            find.ancestor(
              of: find.text('Kuah Nyemek Gurih'),
              matching: find.byType(AppOptionCard),
            ),
          )
          .selected,
      isFalse,
    );

    await tester.scrollUntilVisible(
      find.text('Pedas Jontor'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Pedas Jontor'));
    await tester.pumpAndSettle();

    expect(
      tester
          .widget<CustomizeSpiceGrid>(find.byType(CustomizeSpiceGrid))
          .selectedLevel,
      isNull,
    );

    await tester.tap(find.text('Pedas Jontor'));
    await tester.pump();

    expect(
      tester
          .widget<CustomizeSpiceGrid>(find.byType(CustomizeSpiceGrid))
          .selectedLevel,
      3,
    );
  });

  testWidgets('qty topping memperbarui total dan jumlah racikan', (
    tester,
  ) async {
    await pumpCustomize(tester);

    await tester.tap(find.text('Kuah Nyemek Gurih'));
    await tester.pump();
    await tester.scrollUntilVisible(
      find.text('Pedas Jontor'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Pedas Jontor'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pedas Jontor'));
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('Dumpling Keju Lumer'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    final row = find.ancestor(
      of: find.text('Dumpling Keju Lumer'),
      matching: find.byType(CustomizeToppingRow),
    );
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();

    // Kondisi awal: qty 0 hanya menampilkan tombol tambah (collapsed).
    expect(
      find.descendant(of: row, matching: find.byIcon(Icons.add_rounded)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: row, matching: find.byIcon(Icons.remove_rounded)),
      findsNothing,
    );
    expect(find.descendant(of: row, matching: find.text('0')), findsNothing);

    await tester.tap(
      find.descendant(of: row, matching: find.byIcon(Icons.add_rounded)),
    );
    await tester.pump();

    // Setelah ditambah: counter minus/nilai/plus muncul.
    expect(
      find.descendant(of: row, matching: find.byIcon(Icons.remove_rounded)),
      findsOneWidget,
    );
    expect(find.descendant(of: row, matching: find.text('1')), findsOneWidget);

    expect(find.text('Total Racikan (1 Topping)'), findsOneWidget);
    expect(find.text('Rp 3.500'), findsWidgets);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MenuCustomizePage)),
    );
    expect(container.read(cartProvider).itemCount, 0);

    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();

    expect(container.read(cartProvider).itemCount, 1);
    expect(container.read(cartProvider).total, 13500);

    final toastOpacity = tester.widget<AnimatedOpacity>(
      find
          .ancestor(
            of: find.text('Racikan seblak ditambahkan ke keranjang!'),
            matching: find.byType(AnimatedOpacity),
          )
          .first,
    );
    expect(toastOpacity.opacity, 1);

    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pump(const Duration(milliseconds: 300));
  });

  testWidgets('validasi racikan wajib sebelum tambah ke keranjang', (
    tester,
  ) async {
    await pumpCustomize(tester);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MenuCustomizePage)),
    );
    expect(container.read(cartProvider).itemCount, 0);

    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();
    expect(find.text('Pilih jenis kuah seblak dulu ya.'), findsOneWidget);
    expect(container.read(cartProvider).itemCount, 0);

    await tester.tap(find.text('Kuah Nyemek Gurih'));
    await tester.pump();
    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();
    expect(find.text('Pilih tingkat kepedasan dulu ya.'), findsOneWidget);
    expect(container.read(cartProvider).itemCount, 0);

    await tester.scrollUntilVisible(
      find.text('Pedas Jontor'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Pedas Jontor'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pedas Jontor'));
    await tester.pump();
    expect(
      tester
          .widget<CustomizeSpiceGrid>(find.byType(CustomizeSpiceGrid))
          .selectedLevel,
      3,
    );
    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pumpAndSettle();
    expect(
      find.text('Pilih minimal 1 topping prasmanan dulu ya.'),
      findsOneWidget,
    );
    expect(container.read(cartProvider).itemCount, 0);

    await tester.scrollUntilVisible(
      find.text('Dumpling Keju Lumer'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    final row = find.ancestor(
      of: find.text('Dumpling Keju Lumer'),
      matching: find.byType(CustomizeToppingRow),
    );
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: row, matching: find.byIcon(Icons.add_rounded)),
    );
    await tester.pump();

    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump();

    expect(container.read(cartProvider).itemCount, 1);
  });

  testWidgets('catatan dibatasi 120 karakter', (tester) async {
    await pumpCustomize(tester);

    await tester.scrollUntilVisible(
      find.byType(TextField),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(find.byType(TextField), 'a' * 130);
    await tester.pump();

    expect(find.text('120/120'), findsOneWidget);
  });

  testWidgets('id non-customizable memakai placeholder', (tester) async {
    await pumpCustomize(tester, id: 'mie-rawit-hijau');

    expect(
      find.text('Halaman ini akan diimplementasikan pada tahap berikutnya.'),
      findsOneWidget,
    );
  });

  testWidgets('aman di 320 dan text scale 2.0', (tester) async {
    await pumpCustomize(tester, size: const Size(320, 568), textScale: 2);

    expect(tester.takeException(), isNull);
  });

  testWidgets('aman di landscape phone', (tester) async {
    await pumpCustomize(tester, size: const Size(844, 390));

    expect(tester.takeException(), isNull);
  });
}
