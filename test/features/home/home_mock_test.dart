import 'package:flutter_test/flutter_test.dart';
import 'package:lokuak/features/home/presentation/mock/home_mock.dart';

void main() {
  test('mock Beranda memiliki konten yang lengkap', () {
    expect(categories, hasLength(5));
    expect(featuredDish.price, 10000);
    expect(foodDishes, hasLength(8));
    expect(snackDishes, hasLength(5));
    expect(drinkDishes, hasLength(5));
    expect(foodDishes.any((dish) => dish.spiceLevel != null), isTrue);
  });
}
