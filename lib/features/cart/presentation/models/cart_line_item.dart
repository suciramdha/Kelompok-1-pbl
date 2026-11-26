class CartLineItem {
  const CartLineItem({
    required this.id,
    required this.name,
    required this.details,
    required this.imageSeed,
    required this.unitPrice,
    this.quantity = 1,
    this.note,
    this.spiceLevel,
  });

  final String id;
  final String name;
  final String details;
  final String imageSeed;
  final int unitPrice;
  final int quantity;
  final String? note;
  final int? spiceLevel;

  int get lineTotal => unitPrice * quantity;

  CartLineItem copyWith({int? quantity}) {
    return CartLineItem(
      id: id,
      name: name,
      details: details,
      imageSeed: imageSeed,
      unitPrice: unitPrice,
      quantity: quantity ?? this.quantity,
      note: note,
      spiceLevel: spiceLevel,
    );
  }

  /// Mengubah atau menghapus catatan item; `null` menghapus catatan.
  CartLineItem withNote(String? note) {
    return CartLineItem(
      id: id,
      name: name,
      details: details,
      imageSeed: imageSeed,
      unitPrice: unitPrice,
      quantity: quantity,
      note: note,
      spiceLevel: spiceLevel,
    );
  }
}
