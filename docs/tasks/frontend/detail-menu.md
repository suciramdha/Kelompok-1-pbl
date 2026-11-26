# Detail Menu

> Dokumen kerja untuk halaman Detail Menu. Token ada di
> [`DESIGN.md`](../../design/DESIGN.md); registry komponen ada di
> [`components.md`](../../design/components.md).

| Field | Nilai |
| --- | --- |
| Halaman | Detail Menu (`/menu/:id`) |
| Route | `/menu/:id` |
| File utama | `lib/features/menu/presentation/pages/menu_detail_page.dart` |
| Screen ID Stitch | `4d0cd885dbc347b5ad311319c5315786` |
| Status | `done` |
| Mock | `lib/features/menu/presentation/mock/menu_detail_mock.dart` |
| Terakhir diperbarui | 2026-11-22 |
| Referensi | [`DESIGN.md`](../../design/DESIGN.md), [`components.md`](../../design/components.md), [`design-to-code.md`](../../rules/design-to-code.md) |

---

## 1. Tujuan

Menampilkan detail menu untuk semua item Beranda sekaligus memungkinkan pengguna
memilih level pedas, topping, suhu penyajian, catatan, dan quantity sebelum
menambahkannya ke keranjang.

---

## 2. Scope

- App bar fixed: back, judul `Detail Menu`, share, favorite.
- Hero gambar 4:3; badge `Terlaris #2` pada Mie Rawit.
- Info menu: judul, waktu masak, harga coret, harga aktif, deskripsi.
- Level pedas 1–3 untuk Mie Rawit, Mie Jontor, dan Mie Narako; tanpa pilihan
  awal, divalidasi saat CTA.
- Topping 5 pilihan untuk semua Makanan.
- Suhu Penyajian `Dingin`/`Panas` untuk Jus Jeruk; tanpa pilihan awal,
  divalidasi saat CTA.
- Catatan untuk penjual maksimal 120 karakter untuk semua menu.
- Bottom bar: quantity stepper, total harga, CTA tambah ke keranjang.
- Toast sukses setelah menambah ke keranjang.
- State lokal untuk pilihan; cart memakai `cartProvider`.

---

## 3. Di luar scope

- Seblak Prasmanan (`seblak-prasmanan-komplit`): memakai placeholder existing.
- Share native dan favorite persistence; share hanya SnackBar prototype,
  favorite hanya state lokal.
- Backend, API, database, auth, dan repository.
- Halaman Kustomisasi, Keranjang, Pesanan, Tracking, dan Profil.
- Dark mode.

---

## 4. Inventory (Gate 3)

| Screen | Section | Komponen desain | Token | Gambar | State | Interaksi |
| --- | --- | --- | --- | --- | --- | --- |
| `/menu/:id` | App bar | Back, share, favorite | `surface`, `on-surface`, `primary` | icon | default; pressed | Back, SnackBar share, toggle favorite |
| `/menu/:id` | Hero | Gambar 4:3; badge Terlaris pada Mie Rawit | `primary`, `on-primary` | remote | default; compact | None |
| `/menu/:id` | Info | Judul, waktu masak, harga, deskripsi | `headline-lg-mobile`, `body-sm`, `body-md`, `price-display`, `primary`, `secondary` | none | default; large text | None |
| `/menu/:id` | Tingkat kepedasan | Radio card; Mie Rawit, Mie Jontor, Mie Narako | `primary-fixed`, `secondary-fixed`, `outline-variant` | icon | unselected; selected; validation error | Pilih 1 level |
| `/menu/:id` | Topping | Checkbox tile; semua Makanan | `secondary-container`, `on-secondary-container`, `surface-container` | icon | checked; unchecked | Pilih beberapa |
| `/menu/:id` | Suhu penyajian | Radio card; Jus Jeruk | `tertiary`, `primary-fixed`, `secondary-fixed`, `outline-variant` | icon | unselected; selected; validation error | Pilih Dingin/Panas |
| `/menu/:id` | Catatan | Textarea + counter | `outline-variant`, `secondary-container` | none | empty; filled; focused | Input maks. 120 |
| `/menu/:id` | Bottom bar | Quantity stepper, total, CTA | `surface`, `primary`, `price-display` | icon | normal; validation; large text | Ubah quantity, tambah |
| `/menu/:id` | Toast | Pill feedback | `inverse-surface`, `on-inverse-surface` | icon | visible; hidden | Muncul 2,4 detik |

---

## 5. Component map (Gate 4)

| Komponen desain | Widget existing | Aksi | Path | Alasan |
| --- | --- | --- | --- | --- |
| Quantity stepper | `AppQuantityStepper` | `create` | `lib/core/ui/app_quantity_stepper.dart` | Belum ada; akan dipakai ulang di Keranjang |
| Spice selector | `AppSpiceSelector` | `create` | `lib/core/ui/app_spice_selector.dart` | Radio card khusus level pedas |
| Topping tile | `AppToppingTile` | `create` | `lib/core/ui/app_topping_tile.dart` | Checkbox row + harga |
| Temperature selector | `AppTemperatureSelector` | `create` | `lib/core/ui/app_temperature_selector.dart` | Radio card Dingin/Panas untuk Jus Jeruk |
| Note field | `AppNoteField` | `create` | `lib/core/ui/app_note_field.dart` | Textarea + counter 120 |
| Hero | `MenuHero` | `create` | `lib/features/menu/presentation/widgets/menu_hero.dart` | Badge Terlaris di kanan atas gambar |
| Info | `MenuInfoSection` | `create` | `lib/features/menu/presentation/widgets/menu_info_section.dart` | Judul, waktu masak, harga, deskripsi |
| Bottom bar | `DetailBottomBar` | `create` | `lib/features/menu/presentation/widgets/detail_bottom_bar.dart` | Quantity + total + CTA |
| Toast | private `_AddedToast` | `create` | `menu_detail_page.dart` | Feedback lokal, belum perlu shared |
| Gambar remote | `AppNetworkImage` | `reuse` | `lib/core/ui/app_network_image.dart` | Loading/error/fallback + semantics |
| Harga | `formatRupiah` | `reuse` | `lib/core/utils/rupiah.dart` | Format konsisten |
| Placeholder | `PlaceholderPage` | `reuse` | `lib/features/placeholder/presentation/placeholder_page.dart` | Seblak Prasmanan / ID di luar scope |

---

## 6. State & interaksi

| State | Trigger | Perilaku |
| --- | --- | --- |
| Default | Buka detail menu | Section mengikuti data; level pedas dan suhu belum dipilih; quantity 1; tanpa topping; catatan kosong |
| Pilih level | Tap kartu level | Level berubah; harga tetap (semua termasuk) |
| Pilih topping | Tap tile | Total bertambah/berkurang sesuai harga topping |
| Pilih suhu | Tap Dingin/Panas | Suhu berubah; harga tetap |
| Ubah quantity | Tap `+`/`−` | Total = `(harga + topping) × quantity`; minimum 1 |
| Catatan | Input teks | Counter mengikuti; maksimal 120 |
| Tambah | Tap CTA bawah | Jika level/suhu wajib belum dipilih: SnackBar, cart tidak berubah. Jika lengkap: `cartProvider` bertambah; toast muncul 2,4 detik |
| Favorite | Tap ikon hati | State lokal filled/outline |
| Share | Tap ikon share | SnackBar `Fitur bagikan belum tersedia di prototype.` |
| Back | Tap panah | Kembali ke halaman sebelumnya |
| Keyboard | Fokus catatan | Konten dapat di-scroll; bottom bar tidak menutupi field |
| Large text | Text scale > 1.5 | Info harga dan bottom bar menjadi kolom |
| ID di luar scope | Buka Seblak Prasmanan | `PlaceholderPage` |

Tidak ada loading/error screen-level; semua data mock. Error gambar ditangani
`AppNetworkImage`.

---

## 7. Data & mock

- `menu_detail_mock.dart` (`// MOCK ONLY`):
  - `MenuDetailModel`, `AppSpiceOption`, `ToppingOption`.
  - Data detail tersedia untuk 18 menu Makanan, Camilan, dan Minuman.
  - Mie Rawit: harga dasar Rp 12.000; harga coret Rp 15.000; waktu masak
    `15-20 Menit Masak`; badge hero `Terlaris #2`.
  - Mie Jontor dan Mie Narako: level 1–3, topping, catatan, bottom bar.
  - Makanan lain: topping, catatan, bottom bar.
  - Jus Jeruk: suhu `Dingin`/`Panas`, catatan, bottom bar.
  - Camilan dan minuman lain: info, catatan, bottom bar.
  - Catatan maks. 120 untuk semua menu.
- `cart_provider.dart`: `addItem(CartLineItem)` menambah line item lengkap
  (nama, detail pilihan, gambar, harga, quantity, catatan, level pedas).
- Gambar: `RemoteImages.dish(detail.imageSeed, width: 900, height: 675)`.

---

## 8. Copy

| Lokasi | Copy |
| --- | --- |
| App bar | `Detail Menu` |
| Badge hero | `Terlaris #2` (Mie Rawit, kanan atas) |
| Waktu masak | `15-20 Menit Masak` (Mie Rawit, di bawah judul) |
| Harga | `Rp 15.000` (coret), `Rp 12.000` |
| Section pedas | `Tingkat Kepedasan`, `Wajib Pilih 1` |
| Level | `Level 1 - Pedas Santai`, `Level 2 - Pedas Nampol`, `Level 3 - Pedas Narako` |
| Tag level | `Gurih`, `Favorit`, `Ekstrem` |
| Section topping | `Topping Tambahan`, `Opsional` |
| Section suhu | `Suhu Penyajian`, `Wajib Pilih 1` |
| Opsi suhu | `Dingin`, `Panas` |
| Catatan | `Catatan untuk Penjual`, helper contoh, hint textarea |
| Bottom bar | `Total Harga`, `Tambah ke Keranjang` |
| Validasi pedas | `Pilih tingkat kepedasan dulu ya.` |
| Validasi suhu | `Pilih suhu penyajian dulu ya.` |
| Toast | `{nama menu} masuk ke keranjang!` |
| Share | `Fitur bagikan belum tersedia di prototype.` |

---

## 9. A11y & responsive

- Quantity stepper: tombol 32/ikon 16 tanpa background; hit 32 Flutter
  (pengecualian disetujui); minus disabled pada 1; semantics label.
- Spice card: `radio` semantics, selected state.
- Temperature card: `radio` semantics, selected state, hit target 48.
- Topping tile: `checkbox` semantics; seluruh row dapat ditekan.
- Checkbox terpilih memakai `on-secondary-container`, bukan putih di
  `secondary-container` (kontras).
- Hero image punya `semanticLabel`.
- Text scale 1.0–2.0; harga info dan bottom bar turun menjadi kolom saat perlu.
- Keyboard tidak menutupi catatan.
- Touch target minimal 48.
- Tidak ada hover/desktop state.

---

## 10. Acceptance

- [x] Semua menu Makanan, Camilan, dan Minuman membuka Detail Menu.
- [x] Mie Jontor dan Mie Narako menampilkan level 1–3 dan topping.
- [x] Makanan lain menampilkan info, topping, catatan, dan bottom bar.
- [x] Jus Jeruk menampilkan suhu Dingin/Panas; tanpa pilihan awal.
- [x] Camilan dan minuman lain menampilkan info, catatan, dan bottom bar.
- [x] Detail Mie Rawit menampilkan badge, waktu masak, dan harga coret.
- [x] Tidak ada level pedas yang terpilih saat halaman dibuka.
- [x] CTA memvalidasi level pedas/suhu; SnackBar muncul dan cart tidak berubah jika belum dipilih.
- [x] Topping mengubah total.
- [x] Quantity mengubah total dan minimum 1.
- [x] Catatan dibatasi 120 karakter.
- [x] Tambah ke keranjang memperbarui cart dan menampilkan toast.
- [x] Favorite toggle lokal; share SnackBar.
- [x] Seblak Prasmanan memakai placeholder.
- [x] 320 dan 390 tanpa overflow.
- [x] Text scale 2.0 tanpa clipping.
- [x] Tidak ada backend/API/auth.

---

## 11. Verifikasi

| Pemeriksaan | Hasil |
| --- | --- |
| `dart format .` | Lulus |
| `flutter analyze` | No issues found |
| `flutter test` | 33 test lulus |
| Validasi CTA | SnackBar pedas/suhu muncul; cart tidak berubah (widget test) |
| `flutter run` | Berjalan di emulator 1080×2400 |
| Visual 390×844 | Mie Rawit, Mie Jontor, Nasi Goreng, Jus Jeruk, dan camilan tampil sesuai section |
| Visual 320×568 | Quantity/total/CTA aman; konten scroll |
| Text scale 2.0 | Info turun, bottom bar kolom; tanpa overflow |
| Keyboard/fokus catatan | Field fokus, border aktif, counter terlihat |
| Tambah ke keranjang | Sticky bar Beranda berubah 5 item / Rp 86.000 |
| Toast | Muncul di atas, hilang 2,4 detik |

---

## 12. Catatan & follow-up

- Seblak Prasmanan sengaja memakai placeholder sampai layar Kustomisasi
  tersedia.
- Copy deskripsi level Mie Jontor dan Mie Narako masih memakai teks level
  Mie Rawit; perlu copy final.
- Share native dan favorite persistence belum ada.
- `AppQuantityStepper`, `AppSpiceSelector`, `AppToppingTile`,
  `AppTemperatureSelector`, dan `AppNoteField` dipakai ulang di layar lain nanti.
- Toast mengikuti Stitch (atas), berbeda dari SnackBar Beranda; durasinya memakai
  token `AppMotion.toast` (2,4 detik).
- CTA memvalidasi pilihan wajib; tidak ada level/suhu yang dipilih saat halaman
  dibuka. SnackBar validasi memakai `ScaffoldMessenger`.
- Stitch Detail Menu memakai level pedas tanpa selected state; frame validasi
  belum dibuat, copy validasi ada di §8.
- Bottom bar memakai `Scaffold.bottomNavigationBar`, bukan overlay manual, agar
  konten tidak tertutup dan keyboard tidak menabrak field.
