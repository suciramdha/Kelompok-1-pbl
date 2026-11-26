# Beranda

> Dokumen kerja untuk halaman Beranda. Bukan design system dan bukan aturan
> global. Token ada di [`DESIGN.md`](../../design/DESIGN.md); registry komponen
> ada di [`components.md`](../../design/components.md).

| Field | Nilai |
| --- | --- |
| Halaman | Beranda |
| Route | `/home` |
| File utama | `lib/features/home/presentation/pages/home_page.dart` |
| Shell | `StatefulShellRoute.indexedStack`, branch 0 |
| Screen ID Stitch | `54c4f90aaeed4c4bb07def3ad1d3b0c5` |
| Status | `done` |
| Mock | `lib/features/home/presentation/mock/home_mock.dart`, `lib/features/cart/presentation/providers/cart_provider.dart` |
| Terakhir diperbarui | 2026-11-22 |
| Referensi | [`DESIGN.md`](../../design/DESIGN.md), [`components.md`](../../design/components.md), [`design-to-code.md`](../../rules/design-to-code.md) |

Status `done` berarti implementasi dan verifikasi utama sudah lulus.
Follow-up yang belum tertutup dicatat di §12.

---

## 1. Tujuan

Menjadi landing page aplikasi: menampilkan promo, kategori, dan daftar menu
sehingga pengguna bisa membuka Detail Menu, melihat ringkasan keranjang, dan
berpindah tab.

---

## 2. Scope

- Header brand, badge UMKM, status buka/ETA, notifikasi, dan alamat.
- Hero promo dengan CTA ke menu unggulan.
- Filter kategori horizontal: Semua, Seblak, Makanan, Cemilan, Minuman.
- Section Menu Juara & Best Seller.
- Section Makanan (list), Camilan (grid 2 kolom + item terakhir full-width),
  dan Minuman (list).
- Kartu menu dapat ditekan untuk membuka `/menu/:id`.
- Sticky order bar dengan ringkasan keranjang.
- Bottom navigation Beranda/Pesanan/Profil.
- Feedback prototype untuk notifikasi dan ubah alamat.

---

## 3. Di luar scope

- Isi dan perilaku Detail Menu; halaman terpisah dan sudah diimplementasikan
  untuk semua menu kecuali Seblak Prasmanan.
- Menambah item dari Beranda. Kartu saat ini hanya membuka Detail Menu; tidak
  ada tombol `+`.
- Halaman Keranjang, Pesanan, Tracking, dan Profil.
- Backend, API, database, auth, dan repository.
- Layar notifikasi dan pemilih alamat; saat ini hanya SnackBar.
- Search, favorit, dan dark mode.

---

## 4. Inventory (Gate 3)

| Screen | Section | Komponen desain | Token | Gambar | State | Interaksi |
| --- | --- | --- | --- | --- | --- | --- |
| `/home` | Header | `HomeHeader`, `AppUmkmBadge` | `surface`, `primary`, `outline-variant`, `elevation.header` | icon | default; pressed | Notifikasi dan `Ubah` memunculkan SnackBar |
| `/home` | Hero promo | `HeroBanner`, `AppButton`, `AppNetworkImage` | `primary`, `primary-container`, `on-primary`, `radius.xl`, `radius.full` | remote, foto bulat | default; compact; pressed | CTA membuka menu unggulan |
| `/home` | Filter kategori | `CategoryFilterBar`, `AppCategoryChip` | `secondary-container`, `surface-container-low`, `outline-variant` | none | selected; unselected | Tap mengubah section yang tampil |
| `/home` | Menu Juara | `FeaturedCard`, `AppButton`, `AppNetworkImage` | `surface-container-lowest`, `primary`, `price` | remote 16:9 | default; compact; pressed | CTA `Pilih Topping` membuka Detail Menu |
| `/home` | Makanan | `MenuSection`, `AppDishCard`, `AppSpiceLevelBadge` | `surface-container-lowest`, `primary`, `price` | remote thumbnail 96×96 | default; large text | Tap kartu membuka Detail Menu |
| `/home` | Camilan | `MenuSection` (`snackGrid`), `AppDishGridCard`, `AppDishCard` | `surface-container-lowest`, `primary`, `price` | remote grid ratio 1.5; thumbnail 96×96 | grid; fallback list; large text | Tap kartu membuka Detail Menu |
| `/home` | Minuman | `MenuSection`, `AppDishCard` | `surface-container-lowest`, `primary`, `price` | remote thumbnail 96×96 | default; large text | Tap kartu membuka Detail Menu |
| `/home` | Sticky order bar | `AppStickyOrderBar`, `AppButton` | `surface-container-lowest`, `primary`, `floating` | icon | normal; large text column | CTA `Lihat Pesanan` membuka `/cart` |
| `/home` | Bottom navigation | `AppBottomNav` | `surface`, `primary`, `on-surface-variant` | icon | active; inactive; badge | Pindah branch Beranda/Pesanan/Profil |
| `/home` | Feedback | `ScaffoldMessenger` + `SnackBar` | `inverse-surface` | none | info | Muncul lalu hilang otomatis |

Catatan: `AppDishCard`/`AppDishGridCard` adalah tap target seluruh kartu.
`FeaturedCard` bukan: hanya CTA `Pilih Topping`/`Pilih` yang membuka Detail
Menu.

---

## 5. Component map (Gate 4)

| Komponen desain | Widget existing | Aksi | Path | Alasan |
| --- | --- | --- | --- | --- |
| Header | `HomeHeader` | `reuse` | `lib/features/home/presentation/widgets/home_header.dart` | Sudah sesuai kebutuhan Beranda |
| Badge UMKM | `AppUmkmBadge` | `reuse` | `lib/core/ui/app_umkm_badge.dart` | Token dan label sudah terpusat |
| Hero | `HeroBanner` | `reuse` | `lib/features/home/presentation/widgets/hero_banner.dart` | Layout hero + CTA sudah ada |
| Filter kategori | `CategoryFilterBar`, `AppCategoryChip` | `reuse` | `lib/features/home/presentation/widgets/category_filter_bar.dart` | Data kategori dari mock |
| Featured card | `FeaturedCard` | `reuse` | `lib/features/home/presentation/widgets/featured_card.dart` | Hero 16:9 + CTA |
| Section menu | `MenuSection` | `reuse` | `lib/features/home/presentation/widgets/menu_section.dart` | Mendukung list dan `snackGrid` |
| Kartu list | `AppDishCard` | `reuse` | `lib/shared/widgets/app_dish_card.dart` | Tap target tunggal tanpa tombol tambah |
| Kartu grid | `AppDishGridCard` | `reuse` | `lib/shared/widgets/app_dish_grid_card.dart` | Grid 2 kolom Cemilan |
| Sticky bar | `AppStickyOrderBar` | `reuse` | `lib/core/layout/app_sticky_order_bar.dart` | Ringkasan + CTA keranjang |
| Bottom nav | `AppBottomNav` | `reuse` | `lib/core/layout/app_bottom_nav.dart` | 3 tab + badge pesanan |
| Gambar remote | `AppNetworkImage` | `reuse` | `lib/core/ui/app_network_image.dart` | Loading/error/fallback + semantics |
| Spice badge | `AppSpiceLevelBadge` | `reuse` | `lib/core/ui/app_spice_level_badge.dart` | Level pedas pada kartu |

Tidak ada komponen shared baru pada implementasi Beranda. Section Menu Juara
memakai private widget `_FeaturedSection` di `home_page.dart`.

---

## 6. State & interaksi

| State | Trigger | Perilaku |
| --- | --- | --- |
| Default | Buka `/home` | Filter `all`; semua section tampil; sticky bar disembunyikan selama keranjang kosong |
| Filter aktif | Tap chip | `homeFilterProvider` berubah; section disaring; hero tetap tampil |
| Buka menu | Tap `AppDishCard`/`AppDishGridCard` | `context.push('/menu/:id')` |
| Buka menu unggulan | Tap CTA hero atau `Pilih Topping` | `context.push('/menu/seblak-prasmanan-komplit')` |
| Buka keranjang | Tap CTA sticky bar | `context.push('/cart')` |
| Keranjang kosong | Semua item dihapus | Sticky bar disembunyikan; konten tetap dapat digulir |
| Pindah tab | Tap bottom nav | `goBranch` ke Beranda/Pesanan/Profil |
| Notifikasi | Tap icon lonceng | SnackBar `Belum ada notifikasi baru.` |
| Ubah alamat | Tap `Ubah` | SnackBar `Ubah alamat belum tersedia di prototype.` |
| Lebar < 360 | Layout | Hero dan FeaturedCard memakai varian compact |
| Text scale > 1.5 | Layout | Hero/Featured compact; harga `AppDishCard` turun full-width; sticky bar menjadi kolom |
| Text scale > 1.25 | Layout | Grid Cemilan fallback ke list |
| Gambar gagal | Loading/error `AppNetworkImage` | Placeholder/fallback dari `AppNetworkImage` |

Tidak ada state screen-level empty/loading/error karena data masih mock statis.
Loading/error hanya berlaku untuk gambar remote.

---

## 7. Data & mock

- `home_mock.dart` (`// MOCK ONLY`):
  - 5 kategori.
  - 1 featured dish (`seblak-prasmanan-komplit`).
  - 8 makanan, 5 camilan, 5 minuman.
- `home_filter_provider.dart`: state UI kategori, default `HomeCategory.all`.
- `cart_provider.dart` (`// MOCK ONLY`): state awal kosong.
  `addItem()` tersedia tetapi belum dipanggil dari Beranda.
- Gambar: `RemoteImages.dish(imageSeed)` dan
  `RemoteImages.hero('seblak-prasmanan')`.
- Batas backend: tidak ada database, API, repository, atau auth.

---

## 8. Copy

| Lokasi | Copy |
| --- | --- |
| Header | `Seblak Lokuak`, `UMKM`, `Buka`, `• 15–25 menit`, `Kirim ke: Jl. Melati No. 14, RT 03/05`, `Ubah` |
| Hero badge | `PROMO SPESIAL HARI INI` (normal), `PROMO SPESIAL` (compact) |
| Hero judul | `Seblak Prasmanan Juara` |
| Hero deskripsi | `Bebas racik topping & level pedas cabai rawit asli. Mulai 10rb langsung kenyang poll!` (normal), `Bebas racik topping & level pedas. Mulai Rp10rb!` (compact) |
| Hero CTA | `Coba Sekarang` (normal), `Coba` (compact) |
| Filter | `Semua`, `Seblak`, `Makanan`, `Cemilan`, `Minuman` |
| Judul section | `Menu Juara & Best Seller`, `Makanan & Menu Pedas`, `Camilan Renyah & Teman Ngedot`, `Pereda Pedas & Minuman Segar` |
| Badge jumlah | `{n} Menu` |
| Featured badge | `Best Seller #1` |
| Featured CTA | `Pilih Topping` (normal), `Pilih` (compact) |
| Sticky bar | `{n} Item di Keranjang`, `Rp {total}`, `Lihat Pesanan` (normal), `Lihat` (compact), `Lihat Pesanan` (large text) |
| Bottom nav | `Beranda`, `Pesanan`, `Profil`; badge `3` |
| SnackBar | `Belum ada notifikasi baru.`, `Ubah alamat belum tersedia di prototype.` |

---

## 9. A11y & responsive

- `AppDishCard`/`AppDishGridCard` memakai semantics `Lihat detail {nama}` dan
  seluruh kartu menjadi tap target.
- `AppCategoryChip` memakai `button` + `selected`; bottom nav memakai `selected`.
- Icon notifikasi memakai `tooltip: Notifikasi`.
- Gambar memakai `semanticLabel` melalui `AppNetworkImage`.
- Touch target yang sudah jelas: bottom nav 72, CTA sticky bar 48, icon
  notifikasi 48, kartu menu cukup besar.
- **Perlu dicek:** tinggi visual `AppCategoryChip` sekitar 40 dp dan belum ada
  perluasan hit target 48 secara eksplisit.
- Text scale 1.0 dan 2.0 sudah dicek. Text scale 1.3 belum tercatat.
- Lebar 320 dan 390 sudah dicek. 360, 412, dan 430 belum tercatat.
- Landscape phone, TalkBack/VoiceOver, dan focus order belum diverifikasi.
- Kontras memakai token theme; tidak ada teks putih di `secondary-container`.

---

## 10. Acceptance

Status `done` mengacu pada implementasi dan verifikasi utama. Item unchecked
adalah verifikasi lanjutan yang belum tercatat.

- [x] Header, hero, filter, 3 section menu, sticky bar, dan bottom nav tampil.
- [x] 5 filter kategori berfungsi dan menyaring section.
- [x] Section Makanan, Camilan, dan Minuman memakai data mock.
- [x] Camilan memakai grid 2 kolom + item terakhir full-width pada 390.
- [x] Camilan fallback ke list pada 320 dan text scale > 1.25.
- [x] Kartu menu membuka `/menu/:id`.
- [x] CTA hero dan featured membuka menu unggulan.
- [x] Sticky bar membuka `/cart`; bottom nav berpindah tab.
- [x] SnackBar notifikasi dan ubah alamat muncul.
- [x] Tidak ada tombol `+` pada kartu menu.
- [x] Gambar remote memakai `AppNetworkImage`.
- [x] Tidak ada overflow pada 320, 390, dan text scale 2.0.
- [ ] 360, 412, dan 430 dp.
- [ ] Landscape phone.
- [ ] TalkBack/VoiceOver dan focus order.
- [ ] Hit target 48 untuk chip kategori.

---

## 11. Verifikasi

| Pemeriksaan | Hasil |
| --- | --- |
| `dart format .` | Lulus |
| `flutter analyze` | No issues found |
| `flutter test` | 8 test lulus saat verifikasi Beranda |
| `flutter run` | Berjalan di emulator 1080×2400, density 420 |
| Visual 390×844 | Grid 2×2 + wide card; tanpa tombol `+`; harga kartu di bawah deskripsi |
| Visual 320×568 | Grid fallback ke list; tidak overflow |
| Text scale 2.0 | Hero/featured compact; harga kartu full-width; sticky bar kolom |
| Gambar remote | Tampil; loading/error ditangani `AppNetworkImage` |

Catatan: verifikasi visual terakhir 2026-11-21 pada build tanpa tombol `+`.
Tidak ada artefak screenshot yang disimpan di repo.

---

## 12. Catatan & follow-up

1. **Keranjang masih mock.** State awal kosong. Detail Menu sekarang
   menambah item dan total, tetapi Beranda sendiri belum punya aksi tambah
   langsung. Perlu keputusan produk untuk alur tambah item.
2. **Notifikasi dan alamat masih SnackBar.** Belum ada layar notifikasi atau
   pemilih alamat.
3. **Sinkronisasi `DESIGN.md` §5 selesai.** Dokumen sudah memakai kartu
   tap-only, thumbnail 96×96, `Lihat Pesanan`, dan nav 72.
4. **Hit target chip kategori.** Perlu dipastikan 48 dp atau ditambah perluasan
   tap target.
5. **Test halaman penuh Beranda belum ada.** Test saat ini mencakup provider,
   mock, kartu dish/grid, dan Detail Menu; belum ada widget test yang merender
   `HomePage` dan menguji filter/navigasi.
6. **Verifikasi perangkat belum lengkap.** Landscape, TalkBack, text scale 1.3,
   serta lebar 360/412/430 belum dicatat.
7. **`AppAddButton` tidak dipakai di Beranda.** Komponen tetap ada untuk layar
   lain yang membutuhkan aksi tambah.
8. **Tinggi grid card menyisakan ruang.** `_SnackGrid` masih memakai
   `priceRowHeight = 48` untuk baris harga/tombol yang sudah dihapus. Akibatnya
   ada jarak kosong antara deskripsi dan harga. Perlu penyesuaian tinggi card.
