// MOCK ONLY — hapus saat backend tersedia.
import 'package:flutter/material.dart';

const kSeblakPrasmananId = 'seblak-prasmanan-komplit';

class CustomizeKuahOption {
  const CustomizeKuahOption({
    required this.id,
    required this.name,
    required this.description,
    this.tag,
  });

  final String id;
  final String name;
  final String description;
  final String? tag;
}

class CustomizeSpiceLevel {
  const CustomizeSpiceLevel({
    required this.level,
    required this.name,
    required this.description,
    required this.icon,
    this.recommended = false,
  });

  final int level;
  final String name;
  final String description;
  final IconData icon;
  final bool recommended;
}

class CustomizeTopping {
  const CustomizeTopping({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageSeed,
    this.maxQty = 20,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final String imageSeed;
  final int maxQty;
}

class CustomizeToppingGroup {
  const CustomizeToppingGroup({
    required this.icon,
    required this.label,
    required this.toppings,
  });

  final IconData icon;
  final String label;
  final List<CustomizeTopping> toppings;
}

class CustomizeModel {
  const CustomizeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.cookTime,
    required this.imageSeed,
    required this.kuahOptions,
    required this.spiceLevels,
    required this.toppingGroups,
  });

  final String id;
  final String name;
  final String description;
  final String cookTime;
  final String imageSeed;
  final List<CustomizeKuahOption> kuahOptions;
  final List<CustomizeSpiceLevel> spiceLevels;
  final List<CustomizeToppingGroup> toppingGroups;
}

const _kuahOptions = <CustomizeKuahOption>[
  CustomizeKuahOption(
    id: 'nyemek',
    name: 'Kuah Nyemek Gurih',
    description: 'Kental basah beraroma kencur bawang dan bumbu rempah medok',
    tag: 'Favorit',
  ),
  CustomizeKuahOption(
    id: 'segar',
    name: 'Kuah Pedas Berkuah Segar',
    description:
        'Kuah kaldu merah hangat berlimpah, sedap diseruput selagi panas',
  ),
  CustomizeKuahOption(
    id: 'kental',
    name: 'Kuah Kental Medok',
    description: 'Ekstra rempah rawit kental pekat dengan aroma tumis wangi khas Bandung',
  ),
];

const _spiceLevels = <CustomizeSpiceLevel>[
  CustomizeSpiceLevel(
    level: 0,
    name: 'Tanpa Cabe',
    description: 'Gurih Manis Original',
    icon: Icons.sentiment_satisfied_alt_rounded,
  ),
  CustomizeSpiceLevel(
    level: 1,
    name: 'Pedas Santai',
    description: '1 Sendok Sambal',
    icon: Icons.local_fire_department_rounded,
  ),
  CustomizeSpiceLevel(
    level: 2,
    name: 'Pedas Nampol',
    description: '3 Sendok Sambal Rawit',
    icon: Icons.local_fire_department_rounded,
    recommended: true,
  ),
  CustomizeSpiceLevel(
    level: 3,
    name: 'Pedas Jontor',
    description: '5 Sendok Sambal Rawit',
    icon: Icons.local_fire_department_rounded,
  ),
  CustomizeSpiceLevel(
    level: 4,
    name: 'Pedas Gila',
    description: '7 Sendok Cabe Rawit',
    icon: Icons.whatshot_rounded,
  ),
  CustomizeSpiceLevel(
    level: 5,
    name: 'Level Narako',
    description: '10 Sendok Cabe Domba',
    icon: Icons.dangerous_rounded,
  ),
];

const _toppingGroups = <CustomizeToppingGroup>[
  CustomizeToppingGroup(
    icon: Icons.bakery_dining_outlined,
    label: 'ANEKA KERUPUK & KARBO',
    toppings: [
      CustomizeTopping(
        id: 'kerupuk-bawang-oranye',
        name: 'Kerupuk Bawang Oranye',
        description: 'Kenyal khas seblak basah',
        price: 2000,
        imageSeed: 'kerupuk-bawang',
      ),
      CustomizeTopping(
        id: 'kerupuk-mawar-putih',
        name: 'Kerupuk Mawar Putih',
        description: 'Tekstur lembut kenyal',
        price: 2000,
        imageSeed: 'kerupuk-mawar',
      ),
      CustomizeTopping(
        id: 'makaroni-spiral',
        name: 'Makaroni Spiral',
        description: 'Menyerap kuah pedas gurih',
        price: 2000,
        imageSeed: 'makaroni',
      ),
      CustomizeTopping(
        id: 'mie-kuning-kwetiau',
        name: 'Mie Kuning / Kwetiau',
        description: 'Kenyang mantap padat',
        price: 3000,
        imageSeed: 'mie-kwetiau',
      ),
    ],
  ),
  CustomizeToppingGroup(
    icon: Icons.set_meal_outlined,
    label: 'FROZEN FOOD & ANEKA BAKSO GURIH',
    toppings: [
      CustomizeTopping(
        id: 'dumpling-keju',
        name: 'Dumpling Keju Lumer',
        description: 'Meleleh gurih saat digigit',
        price: 3500,
        imageSeed: 'dumpling',
      ),
      CustomizeTopping(
        id: 'chikuwa-ikan',
        name: 'Chikuwa Ikan',
        description: 'Olahan ikan lembut manis',
        price: 3000,
        imageSeed: 'chikuwa',
      ),
      CustomizeTopping(
        id: 'cuanki-lidah',
        name: 'Cuanki Lidah Crispy',
        description: 'Kriuk gurih rendam kuah',
        price: 2500,
        imageSeed: 'cuanki',
      ),
      CustomizeTopping(
        id: 'siomay-mini',
        name: 'Siomay Mini Kering',
        description: 'Garing renyah ekstra gurih',
        price: 2000,
        imageSeed: 'siomay',
      ),
      CustomizeTopping(
        id: 'sosis-sapi-bakar',
        name: 'Sosis Sapi Bakar Potong',
        description: 'Daging sapi beraroma asap',
        price: 3000,
        imageSeed: 'sosis',
      ),
      CustomizeTopping(
        id: 'bakso-sapi-urat',
        name: 'Bakso Sapi Urat',
        description: 'Kenyal padat daging asli',
        price: 4000,
        imageSeed: 'bakso',
      ),
    ],
  ),
  CustomizeToppingGroup(
    icon: Icons.egg_outlined,
    label: 'PROTEIN & SAYURAN SEGAR',
    toppings: [
      CustomizeTopping(
        id: 'ceker-ayam',
        name: 'Ceker Ayam Empuk',
        description: 'Presto lembut copot tulang',
        price: 3000,
        imageSeed: 'ceker',
      ),
      CustomizeTopping(
        id: 'telur-ayam',
        name: 'Telur Ayam Segar',
        description: 'Bisa orak-arik / ceplok utuh',
        price: 4000,
        imageSeed: 'telur',
      ),
      CustomizeTopping(
        id: 'jamur-enoki',
        name: 'Jamur Enoki Segar',
        description: 'Krenyes kenyal segar',
        price: 3500,
        imageSeed: 'enoki',
      ),
      CustomizeTopping(
        id: 'sayur-sawi',
        name: 'Sayur Sawi Hijau',
        description: 'Segar penyeimbang pedas',
        price: 2000,
        imageSeed: 'sawi',
      ),
    ],
  ),
];

const seblakPrasmananCustomize = CustomizeModel(
  id: kSeblakPrasmananId,
  name: 'Seblak Prasmanan',
  description:
      'Bebas pilih kuah rempah kencur, atur level pedas narako, dan ambil '
      'topping favorit sepuasmu!',
  cookTime: '10-15 Menit Masak',
  imageSeed: 'seblak-prasmanan',
  kuahOptions: _kuahOptions,
  spiceLevels: _spiceLevels,
  toppingGroups: _toppingGroups,
);

const _customizeModels = <String, CustomizeModel>{
  kSeblakPrasmananId: seblakPrasmananCustomize,
};

CustomizeModel? customizeById(String id) => _customizeModels[id];
