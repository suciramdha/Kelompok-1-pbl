/// Sumber gambar remote untuk prototype.
///
/// Tidak ada gambar desain yang disimpan di `assets/`.
abstract final class RemoteImages {
  static const _hero =
      'https://images.unsplash.com/photo-1555126634-323283e090fa';
  static const _noodles =
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624';
  static const _rice =
      'https://images.unsplash.com/photo-1603133872878-684f208fb84b';
  static const _chicken =
      'https://images.unsplash.com/photo-1532550907401-a500c9a57435';
  static const _snack =
      'https://images.unsplash.com/photo-1541592106381-b31e9677c0e5';
  static const _tea =
      'https://images.unsplash.com/photo-1556679343-c7306c1976bc';
  static const _juice =
      'https://images.unsplash.com/photo-1623065422902-30a2d299bbe4';
  static const _foodSpread =
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836';

  static String dish(String seed, {int width = 600, int height = 600}) {
    final base = switch (seed) {
      'seblak-komplit' ||
      'seblak-prasmanan' ||
      'mie-rawit-hijau' ||
      'mie-jontor' ||
      'mie-narako' ||
      'minas' => _noodles,
      'nasi-goreng-spesial' || 'nasgor-ayam-penyet' => _rice,
      'nasi-ayam-penyet-korek' ||
      'nasi-katsu-sambal-bawang' ||
      'chicken-katsu' ||
      'chicken-katsu-alacarte' => _chicken,
      'nuget-crispy' ||
      'sosis-mekar' ||
      'kentang-gurih' ||
      'piscok-lumer' => _snack,
      'teh-telur-padang' || 'teh-es-jumbo' || 'es-kosong' => _tea,
      'jus-jeruk' || 'jus-pokat' => _juice,
      _ => _foodSpread,
    };
    return '$base?w=$width&h=$height&fit=crop&q=80&auto=format';
  }

  static String topping(String seed, {int size = 160}) {
    final base = switch (seed) {
      'kerupuk-bawang' ||
      'kerupuk-mawar' ||
      'makaroni' ||
      'mie-kwetiau' => _snack,
      'dumpling' || 'chikuwa' || 'cuanki' || 'siomay' => _noodles,
      'sosis' || 'bakso' || 'ceker' || 'telur' => _chicken,
      'enoki' || 'sawi' => _foodSpread,
      _ => _foodSpread,
    };
    return '$base?w=$size&h=$size&fit=crop&q=80&auto=format';
  }

  static String hero(String seed, {int width = 800, int height = 600}) {
    return '$_hero?w=$width&h=$height&fit=crop&q=80&auto=format';
  }

  static String avatar(String seed, {int size = 200}) {
    return 'https://i.pravatar.cc/$size?u=lokuak-$seed';
  }

  static String placeholder(String label, {int width = 600, int height = 400}) {
    final encoded = Uri.encodeComponent(label);
    return 'https://placehold.co/${width}x$height/EEEEEE/666666?text=$encoded';
  }
}
