// MOCK ONLY — hapus saat backend tersedia.
import 'package:flutter/material.dart';

import '../../../../core/ui/app_spice_selector.dart';
import '../widgets/menu_hero.dart';

class ToppingOption {
  const ToppingOption({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  final String id;
  final String name;
  final String description;
  final int price;
}

class MenuDetailModel {
  const MenuDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageSeed,
    this.heroBadges = const [],
    this.cookTime,
    this.spiceOptions = const [],
    this.toppings = const [],
    this.temperatureOptions = const [],
    this.noteMaxLength = 120,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final int? originalPrice;
  final String imageSeed;
  final List<MenuHeroBadge> heroBadges;
  final String? cookTime;
  final List<AppSpiceOption> spiceOptions;
  final List<ToppingOption> toppings;
  final List<String> temperatureOptions;
  final int noteMaxLength;
}

const _toppings = <ToppingOption>[
  ToppingOption(
    id: 'telur-ekstra',
    name: 'Telur Mata Sapi / Dadar Ekstra',
    description: 'Setengah matang / matang',
    price: 4000,
  ),
  ToppingOption(
    id: 'sosis-bakar',
    name: 'Sosis Bakar Iris',
    description: 'Sosis sapi smoky gurih',
    price: 3000,
  ),
  ToppingOption(
    id: 'bakso-goreng',
    name: 'Bakso Sapi Goreng Crispy',
    description: 'Garing luar, empuk dagingnya',
    price: 4000,
  ),
  ToppingOption(
    id: 'kerupuk-bawang',
    name: 'Kerupuk Bawang Pedas Gurih',
    description: 'Kriuk renyah tabur bubuk cabai',
    price: 2000,
  ),
  ToppingOption(
    id: 'pangsit-goreng',
    name: 'Pangsit Goreng Renyah',
    description: 'Isi olahan ayam cincang mini (3 pcs)',
    price: 3000,
  ),
];

const _spiceOptions = <AppSpiceOption>[
  AppSpiceOption(
    level: 1,
    title: 'Level 1 - Pedas Santai',
    tag: 'Gurih',
    description: 'Rawit hijau uleg tipis-tipis, pas untuk pemula.',
  ),
  AppSpiceOption(
    level: 2,
    title: 'Level 2 - Pedas Nampol',
    tag: 'Favorit',
    description: 'Rawit hijau dobel uleg mantap, pedas & gurih nagih.',
    tagIcon: Icons.thumb_up_rounded,
  ),
  AppSpiceOption(
    level: 3,
    title: 'Level 3 - Pedas Narako',
    tag: 'Ekstrem',
    description: 'Ekstra rawit hijau setan segar melimpah, siap basah kuyup!',
    tagIcon: Icons.whatshot_rounded,
  ),
];

const mieRawitDetail = MenuDetailModel(
  id: 'mie-rawit-hijau',
  name: 'Mie Rawit Hijau',
  description:
      'Mie kenyal gurih dibalut bumbu uleg cabe rawit hijau segar khas racikan '
      'dapur pedas, disajikan dengan telur ceplok setengah matang, taburan '
      'bawang goreng renyah, dan irisan timun segar.',
  price: 12000,
  originalPrice: 15000,
  imageSeed: 'mie-rawit-hijau',
  heroBadges: [
    MenuHeroBadge(
      label: 'Terlaris #2',
      icon: Icons.local_fire_department_rounded,
      emphasized: true,
    ),
  ],
  cookTime: '15-20 Menit Masak',
  spiceOptions: _spiceOptions,
  toppings: _toppings,
);

const nasiGorengSpesialDetail = MenuDetailModel(
  id: 'nasi-goreng-spesial',
  name: 'Nasi Goreng',
  description: 'Nasi goreng wangi smoky dengan suwiran ayam & telur.',
  price: 12000,
  imageSeed: 'nasi-goreng-spesial',
  toppings: _toppings,
);

const mieJontorDetail = MenuDetailModel(
  id: 'mie-jontor',
  name: 'Mie Jontor',
  description: 'Olahan mie kuah nyemek super pedas cabe merah.',
  price: 12000,
  imageSeed: 'mie-jontor',
  spiceOptions: _spiceOptions,
  toppings: _toppings,
);

const nasiAyamPenyetKorekDetail = MenuDetailModel(
  id: 'nasi-ayam-penyet-korek',
  name: 'Nasi Ayam Penyet',
  description: 'Ayam goreng gurih digeprek sambal korek minyak panas.',
  price: 18000,
  imageSeed: 'ayam-penyet-korek',
  toppings: _toppings,
);

const mieNarakoDetail = MenuDetailModel(
  id: 'mie-narako',
  name: 'Mie Narako',
  description: 'Sensasi pedas manis rempah khas Seblak Lokuak.',
  price: 12000,
  imageSeed: 'mie-narako',
  spiceOptions: _spiceOptions,
  toppings: _toppings,
);

const nasgorAyamPenyetDetail = MenuDetailModel(
  id: 'nasgor-ayam-penyet',
  name: 'Nasi Goreng Ayam Penyet',
  description: 'Kombinasi nasi goreng spesial + paha ayam penyet pedas.',
  price: 22000,
  imageSeed: 'nasgor-ayam-penyet',
  toppings: _toppings,
);

const nasiKatsuSambalBawangDetail = MenuDetailModel(
  id: 'nasi-katsu-sambal-bawang',
  name: 'Nasi Chicken Katsu',
  description: 'Chicken katsu renyah berpadu sambal bawang melimpah.',
  price: 15000,
  imageSeed: 'nasi-katsu',
  toppings: _toppings,
);

const minasDetail = MenuDetailModel(
  id: 'minas',
  name: 'MieNas',
  description: 'Paduan mie goreng dan nasi goreng khas porsi kenyang.',
  price: 15000,
  imageSeed: 'minas',
  toppings: _toppings,
);

const nugetCrispyDetail = MenuDetailModel(
  id: 'nuget-crispy',
  name: 'Nuget Goreng',
  description: '5 pcs renyah + saus.',
  price: 10000,
  imageSeed: 'nuget-crispy',
);

const sosisMekarDetail = MenuDetailModel(
  id: 'sosis-mekar',
  name: 'Sosis Goreng',
  description: 'Bumbu tabur balado.',
  price: 10000,
  imageSeed: 'sosis-mekar',
);

const kentangGurihDetail = MenuDetailModel(
  id: 'kentang-gurih',
  name: 'Kentang Goreng',
  description: 'Renyah rasa keju/asin.',
  price: 10000,
  imageSeed: 'kentang-gurih',
);

const piscokLumerDetail = MenuDetailModel(
  id: 'piscok-lumer',
  name: 'Pisang Coklat',
  description: 'Kulit krispi isi cokelat.',
  price: 10000,
  imageSeed: 'piscok-lumer',
);

const chickenKatsuAlacarteDetail = MenuDetailModel(
  id: 'chicken-katsu-alacarte',
  name: 'Chicken Katsu',
  description: 'Daging ayam tebal fillet murni.',
  price: 12000,
  imageSeed: 'chicken-katsu',
);

const tehTelurPadangDetail = MenuDetailModel(
  id: 'teh-telur-padang',
  name: 'Teh Telur',
  description: 'Stamina & creamy nikmat berbusa.',
  price: 10000,
  imageSeed: 'teh-telur',
);

const tehEsJumboDetail = MenuDetailModel(
  id: 'teh-es-jumbo',
  name: 'Teh Es',
  description: 'Penyegar dahaga porsi gelas besar.',
  price: 5000,
  imageSeed: 'teh-es-jumbo',
);

const esKosongDetail = MenuDetailModel(
  id: 'es-kosong',
  name: 'Es Kosong',
  description: 'Air mineral dingin & es batu kristal.',
  price: 2000,
  imageSeed: 'es-kosong',
);

const jusJerukDetail = MenuDetailModel(
  id: 'jus-jeruk',
  name: 'Jus Jeruk',
  description: 'Jeruk peras asli kaya vitamin C.',
  price: 10000,
  imageSeed: 'jus-jeruk',
  temperatureOptions: ['Dingin', 'Panas'],
);

const jusPokatDetail = MenuDetailModel(
  id: 'jus-pokat',
  name: 'Jus Pokat',
  description: 'Alpukat mentega legit dengan susu cokelat.',
  price: 10000,
  imageSeed: 'jus-pokat',
);

const _menuDetails = <String, MenuDetailModel>{
  'mie-rawit-hijau': mieRawitDetail,
  'nasi-goreng-spesial': nasiGorengSpesialDetail,
  'mie-jontor': mieJontorDetail,
  'nasi-ayam-penyet-korek': nasiAyamPenyetKorekDetail,
  'mie-narako': mieNarakoDetail,
  'nasgor-ayam-penyet': nasgorAyamPenyetDetail,
  'nasi-katsu-sambal-bawang': nasiKatsuSambalBawangDetail,
  'minas': minasDetail,
  'nuget-crispy': nugetCrispyDetail,
  'sosis-mekar': sosisMekarDetail,
  'kentang-gurih': kentangGurihDetail,
  'piscok-lumer': piscokLumerDetail,
  'chicken-katsu-alacarte': chickenKatsuAlacarteDetail,
  'teh-telur-padang': tehTelurPadangDetail,
  'teh-es-jumbo': tehEsJumboDetail,
  'es-kosong': esKosongDetail,
  'jus-jeruk': jusJerukDetail,
  'jus-pokat': jusPokatDetail,
};

MenuDetailModel? menuDetailById(String id) => _menuDetails[id];
