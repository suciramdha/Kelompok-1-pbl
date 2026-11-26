# Kustomisasi Menu

> Dokumen kerja untuk halaman Kustomisasi Seblak Prasmanan. Token ada di
> [`DESIGN.md`](../../design/DESIGN.md); registry komponen ada di
> [`components.md`](../../design/components.md).

| Field | Nilai |
| --- | --- |
| Halaman | Kustomisasi Seblak Prasmanan (`/menu/:id/customize`) |
| Route | `/menu/:id/customize` |
| File utama | `lib/features/menu/presentation/pages/menu_customize_page.dart` |
| Screen ID Stitch | `680464cfe0ee49968995424276b050be` |
| Status | `done` |
| Mock | `lib/features/menu/presentation/mock/customize_mock.dart` |
| Terakhir diperbarui | 2026-11-22 |
| Referensi | [`DESIGN.md`](../../design/DESIGN.md), [`components.md`](../../design/components.md), [`design-to-code.md`](../../rules/design-to-code.md) |

---

## 1. Tujuan

Memungkinkan pengguna meracik Seblak Prasmanan: memilih kuah, level pedas, dan
topping per porsi, menulis catatan, melihat total berjalan, lalu mengirim
racikan ke keranjang.

Arsitektur yang disepakati: **dua route, dua page, satu lapisan komponen
bersama**. Detail Menu tetap untuk item tunggal; Kustomisasi adalah layar
tersendiri dengan state dan model data sendiri.

---

## 2. Scope

- App bar fixed: back, judul `Kustomisasi Seblak`, share.
- Hero full-bleed 4:3 dengan badge `Prasmanan Spesial`.
- Info header: judul, waktu masak, deskripsi; **tanpa kolom harga**.
- Section 1 `Pilih Jenis Kuah Seblak`: 3 opsi radio, header bar + pill `Wajib`.
- Section 2 `Tingkat Kepedasan (Cabe Rawit)`: 6 kartu level dalam grid 2 kolom;
  tanpa pilihan awal; header bar + pill `Wajib`.
- Section 3 `Pilih Topping Prasmanan`: 3 kategori, 14 baris topping dengan
  stepper qty ringkas tanpa background; qty 0 hanya menampilkan tombol tambah;
  minimal 1 topping; header bar + pill `Min. 1`.
- Section 4 `Catatan untuk Penjual`: textarea maksimal 120 karakter + counter.
- Bottom bar: `Total Racikan (n Topping)` label-large + ikon 18, `Total Harga`,
  CTA `Tambah ke Keranjang`.
- Toast sukses setelah CTA.
- Validasi SnackBar jika kuah/level belum dipilih atau belum ada topping.
- Entry dari kartu Seblak Prasmanan di Beranda; guard route untuk item yang
  tidak customizable.
- State UI dengan Riverpod; total dihitung dari mock.

---

## 3. Di luar scope

- Perubahan pada `MenuDetailPage` selain wiring entry/redirect.
- Refactor `CartState` menjadi line item; sudah ditangani di task Keranjang.
- Halaman Keranjang & Checkout, Tracking, Riwayat, Profil.
- Share native dan favorite; share hanya SnackBar prototype.
- Backend, API, database, auth, repository, schema.
- Dark mode.
- Perubahan canvas Stitch selain perbaikan spec yang disepakati.

---

## 4. Inventory (Gate 3)

| Screen | Section | Komponen desain | Token | Gambar | State | Interaksi |
| --- | --- | --- | --- | --- | --- | --- |
| `/menu/:id/customize` | App bar | Back, judul, share | `surface`, `on-surface`, `on-surface-variant` | icon | default; pressed | Back, SnackBar share |
| `/menu/:id/customize` | Hero | Gambar 4:3 full-bleed; badge `Prasmanan Spesial` | `primary`, `on-primary` | remote | default; compact | None |
| `/menu/:id/customize` | Info | Judul, waktu masak, deskripsi | `headline-lg-mobile`, `body-sm`, `body-md` | none | default; large text | None |
| `/menu/:id/customize` | Kuah | 3 kartu radio; ring + dot putih; pill `Favorit`; trailing `Gratis` | `surface-container-low`, `surface-container-highest`, `primary`, `secondary-fixed` | none | unselected; selected; pressed; validation error | Pilih 1 kuah |
| `/menu/:id/customize` | Kepedasan | 6 kartu grid 2 kolom; ikon level; badge `Rekomendasi` | `primary`, `on-primary`, `secondary-fixed`, `surface-container-low` | icon | unselected; selected; pressed; validation error | Pilih 1 level |
| `/menu/:id/customize` | Topping | 14 baris + thumbnail 80×80 + harga & stepper satu parent; 3 header kategori | `surface-container-low`, `on-surface`, `primary`, `secondary` | remote + icon | qty 0 (hanya +, satu baris dengan harga); qty > 0 (stepper); disabled −; validation error (0 topping) | Tambah/kurangi qty |
| `/menu/:id/customize` | Catatan | Textarea + counter | `outline-variant`, `surface-container-lowest` | none | empty; filled; focused | Input maks. 120 |
| `/menu/:id/customize` | Bottom bar | Ringkasan total + CTA | `surface`, `primary`, `price-display`, `label-large` | icon | normal; validation; large text | Kirim racikan |
| `/menu/:id/customize` | Toast | Pill feedback | `inverse-surface`, `on-inverse-surface` | icon | visible; hidden | Muncul 2,6 detik |

Catatan Stitch: screen sudah diselaraskan dengan Detail Menu untuk hero, info,
header section, indikator radio Kuah, catatan, dan bottom bar. Stepper ringkas
dan collapse qty 0 sudah diterapkan di HTML Stitch; kuah dan level pedas tanpa
selected state. Frame validasi belum dibuat; copy validasi ada di §8. Thumbnail
canvas bisa cache lama. Bagian item lainnya sengaja mempertahankan gaya asli
(borderless beige).

---

## 5. Component map (Gate 4)

| Komponen desain | Widget existing | Aksi | Path | Alasan |
| --- | --- | --- | --- | --- |
| Hero 4:3 + badge | `MenuHero` | `reuse` | `lib/features/menu/presentation/widgets/menu_hero.dart` | Sudah mendukung `imageUrl`, `semanticLabel`, `badges` |
| Info header tanpa harga | `MenuInfoSection` | `create` | `lib/features/menu/presentation/widgets/customize_info_section.dart` | Model detail item tunggal tidak cocok; hindari refactor Detail Menu |
| Section header (bar + judul + pill + deskripsi) | private `_SectionHeader` di Detail Menu | `create` | `lib/core/ui/app_section_header.dart` | Dipakai 3×; pola sudah ada tapi private, layak dipromosikan |
| Kartu opsi radio | `AppSpiceSelector` (pola) | `create` | `lib/core/ui/app_option_card.dart` | Butuh trailing label (`Gratis`) dan ring+dot konsisten |
| Grid level pedas | `AppSpiceSelector` | `create` | `lib/features/menu/presentation/widgets/customize_spice_grid.dart` | Existing hanya 3 level vertikal; di sini 6 level grid 2 kolom |
| Baris topping + qty | `AppToppingTile` (pola) | `create` | `lib/features/menu/presentation/widgets/customize_topping_row.dart` | Existing checkbox; di sini stepper + thumbnail, harga dan counter satu parent |
| Stepper qty | `AppQuantityStepper` | `extend` | `lib/core/ui/app_quantity_stepper.dart` | Tambah `max`, `min: 0`, `collapseAtMin`, dan `emphasizeIncrease`; tombol 32 tanpa background; hit 32 Flutter; plus primary |
| Catatan 120 + counter | `AppNoteField` | `reuse` | `lib/core/ui/app_note_field.dart` | Sudah textarea + counter |
| Bottom bar ringkasan | `DetailBottomBar` (pola) | `create` | `lib/features/menu/presentation/widgets/customize_bottom_bar.dart` | Struktur berbeda: tanpa stepper porsi, kiri ringkasan racikan |
| Toast | private `_AddedToast` | `create` | `lib/features/menu/presentation/widgets/customize_toast.dart` | Detail Menu memakai widget private; jangan diubah di task ini |
| Gambar remote | `AppNetworkImage` | `reuse` | `lib/core/ui/app_network_image.dart` | Loading/error/fallback + semantics |
| Harga | `formatRupiah` | `reuse` | `lib/core/utils/rupiah.dart` | Format konsisten |
| CTA | `AppButton` | `reuse` | `lib/core/ui/app_button.dart` | Primary, full width via `expand` |

Promosi `AppSectionHeader` ke Detail Menu dicatat sebagai follow-up, bukan
bagian task ini.

---

## 6. State & interaksi

| State | Trigger | Perilaku | Widget |
| --- | --- | --- | --- |
| Default | Halaman dibuka | Kuah dan level belum dipilih, qty topping 0, catatan kosong, total 0 | Halaman + provider |
| Pilih kuah | Tap kartu | Satu kuah aktif; ring + dot putih pindah; kartu terpilih memakai `surface-container-highest` | `AppOptionCard` |
| Pilih level | Tap kartu | Satu level aktif; kartu terpilih merah; badge `Rekomendasi` tetap di Level 2 | `CustomizeSpiceGrid` |
| Ubah qty | Tap `+`/`−` | 0–20; pada 0 hanya tombol `+`; harga dan counter berada di parent yang sama; tap `+` memunculkan counter; tombol `−` disabled di 0; total dan jumlah racikan dihitung ulang | `CustomizeToppingRow` |
| Catatan | Input teks | Counter mengikuti; maksimal 120 | `AppNoteField` |
| Kirim | Tap `Tambah ke Keranjang` | Jika kuah/level belum dipilih atau 0 topping: SnackBar, cart tidak berubah. Jika lengkap: `cartProvider` bertambah; toast muncul; tetap di halaman | `CustomizeBottomBar` |
| Share | Tap ikon | SnackBar `Fitur bagikan belum tersedia di prototype.` | App bar |
| Back | Tap panah | Kembali ke Beranda jika tidak ada stack | App bar |
| Large text | Text scale > 1.5 | Baris topping menjadi kolom (teks di atas, stepper di bawah); bottom bar menumpuk | Semua |
| Guard | Buka route dengan id non-customizable | Redirect ke `/menu/:id` | Router |

Tidak ada loading/error screen-level; data mock. Error gambar ditangani
`AppNetworkImage`.

---

## 7. Data & mock

- `customize_mock.dart` (`// MOCK ONLY`):
  - `CustomizeModel { id, name, description, imageSeed, cookTime, kuah[], levels[], groups[] }`.
  - `CustomizeKuahOption { id, name, description, tag? }` — 3 item.
  - `CustomizeSpiceLevel { level, name, description, icon }` — level 0–5.
  - `CustomizeToppingGroup { icon, label, toppings[] }` — kerupuk/karbo, frozen
    food & bakso, protein & sayur.
  - `CustomizeTopping { id, name, description, price, imageSeed, maxQty, defaultQty }`
    — 14 item, maks. 20.
- UI state: `customizeProvider` (Notifier) menyimpan `kuahId`, `level`,
  `Map<String,int> qty`, `catatan`; getter `total` dan `unitCount`.
- Total: `Σ(harga × qty)` — **tanpa harga dasar** (lihat §12).
- Gambar: 15 URL Stitch diganti `RemoteImages` deterministik per `imageSeed`;
  tidak ada asset lokal.
- Batas backend: tidak ada database/API/repository.

---

## 8. Copy

| Lokasi | Copy |
| --- | --- |
| App bar | `Kustomisasi Seblak` |
| Badge hero | `Prasmanan Spesial` |
| Judul info | `Seblak Prasmanan` |
| Waktu | `10-15 Menit Masak` |
| Deskripsi | `Bebas pilih kuah rempah kencur, atur level pedas narako, dan ambil topping favorit sepuasmu!` |
| Section kuah | `Pilih Jenis Kuah Seblak` / `Wajib pilih 1 jenis racikan kuah` / pill `Wajib` |
| Section pedas | `Tingkat Kepedasan (Cabe Rawit)` / `Gilingan cabe rawit domba asli tanpa saus tiruan` / pill `Wajib` |
| Section topping | `Pilih Topping Prasmanan` / `Pilih minimal 1 topping, lalu atur porsi sesukamu` / pill `Min. 1` |
| Catatan | `Catatan untuk Penjual` / placeholder `Tulis instruksi khusus buat juru masak warung di sini...` |
| Bottom bar | `Total Racikan (n Topping)`, `Total Harga`, `Tambah ke Keranjang` |
| Toast | `Racikan seblak ditambahkan ke keranjang!` |
| Validasi kuah | `Pilih jenis kuah seblak dulu ya.` |
| Validasi pedas | `Pilih tingkat kepedasan dulu ya.` |
| Validasi topping | `Pilih minimal 1 topping prasmanan dulu ya.` |
| Share | `Fitur bagikan belum tersedia di prototype.` |

---

## 9. A11y & responsive

- [ ] Semantics: radio `selected`, tombol qty berlabel (`Kurangi porsi <nama>`,
      `Tambah porsi <nama>`), gambar punya label.
- [ ] Hit target stepper Flutter 32 (pengecualian disetujui); komponen lain
      tetap 48. Tombol 32/ikon 16, tanpa background; harga dan counter satu baris
      pada layout horizontal, menumpuk dalam parent yang sama pada layout stacked.
- [ ] Text scale 1.0–2.0 tanpa clipping.
- [ ] Lebar 320–430 dp aman; grid pedas tetap 2 kolom di 320.
- [ ] Landscape phone tidak overflow.
- [ ] Kontras aman; tidak ada putih di `secondary-container`.
- [ ] `SafeArea`, keyboard, dan sticky bar tidak menutupi konten.
- [ ] Gambar remote punya loading/error/fallback.

---

## 10. Acceptance

- [x] Hero, info, 4 section, dan bottom bar tampil sesuai spec.
- [x] Kuah dan level pedas bersifat single-select; tanpa pilihan awal; indikator
  ring + dot putih.
- [x] Qty topping 0–20; qty 0 hanya menampilkan tombol `+`; total dan
  `Total Racikan` ikut berubah.
- [x] CTA memvalidasi kuah, level, dan minimal 1 topping; SnackBar muncul dan cart
  tidak berubah jika belum lengkap.
- [x] Harga dan counter berada dalam satu parent; layout horizontal satu baris,
  layout stacked menumpuk dalam parent yang sama.
- [x] Counter tanpa background pill; warna tombol minus/plus tetap.
- [x] Hit target stepper Flutter 32 (pengecualian disetujui).
- [x] `Total Racikan` memakai `label-large` dan ikon 18 di bottom bar.
- [x] Catatan maksimal 120 dengan counter.
- [x] CTA menambah ke keranjang dan menampilkan toast.
- [x] Kartu Seblak di Beranda membuka Kustomisasi, bukan placeholder.
- [x] Route guard mengalihkan id non-customizable ke Detail Menu.
- [x] Tidak ada overflow di 320 dp dan text scale 2.0.
- [x] Tidak ada database/backend/API/auth; mock ditandai `// MOCK ONLY`.

---

## 11. Verifikasi

- [x] `dart format` pada file yang berubah
- [x] `flutter analyze`
- [x] `flutter test` (termasuk validasi CTA)
- [ ] `flutter run`/e2e di HP fisik — diserahkan ke pengguna
- [x] Layout 320×568 via widget test
- [x] Layout 390×844 via widget test
- [x] Text scale 2.0 via widget test dan HP fisik (font_scale 2.0)
- [x] Landscape phone via widget test
- [ ] Visual akhir di HP fisik — diserahkan ke pengguna
- [x] Gambar remote dan fallback

Matriks lengkap: [`docs/rules/design-to-code.md`](../../rules/design-to-code.md) Gate 6.

---

## 12. Catatan & keputusan

Keputusan yang dipakai:

1. **Harga**: total = Σ(harga topping × qty); tanpa harga dasar.
2. **State awal**: semua qty 0; kuah dan level belum dipilih; state canvas yang
   terisi hanya acuan visual.
3. **Label ringkasan**: `n Topping` menghitung unit, bukan jenis.
4. **Validasi**: qty 0–20; kuah dan pedas tanpa pilihan awal; CTA selalu aktif
   tetapi memvalidasi kuah, pedas, dan minimal 1 topping saat submit.
5. **CTA**: `cartProvider.addItem(CartLineItem)` + toast; line item membawa
   racikan kuah/level/topping dan catatan.
6. **Shell item**: Kuah/Topping tetap beige borderless; hanya indikator dan header
   yang mengikuti Detail Menu.
7. **Harga + counter**: keduanya berada dalam satu parent. Layout horizontal
   menempatkannya satu baris (harga kiri, counter kanan); layout stacked
   menumpuk dalam parent yang sama. Qty 0 hanya menampilkan tombol tambah;
   counter muncul setelah qty > 0. Counter tanpa background pill, tetapi warna
   tombol minus/plus tetap. Hit target stepper Flutter 32 (pengecualian
   disetujui); Stitch memakai visual 32. Berlaku di Flutter dan Stitch.
8. **Validasi CTA**: kuah, level pedas, dan minimal 1 topping wajib; belum
   lengkap → SnackBar, cart tidak berubah. Topping tidak divalidasi per jenis,
   hanya total unit > 0.

Implementasi:

- Halaman: `menu_customize_page.dart`; mock `customize_mock.dart`; state
  `customize_provider.dart`. Validasi CTA memakai `ScaffoldMessenger` dan
  menampilkan pesan sesuai bagian yang belum lengkap.
- Widget: `CustomizeInfoSection`, `CustomizeSpiceGrid`, `CustomizeToppingRow`,
  `CustomizeBottomBar`, `CustomizeToast`; primitives `AppSectionHeader`,
  `AppOptionCard`.
- Router: `/menu/:id` dialihkan ke `/menu/:id/customize` untuk item customizable;
  route customize memantul ke detail untuk id lain.
- `AppQuantityStepper` ditambah `max`, `min: 0`, `collapseAtMin`, dan
  `emphasizeIncrease`; tombol 32 tanpa background, hit 32 Flutter, plus primary.
- `MenuHero` diperbaiki agar pill badge membungkus teks (tidak overflow di
  320 dp / text scale 2.0).

Follow-up:

- `CartState` sudah memakai line item sejak halaman Keranjang diimplementasikan.
- `MenuDetailPage` masih memakai aksen header 2 px; `AppSectionHeader` 8 px.
  Promosi ke Detail Menu dicatat sebagai follow-up, bukan bagian task ini.
- Thumbnail canvas Stitch masih cache lama; sumber kebenaran adalah HTML/code.
- Gambar memakai `RemoteImages.topping` (rotasi aset kurasi), bukan URL
  `aida-public`.
- Frame canvas 390×3123 lebih pendek dari konten (±3372 CSS); tidak memengaruhi
  implementasi Flutter.
