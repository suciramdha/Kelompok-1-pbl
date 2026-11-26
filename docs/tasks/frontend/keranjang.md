# Keranjang & Checkout

> Dokumen kerja untuk halaman Keranjang & Checkout. Token ada di
> [`DESIGN.md`](../../design/DESIGN.md); registry komponen ada di
> [`components.md`](../../design/components.md).

| Field | Nilai |
| --- | --- |
| Halaman | Keranjang & Checkout (`/cart`) |
| Route | `/cart` |
| File utama | `lib/features/cart/presentation/pages/cart_page.dart` |
| Screen ID Stitch | `bf1c60ee794b45788adcd987f8f81168` |
| Status | `done` |
| Mock | `lib/features/cart/presentation/mock/cart_mock.dart` |
| Terakhir diperbarui | 2026-11-24 |
| Referensi | [`DESIGN.md`](../../design/DESIGN.md), [`components.md`](../../design/components.md), [`design-to-code.md`](../../rules/design-to-code.md) |

Status `done`: implementasi selesai dan `flutter analyze` bersih; e2e, widget
test baru, dan visual di HP fisik diserahkan ke pengguna.

---

## 1. Tujuan

Menjadi layar review pesanan sebelum checkout: pengguna melihat alamat, item
keranjang, catatan driver, metode pembayaran, dan rincian biaya, lalu menekan
`Pesan Sekarang`. Semua data masih mock; tidak ada pembuatan pesanan final.

---

## 2. Scope

- App bar: back, judul `Keranjang & Checkout`, bantuan prototype.
- Kartu alamat: nama alamat, badge `Alamat Utama`, alamat, catatan alamat,
  dan aksi `Ubah`.
- Kartu `Pesanan Kamu (n Menu)`: daftar line item, thumbnail, badge level pedas,
  ringkasan racikan, catatan item, harga, quantity stepper, dan
  `Tambah Menu Lainnya`.
- Konfirmasi hapus: tombol `−` saat qty 1 membuka dialog; `Hapus` menghapus item,
  `Batal` tidak mengubah apa pun.
- Catatan item: baris catatan di kartu item dapat ditekan dan membuka drawer;
  drawer berisi judul, textarea borderless, dan placeholder
  `tulis permintaan khusus di sini ya`; `Simpan` memperbarui catatan item.
- `Catatan untuk Driver`: quick tag multi-select dan input teks maksimal 120.
- `Metode Pembayaran`: QRIS / E-Wallet (default) dan Tunai / COD.
- `Rincian Pembayaran`: subtotal, ongkos kirim + jarak, biaya layanan &
  kemasan, dan total akhir.
- Sticky checkout bar: label `Total Pembayaran` lebih besar, nominal, dan CTA
  `Pesan Sekarang`.
- Empty state defensif saat cart kosong.
- Riverpod untuk line item, quantity, pembayaran, dan total; state catatan
  driver bersifat lokal halaman.
- Feedback prototype lewat SnackBar untuk bantuan, ubah alamat, dan checkout.

---

## 3. Di luar scope

- Pembuatan pesanan, checkout final, pembayaran nyata, dan halaman tracking.
- Pemilih alamat, pusat bantuan, dan integrasi payment gateway.
- Kupon, voucher, potongan ongkir, dan diskon.
- Transfer bank / virtual account.
- Hapus item tanpa konfirmasi; penghapusan hanya lewat dialog qty 1.
- Frame drawer catatan item di Stitch; untuk saat ini hanya Flutter.
- Estimasi pengantaran dan badge brand `Seblak Lokuak` di header pesanan.
- Jaminan makanan hangat/higienis dan chevron pada sticky bar.
- Autentikasi, database, backend, API, repository, dan schema.
- Dark mode.
- E2E, widget test baru, dan verifikasi visual perangkat; dikerjakan pengguna.

---

## 4. Inventory (Gate 3)

| Screen | Section | Komponen desain | Token | Gambar | State | Interaksi |
| --- | --- | --- | --- | --- | --- | --- |
| `/cart` | App bar | Back, judul, bantuan | `surface`, `on-surface`, `on-surface-variant`, `outline-variant` | icon | default; pressed; large text | Back; SnackBar bantuan |
| `/cart` | Alamat | `CartAddressCard`, badge alamat | `surface-container-lowest`, `surface-container-low`, `secondary-fixed`, `on-secondary-fixed`, `outline-variant` | icon | default; pressed; large text | `Ubah` memunculkan SnackBar |
| `/cart` | Pesanan | `CartItemTile`, `AppQuantityStepper`, `AppNetworkImage` | `surface-container-low`, `primary`, `on-primary`, `price`, `outline-variant` | remote 80×80 | default; qty 1–20; pressed; image loading/error; large text; stacked; dialog konfirmasi | Ubah qty; `−` pada qty 1 membuka dialog hapus |
| `/cart` | Tambah menu | Tombol beige full-width | `surface-container-low`, `secondary` | icon | default; pressed | Kembali ke Beranda |
| `/cart` | Catatan item | `CartItemNoteSheet` | `surface-container-lowest`, `primary`, `outline-variant`, `surface` | none | default; filled; empty; focused; keyboard; large text | Tap baris catatan item membuka drawer; `Simpan` memperbarui item; `Tutup`/back membatalkan |
| `/cart` | Catatan driver | Quick tags + input | `primary`, `on-primary`, `surface-container-low`, `outline-variant` | icon | selected; unselected; focused; filled; large text | Pilih tag; input maks. 120 |
| `/cart` | Pembayaran | Dua kartu radio | `surface-container-low`, `primary`, `on-primary`, `secondary-fixed`, `on-secondary-fixed` | icon | QRIS selected; COD selected; pressed; large text | Pilih satu metode |
| `/cart` | Rincian | Baris biaya + divider | `surface-container-lowest`, `on-surface-variant`, `primary`, `outline-variant` | icon | default; large text | None |
| `/cart` | Sticky bar | Total + CTA | `surface`, `primary`, `on-primary`, `outline-variant` | icon | normal; large text column | `Pesan Sekarang` SnackBar |
| `/cart` | Empty | `AppEmptyState` | `surface-container`, `primary`, `on-surface-variant` | icon | empty | CTA ke Beranda |

Revisi Stitch 2026-11-22 menghapus ETA, badge `Seblak Lokuak`, badge
`Mitra Juara UMKM`, icon hapus item, section kupon, opsi transfer bank/VA,
baris diskon, jaminan makanan, dan chevron. Total akhir mengikuti line item;
label `Total Pembayaran` diperbesar.

---

## 5. Component map (Gate 4)

| Komponen desain | Widget existing | Aksi | Path | Alasan |
| --- | --- | --- | --- | --- |
| Halaman keranjang | — | `create` | `lib/features/cart/presentation/pages/cart_page.dart` | Layar baru; `/cart` masih placeholder |
| Kartu section | — | `create` | `lib/features/cart/presentation/widgets/cart_section_card.dart` | Container putih + border + radius konsisten untuk section berjudul |
| Kartu alamat | — | `create` | `lib/features/cart/presentation/widgets/cart_address_card.dart` | Struktur alamat, badge alamat, catatan, dan aksi `Ubah` |
| Item keranjang | `CartItemTile` (rencana) | `create` | `lib/features/cart/presentation/widgets/cart_item_tile.dart` | Thumbnail, racikan, harga, qty, catatan; baris catatan membuka drawer |
| Dialog konfirmasi hapus | — | `create` | `lib/features/cart/presentation/pages/cart_page.dart` | `AlertDialog` qty 1: Batal/Hapus; private di halaman |
| Drawer catatan item | — | `create` | `lib/features/cart/presentation/widgets/cart_item_note_sheet.dart` | `showModalBottomSheet` tinggi, judul, textarea borderless, Simpan; dipicu baris catatan item |
| Catatan driver | — | `create` | `lib/features/cart/presentation/widgets/driver_note_card.dart` | Quick tag + input khusus driver |
| Metode pembayaran | `AppOptionCard` (pola) | `create` | `lib/features/cart/presentation/widgets/payment_method_card.dart` | Butuh ikon leading dan radio trailing, bukan layout opsi kuah |
| Rincian pembayaran | `OrderSummary` (rencana) | `create` | `lib/features/cart/presentation/widgets/order_summary.dart` | Baris biaya + divider + total |
| Sticky checkout | `AppStickyOrderBar` (pola) | `create` | `lib/features/cart/presentation/widgets/cart_checkout_bar.dart` | Label total besar + CTA checkout; bukan ringkasan Beranda |
| Empty state | `AppEmptyState` (rencana) | `create` | `lib/shared/widgets/app_empty_state.dart` | State kosong yang dapat dipakai ulang |
| Input catatan driver | `AppNoteField` | `extend` | `lib/core/ui/app_note_field.dart` | Tambah `minLines`, `maxLines`, `showCounter`, keyboard/action |
| CTA | `AppButton` | `reuse` | `lib/core/ui/app_button.dart` | Primary, full width via `expand` |
| Quantity stepper | `AppQuantityStepper` | `extend` | `lib/core/ui/app_quantity_stepper.dart` | Tambah `onDecrementAtMin` + label a11y untuk konfirmasi hapus qty 1 |
| Gambar item | `AppNetworkImage` | `reuse` | `lib/core/ui/app_network_image.dart` | Loading/error/fallback + semantics |
| Harga | `formatRupiah` | `reuse` | `lib/core/utils/rupiah.dart` | Format konsisten |
| Gaya harga | `AppTypography.price` | `reuse` | `lib/app/theme/app_typography.dart` | Harga item dan total |
| Route | — | `edit` | `lib/app/router/app_router.dart` | `/cart` memakai `CartPage`, bukan placeholder |

Tidak ada dependency baru. `Tambah Menu Lainnya` memakai `AppButton` secondary.

---

## 6. State & interaksi

| State | Trigger | Perilaku | Widget |
| --- | --- | --- | --- |
| Default | Buka `/cart` tanpa item | Empty state `Keranjang masih kosong`; tanpa sticky bar | `CartPage` + `AppEmptyState` |
| Isi keranjang | Item ditambahkan dari Detail Menu/Kustomisasi | Section pesanan, catatan driver, pembayaran, dan rincian tampil; QRIS aktif; tag `Jangan klakson (malam)` aktif; input driver kosong; total dihitung dari line item + ongkir + layanan | `CartPage` + `cartProvider` |
| Ubah qty | Tap `+`/`−` saat qty > 1 | 1–20; subtotal, item count, dan total dihitung ulang; item count di ringkasan memakai total porsi | `AppQuantityStepper` |
| Konfirmasi hapus | Tap `−` saat qty 1 | Dialog `Hapus item?` tampil; `Batal` menutup tanpa perubahan; `Hapus` menghapus item | `AlertDialog` |
| Setelah hapus | Tap `Hapus` di dialog | Item hilang, SnackBar `Item dihapus dari keranjang.`; jika item terakhir, empty state dan sticky bar hilang | `CartPage` + `cartProvider` |
| Buka catatan item | Tap baris catatan pada kartu item | Bottom sheet muncul setinggi ±90% layar; textarea borderless terisi catatan item saat ini; keyboard menyesuaikan | `CartItemTile`, `CartItemNoteSheet` |
| Simpan catatan item | Tap `Simpan` | Catatan item diperbarui; sheet menutup; baris catatan di item langsung berubah | `CartNotifier.setItemNote` |
| Tutup catatan item | Tap `Tutup`, back, atau tap di luar sheet | Sheet menutup tanpa mengubah catatan item | `CartItemNoteSheet` |
| Tambah menu | Tap `Tambah Menu Lainnya` | Kembali ke Beranda (pop bila memungkinkan) | Tombol section |
| Pilih pembayaran | Tap kartu QRIS/COD | Single-select; status radio + semantics berubah | `PaymentMethodCard` |
| Pilih tag driver | Tap quick tag | Multi-select; tag aktif memakai primary; dapat dilepas | `DriverNoteCard` |
| Input driver | Fokus + ketik | Maksimal 120 karakter; tanpa counter; keyboard tidak menutup field | `AppNoteField` |
| Bantuan | Tap ikon `?` | SnackBar `Pusat bantuan belum tersedia di prototype.` | App bar |
| Ubah alamat | Tap `Ubah` | SnackBar `Ubah alamat belum tersedia di prototype.` | `CartAddressCard` |
| Checkout | Tap `Pesan Sekarang` | SnackBar `Checkout belum tersedia di prototype.` | `CartCheckoutBar` |
| Image loading | Thumbnail dimuat | Placeholder progres `AppNetworkImage` | `AppNetworkImage` |
| Image error | Thumbnail gagal | Fallback ikon restoran | `AppNetworkImage` |
| Empty | Item terakhir dihapus | Empty state + CTA Beranda; tanpa sticky bar | `AppEmptyState` |
| Large text | Text scale > 1.5 | Harga dan stepper item menumpuk; total sticky bar tetap terbaca | Semua |
| Lebar < 360 | Layout sempit | Harga dan stepper item menumpuk; tag driver tetap horizontal scroll | `CartItemTile` |

Tidak ada loading/error screen-level; data mock statis. Error hanya pada gambar
remote.

---

## 7. Data & mock

- `cart_mock.dart` (`// MOCK ONLY — hapus saat backend tersedia.`):
  - `CartAddress`: `Kost Mahasiswa UI Depok`, `Alamat Utama`,
    `Jl. Melati No. 14, Beji, Depok`, catatan kamar.
  - `cartDeliveryFee = 8000`, `cartServiceFee = 2000`,
    `cartDistanceLabel = '1.8 km'`.
  - `cartPaymentOptions`: QRIS (tag `Bebas Biaya`) dan Tunai / COD.
  - `cartDriverNoteTags`: 3 tag; default `Jangan klakson (malam)`.
- `cart_provider.dart`:
  - `CartState` menyimpan `items`, `deliveryFee`, `serviceFee`,
    `distanceLabel`, dan `paymentMethodId`.
  - Getter: `itemCount` (total porsi), `lineCount` (jumlah baris),
    `subtotal`, `total` (subtotal + ongkir + layanan; 0 saat kosong), `isEmpty`.
  - `CartNotifier`: `addItem`, `setQuantity`, `incrementItem`,
    `decrementItem`, `removeItem`, `selectPaymentMethod`, `setItemNote`.
  - `addItem` menggabungkan line dengan nama, detail, catatan, dan harga sama;
    quantity selalu dijaga 1–20.
  - `setItemNote` mengubah catatan line item; kosong menghapus catatan.
- Entry dari Detail Menu: line item membawa nama, gambar, harga (termasuk
  topping), quantity, level pedas, ringkasan pedas/suhu/topping, dan catatan.
- Catatan item dari Detail Menu tampil di masing-masing item. Baris catatan
  tersebut dapat ditekan untuk membuka drawer dan mengedit catatan item yang
  sama; `Simpan` langsung memperbarui catatan pada item.
- Entry dari Kustomisasi: line item membawa racikan kuah/level/topping, catatan,
  dan `state.total` (total topping; tanpa harga dasar, sesuai keputusan
  Kustomisasi).
- Home sticky bar membaca `itemCount` dan `total` yang sama dan
  disembunyikan saat keranjang kosong.
- Gambar: `RemoteImages.dish(imageSeed, width: 200, height: 200)`;
  `seblak-prasmanan` dipetakan ke foto makanan.
- Batas backend: tidak ada database/API/repository/auth/persistence.

---

## 8. Copy

| Lokasi | Copy |
| --- | --- |
| App bar | `Keranjang & Checkout`, tooltip `Kembali`, `Bantuan` |
| Alamat | `Kost Mahasiswa UI Depok`, `Alamat Utama`, `Jl. Melati No. 14, Beji, Depok`, `Catatan:`, `Ubah` |
| Pesanan | `Pesanan Kamu ({n} Menu)`, `Tambah Menu Lainnya` |
| Item | `{nama}`, `{ringkasan racikan}`, `{harga}`, `{catatan}` |
| Drawer catatan item | `Tambah Catatan untuk Pembelian`, placeholder `tulis permintaan khusus di sini ya`, `Tutup`, `Simpan` |
| Catatan driver | `Catatan untuk Driver`, `Titip di pagar kost`, `Jangan klakson (malam)`, `Chat WA saat sampai`, placeholder `Tulis instruksi tambahan bagi driver...` |
| Pembayaran | `Metode Pembayaran`, `Pilih 1 metode`, `QRIS / E-Wallet`, `Bebas Biaya`, `GoPay, OVO, ShopeePay, DANA, BCA`, `Tunai / COD saat Tiba`, `Siapkan uang pas ke driver` |
| Rincian | `Rincian Pembayaran`, `Subtotal Pesanan ({n} Item)`, `Ongkos Kirim`, `1.8 km`, `Biaya Layanan & Kemasan`, `Total Akhir` |
| Sticky bar | `Total Pembayaran`, `{total}`, `Pesan Sekarang` |
| Dialog hapus | `Hapus item?`, `{nama item} akan dihapus dari keranjang.`, `Batal`, `Hapus` |
| Empty | `Keranjang masih kosong`, `Yuk pilih menu favoritmu dulu.`, `Kembali ke Beranda` |
| SnackBar | `Pusat bantuan belum tersedia di prototype.`, `Ubah alamat belum tersedia di prototype.`, `Item dihapus dari keranjang.`, `Checkout belum tersedia di prototype.` |

Copy yang **tidak boleh muncul lagi di halaman Keranjang**: `Estimasi
Pengantaran`, `15–25 menit`, badge `Seblak Lokuak`, `Voucher & Kupon UMKM`,
`ONGKIRHEMAT`, `Diskon Kupon UMKM`, `Transfer Bank / Virtual Account`,
`Jaminan Makanan Hangat & Higienis 100% Halal`.

---

## 9. A11y & responsive

- [ ] Semantics: stepper berlabel `Kurangi/Tambah porsi <nama>`; pada qty 1 label
      tombol `−` menjadi `Hapus <nama> dari keranjang`.
- [ ] Dialog hapus: judul/isi terbaca, aksi `Batal`/`Hapus` fokus, dan status
      destruktif tidak hanya warna.
- [ ] Catatan item: baris catatan `button` + label edit; drawer memfokuskan
      textarea, hint terbaca, tombol `Tutup`/`Simpan` 48, dan keyboard tidak
      menutup textarea/tombol.
- [ ] Payment card: `button`, `checked`, `inMutuallyExclusiveGroup`; status tidak
      hanya warna.
- [ ] Quick tag driver: `button` + `selected`; tetap dapat diakses saat scroll
      horizontal.
- [ ] Hit target minimal 48; stepper 32 dan tombol `Ubah` (seukuran pill visual)
      adalah pengecualian yang disetujui.
- [ ] Text scale 1.0–2.0 tanpa clipping; harga/stepper item menumpuk bila perlu.
- [ ] Lebar 320–430 dp aman; 320 dan text scale 2.0 tidak overflow.
- [ ] Landscape phone tidak overflow.
- [ ] Kontras aman; tidak ada putih di `secondary-container`.
- [ ] `SafeArea`, keyboard, dan sticky bar tidak menutupi konten.
- [ ] Gambar remote punya loading/error/fallback.
- [ ] App bar 64/72 dan judul ellipsis pada text scale besar.

---

## 10. Acceptance

- [x] Revisi Stitch diterapkan: ETA, badge brand, badge `Mitra Juara UMKM`,
      kupon, VA, diskon, jaminan, dan chevron hilang; label
      `Total Pembayaran` besar.
- [x] App bar, alamat, pesanan, catatan driver, pembayaran, rincian, dan sticky
      bar tampil.
- [x] Keranjang dimulai kosong; empty state tampil sebelum ada item.
- [x] Qty 1–20 mengubah subtotal, item count, dan total.
- [x] Tidak ada icon trash; hapus item hanya lewat tombol `−` pada qty 1.
- [x] `−` pada qty 1 membuka dialog; `Batal` tidak mengubah cart.
- [x] `Hapus` di dialog menghapus item dan menampilkan SnackBar.
- [x] Menghapus item terakhir memunculkan empty state dan menyembunyikan sticky bar.
- [x] Baris catatan per item dapat ditekan dan membuka drawer.
- [x] Drawer memakai judul `Tambah Catatan untuk Pembelian`, textarea borderless
      tinggi, dan placeholder `tulis permintaan khusus di sini ya`.
- [x] Drawer terisi catatan item saat ini; `Simpan` memperbarui catatan item;
      `Tutup`/back tidak mengubah.
- [x] `Tambah Menu Lainnya` kembali ke Beranda.
- [x] QRIS/COD single-select; default QRIS.
- [x] Tag driver multi-select; input maksimal 120 karakter.
- [x] Rincian: subtotal dari line item, ongkir Rp 8.000, layanan Rp 2.000;
      tanpa baris diskon.
- [x] Sticky bar tanpa jaminan/chevron; CTA memberi SnackBar.
- [x] Empty state + CTA Beranda tampil setelah item terakhir dihapus.
- [x] Tidak ada nilai desain hardcoded di widget fitur (ukuran gambar/ikon
      eksplisit diizinkan).
- [x] Tidak ada database/backend/API/auth; mock ditandai `// MOCK ONLY`.
- [ ] E2E dan visual di HP fisik (pengguna).

---

## 11. Verifikasi

| Pemeriksaan | Hasil |
| --- | --- |
| `dart format` file yang berubah | Lulus |
| `flutter analyze` | `No issues found!` |
| `flutter test` | Tidak dijalankan atas permintaan pengguna |
| E2E / `flutter run` | Diserahkan ke pengguna |
| Visual Stitch | Base screen `bf1c60e...` tidak diubah untuk drawer; screenshot 585×2240 tetap |
| Drawer catatan item | Diimplementasikan di Flutter; belum diuji di perangkat |
| Layout 320 / text scale 2.0 / landscape | Belum dijalankan |
| Gambar remote / fallback | Diverifikasi lewat kode; e2e pengguna |

---

## 12. Catatan & keputusan

1. **Revisi Stitch 2026-11-22** — ETA, badge `Seblak Lokuak`, badge
   `Mitra Juara UMKM`, icon hapus item, kupon, transfer bank/VA, diskon, jaminan
   makanan, dan chevron dihapus. Total dihitung dari line item + ongkir
   Rp 8.000 + layanan Rp 2.000.
2. **Line item** — `CartState` diubah dari agregat `itemCount/total` menjadi
   daftar `CartLineItem`; Detail Menu dan Kustomisasi sekarang mengirim item
   lengkap, bukan hanya harga.
3. **Home sticky bar** — ikut membaca total keranjang dan disembunyikan saat
   keranjang kosong.
4. **Kustomisasi** — harga line item tetap `state.total` (total topping tanpa
   harga dasar), sesuai keputusan halaman Kustomisasi.
5. **Checkout** — belum ada layar tujuan; CTA hanya memberi SnackBar prototype.
   Jangan membuat route pesanan/tracking palsu di task ini.
6. **Empty state** — tidak ada frame Stitch; copy dan CTA ditetapkan sebagai
   state minimum prototype. Empty state tampil setelah item terakhir dihapus.
7. **Tag driver** — multi-select; semua tag boleh aktif bersamaan. Input teks
   terpisah dan tidak menimpa tag.
8. **Test** — sesuai instruksi pengguna, `flutter test` dan e2e tidak dijalankan.
   Assertion total di test mengikuti keranjang yang dimulai kosong.
9. **Hapus item** — icon delete/trash tidak ditampilkan. Penghapusan hanya lewat
   tombol `−` pada qty 1, yang membuka `AlertDialog` konfirmasi (Batal/Hapus).
   `CartNotifier.removeItem` dipanggil setelah konfirmasi.
10. **Dialog konfirmasi** — title `Hapus item?`, isi `{nama} akan dihapus dari
    keranjang.`, aksi `Batal`/`Hapus`; `Hapus` memakai warna `error`. Tap di luar
    dialog sama dengan Batal. Frame dialog belum dibuat di Stitch.
11. **Catatan item** — tidak ada section catatan pembelian terpisah. Baris
    catatan per item adalah pemicu drawer; drawer memakai
    `showModalBottomSheet` tinggi ±90%, textarea borderless yang mengisi sheet,
    tombol `Simpan`, dan mengubah catatan item yang sama. Jika disimpan kosong,
    catatan item dihapus. Frame drawer belum dibuat di Stitch.
12. **Nama item** — `Nuget Goreng` dan `Teh Es` diselaraskan dengan Beranda;
    `Seblak Prasmanan Racik` sengaja belum diubah.
13. **Hit box `Ubah`** — tombol pada kartu alamat memakai area sentuh seukuran
    pill visual, bukan perluasan 48×48, sesuai permintaan. Ini pengecualian
    a11y; tombol lain tetap 48.
