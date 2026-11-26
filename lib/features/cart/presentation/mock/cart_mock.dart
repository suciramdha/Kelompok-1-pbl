// MOCK ONLY — hapus saat backend tersedia.

class CartAddress {
  const CartAddress({
    required this.label,
    required this.tag,
    required this.address,
    required this.note,
  });

  final String label;
  final String tag;
  final String address;
  final String note;
}

const cartAddress = CartAddress(
  label: 'Kost Mahasiswa UI Depok',
  tag: 'Alamat Utama',
  address: 'Jl. Melati No. 14, Beji, Depok',
  note: 'Kamar No. B-07, Lantai 2 (Pagar Hitam samping warung kopi)',
);

class CartPaymentOption {
  const CartPaymentOption({
    required this.id,
    required this.title,
    required this.subtitle,
    this.tag,
  });

  final String id;
  final String title;
  final String subtitle;
  final String? tag;
}

const cartPaymentOptions = <CartPaymentOption>[
  CartPaymentOption(
    id: 'qris',
    title: 'QRIS / E-Wallet',
    subtitle: 'GoPay, OVO, ShopeePay, DANA, BCA',
    tag: 'Bebas Biaya',
  ),
  CartPaymentOption(
    id: 'cash',
    title: 'Tunai / COD saat Tiba',
    subtitle: 'Siapkan uang pas ke driver',
  ),
];

const cartDefaultPaymentMethodId = 'qris';

const cartDriverNoteTags = <String>[
  'Titip di pagar kost',
  'Jangan klakson (malam)',
  'Chat WA saat sampai',
];

const cartDefaultDriverNoteTag = 'Jangan klakson (malam)';

const cartDeliveryFee = 8000;
const cartServiceFee = 2000;
const cartDistanceLabel = '1.8 km';
