// MOCK ONLY — state racikan seblak prasmanan sementara.
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/customize_mock.dart';

class CustomizeState {
  const CustomizeState({
    required this.product,
    required this.kuahId,
    required this.spiceLevel,
    required this.quantities,
    required this.note,
  });

  final CustomizeModel product;
  final String? kuahId;
  final int? spiceLevel;
  final Map<String, int> quantities;
  final String note;

  /// Jumlah porsi topping, menghitung unit bukan jenis.
  int get unitCount =>
      quantities.values.fold(0, (sum, quantity) => sum + quantity);

  /// Total racikan: Σ(harga × qty), tanpa harga dasar.
  int get total {
    var sum = 0;
    for (final group in product.toppingGroups) {
      for (final topping in group.toppings) {
        final quantity = quantities[topping.id];
        if (quantity == null || quantity <= 0) continue;
        sum += topping.price * quantity;
      }
    }
    return sum;
  }

  int quantityOf(String toppingId) => quantities[toppingId] ?? 0;

  bool isKuahSelected(String id) => kuahId == id;

  CustomizeState copyWith({
    CustomizeModel? product,
    String? kuahId,
    int? spiceLevel,
    Map<String, int>? quantities,
    String? note,
  }) {
    return CustomizeState(
      product: product ?? this.product,
      kuahId: kuahId ?? this.kuahId,
      spiceLevel: spiceLevel ?? this.spiceLevel,
      quantities: quantities ?? this.quantities,
      note: note ?? this.note,
    );
  }
}

class CustomizeNotifier extends Notifier<CustomizeState> {
  @override
  CustomizeState build() {
    final product = customizeById(kSeblakPrasmananId)!;
    return CustomizeState(
      product: product,
      kuahId: null,
      spiceLevel: null,
      quantities: const {},
      note: '',
    );
  }

  void selectKuah(String id) {
    if (!state.product.kuahOptions.any((option) => option.id == id)) return;
    state = state.copyWith(kuahId: id);
  }

  void selectSpiceLevel(int level) {
    if (!state.product.spiceLevels.any((item) => item.level == level)) return;
    state = state.copyWith(spiceLevel: level);
  }

  void incrementTopping(String id) {
    final topping = _toppingById(id);
    if (topping == null) return;
    final current = state.quantityOf(id);
    if (current >= topping.maxQty) return;
    state = state.copyWith(
      quantities: Map<String, int>.unmodifiable({
        ...state.quantities,
        id: current + 1,
      }),
    );
  }

  void decrementTopping(String id) {
    final current = state.quantityOf(id);
    if (current <= 0) return;
    final next = Map<String, int>.of(state.quantities);
    if (current == 1) {
      next.remove(id);
    } else {
      next[id] = current - 1;
    }
    state = state.copyWith(quantities: Map<String, int>.unmodifiable(next));
  }

  void setNote(String value) {
    state = state.copyWith(note: value);
  }

  void reset() {
    final product = state.product;
    state = CustomizeState(
      product: product,
      kuahId: null,
      spiceLevel: null,
      quantities: const {},
      note: '',
    );
  }

  CustomizeTopping? _toppingById(String id) {
    for (final group in state.product.toppingGroups) {
      for (final topping in group.toppings) {
        if (topping.id == id) return topping;
      }
    }
    return null;
  }
}

final customizeProvider = NotifierProvider<CustomizeNotifier, CustomizeState>(
  CustomizeNotifier.new,
);
