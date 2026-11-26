// MOCK ONLY — hapus saat backend tersedia.

enum HomeCategory { all, seblak, food, snack, drink }

extension HomeCategoryX on HomeCategory {
  String get label => switch (this) {
    HomeCategory.all => 'Semua',
    HomeCategory.seblak => 'Seblak',
    HomeCategory.food => 'Makanan',
    HomeCategory.snack => 'Cemilan',
    HomeCategory.drink => 'Minuman',
  };
}

class DishModel {
  const DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageSeed,
    this.spiceLevel,
    this.spiceLabel,
    this.badge,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final HomeCategory category;
  final String imageSeed;
  final int? spiceLevel;
  final String? spiceLabel;
  final String? badge;
}

const featuredDish = DishModel(
  id: 'seblak-prasmanan-komplit',
  name: 'Seblak Prasmanan',
  description: 'Pilih kuah Original Kencur, Pedas Korea, atau Tomyum. Bebas pilih aneka topping!',
  price: 10000,
  category: HomeCategory.seblak,
  imageSeed: 'seblak-komplit',
  spiceLevel: 3,
  spiceLabel: 'Lvl 0–5',
  badge: 'Best Seller #1',
);

const foodDishes = <DishModel>[
  DishModel(
    id: 'mie-rawit-hijau',
    name: 'Mie Rawit Hijau',
    description: 'Bumbu uleg rawit hijau segar, pedas gurih nagih.',
    price: 12000,
    category: HomeCategory.food,
    imageSeed: 'mie-rawit-hijau',
    spiceLevel: 2,
    spiceLabel: 'Lvl 1–3',
  ),
  DishModel(
    id: 'nasi-goreng-spesial',
    name: 'Nasi Goreng',
    description: 'Nasi goreng wangi smoky dengan suwiran ayam & telur.',
    price: 12000,
    category: HomeCategory.food,
    imageSeed: 'nasi-goreng-spesial',
  ),
  DishModel(
    id: 'mie-jontor',
    name: 'Mie Jontor',
    description: 'Olahan mie kuah nyemek super pedas cabe merah.',
    price: 12000,
    category: HomeCategory.food,
    imageSeed: 'mie-jontor',
    spiceLevel: 4,
    spiceLabel: 'Pedas Pol',
  ),
  DishModel(
    id: 'nasi-ayam-penyet-korek',
    name: 'Nasi Ayam Penyet',
    description: 'Ayam goreng gurih digeprek sambal korek minyak panas.',
    price: 18000,
    category: HomeCategory.food,
    imageSeed: 'ayam-penyet-korek',
    spiceLevel: 3,
    spiceLabel: 'Pedas',
  ),
  DishModel(
    id: 'mie-narako',
    name: 'Mie Narako',
    description: 'Sensasi pedas manis rempah khas Seblak Lokuak.',
    price: 12000,
    category: HomeCategory.food,
    imageSeed: 'mie-narako',
    spiceLevel: 2,
    spiceLabel: 'Lvl 1–3',
  ),
  DishModel(
    id: 'nasgor-ayam-penyet',
    name: 'Nasi Goreng Ayam Penyet',
    description: 'Kombinasi nasi goreng spesial + paha ayam penyet pedas.',
    price: 22000,
    category: HomeCategory.food,
    imageSeed: 'nasgor-ayam-penyet',
    spiceLevel: 3,
    spiceLabel: 'Pedas',
  ),
  DishModel(
    id: 'nasi-katsu-sambal-bawang',
    name: 'Nasi Chicken Katsu',
    description: 'Chicken katsu renyah berpadu sambal bawang melimpah.',
    price: 15000,
    category: HomeCategory.food,
    imageSeed: 'nasi-katsu',
  ),
  DishModel(
    id: 'minas',
    name: 'MieNas',
    description: 'Paduan mie goreng dan nasi goreng khas porsi kenyang.',
    price: 15000,
    category: HomeCategory.food,
    imageSeed: 'minas',
  ),
];

const snackDishes = <DishModel>[
  DishModel(
    id: 'nuget-crispy',
    name: 'Nuget Goreng',
    description: '5 pcs renyah + saus.',
    price: 10000,
    category: HomeCategory.snack,
    imageSeed: 'nuget-crispy',
  ),
  DishModel(
    id: 'sosis-mekar',
    name: 'Sosis Goreng',
    description: 'Bumbu tabur balado.',
    price: 10000,
    category: HomeCategory.snack,
    imageSeed: 'sosis-mekar',
  ),
  DishModel(
    id: 'kentang-gurih',
    name: 'Kentang Goreng',
    description: 'Renyah rasa keju/asin.',
    price: 10000,
    category: HomeCategory.snack,
    imageSeed: 'kentang-gurih',
  ),
  DishModel(
    id: 'piscok-lumer',
    name: 'Pisang Coklat',
    description: 'Kulit krispi isi cokelat.',
    price: 10000,
    category: HomeCategory.snack,
    imageSeed: 'piscok-lumer',
  ),
  DishModel(
    id: 'chicken-katsu-alacarte',
    name: 'Chicken Katsu',
    description: 'Daging ayam tebal fillet murni.',
    price: 12000,
    category: HomeCategory.snack,
    imageSeed: 'chicken-katsu',
  ),
];

const drinkDishes = <DishModel>[
  DishModel(
    id: 'teh-telur-padang',
    name: 'Teh Telur',
    description: 'Stamina & creamy nikmat berbusa.',
    price: 10000,
    category: HomeCategory.drink,
    imageSeed: 'teh-telur',
  ),
  DishModel(
    id: 'teh-es-jumbo',
    name: 'Teh Es',
    description: 'Penyegar dahaga porsi gelas besar.',
    price: 5000,
    category: HomeCategory.drink,
    imageSeed: 'teh-es-jumbo',
  ),
  DishModel(
    id: 'es-kosong',
    name: 'Es Kosong',
    description: 'Air mineral dingin & es batu kristal.',
    price: 2000,
    category: HomeCategory.drink,
    imageSeed: 'es-kosong',
  ),
  DishModel(
    id: 'jus-jeruk',
    name: 'Jus Jeruk',
    description: 'Jeruk peras asli kaya vitamin C.',
    price: 10000,
    category: HomeCategory.drink,
    imageSeed: 'jus-jeruk',
  ),
  DishModel(
    id: 'jus-pokat',
    name: 'Jus Pokat',
    description: 'Alpukat mentega legit dengan susu cokelat.',
    price: 10000,
    category: HomeCategory.drink,
    imageSeed: 'jus-pokat',
  ),
];

const categories = HomeCategory.values;
