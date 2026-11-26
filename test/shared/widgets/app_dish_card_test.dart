import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lokuak/app/theme/app_theme.dart';
import 'package:lokuak/shared/widgets/app_dish_card.dart';
import 'package:lokuak/shared/widgets/app_dish_grid_card.dart';

void main() {
  testWidgets('dish card menjadi tap target tanpa tombol tambah', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: AppDishCard(
            name: 'Mie Rawit Hijau',
            description: 'Bumbu uleg rawit hijau segar.',
            price: 12000,
            imageUrl: 'https://example.com/mie-rawit.png',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add_rounded), findsNothing);

    await tester.tap(find.byType(AppDishCard));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('dish grid card menjadi tap target tanpa tombol tambah', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 180,
              height: 280,
              child: AppDishGridCard(
                name: 'Nuget Goreng',
                description: '5 pcs renyah + saus.',
                price: 10000,
                imageUrl: 'https://example.com/nuget.png',
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add_rounded), findsNothing);

    await tester.tap(find.byType(AppDishGridCard));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
