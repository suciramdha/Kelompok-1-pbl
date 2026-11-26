# Profil

> Dokumen kerja untuk halaman Profil. Bukan design system dan bukan aturan
> global. Token ada di [`DESIGN.md`](../../design/DESIGN.md); registry komponen
> ada di [`components.md`](../../design/components.md).

| Field | Nilai |
| --- | --- |
| Halaman | Profil |
| Route | `/profile` |
| File utama | `lib/features/profile/presentation/pages/profile_page.dart` |
| Shell | `StatefulShellRoute.indexedStack`, branch 2 |
| Screen ID Stitch | `a72f939cff8c40baa006a93c868fe84b` |
| Status | `done` |
| Mock | `lib/features/profile/presentation/mock/profile_mock.dart` |
| Terakhir diperbarui | 2026-11-22 |
| Referensi | [`DESIGN.md`](../../design/DESIGN.md), [`components.md`](../../design/components.md), [`design-to-code.md`](../../rules/design-to-code.md) |

Status `done`: implementasi selesai, `flutter analyze` bersih, dan e2e/visual
halaman ini sudah diverifikasi pengguna sebelum navigasi Edit Profil
ditambahkan. Alur edit yang baru menunggu e2e pengguna. `flutter test` tidak
dijalankan atas permintaan pengguna.

---

## 1. Tujuan

Menjadi pusat akun pengguna: identitas dan kontak, dukungan UMKM yang sudah
diberikan, menu favorit, pengaturan akun, bantuan, dan aksi keluar. Tombol edit
membuka halaman Edit Profil. Halaman ini tidak mengelola autentikasi; seluruh
aksi non-final hanya memberi feedback prototype.

---

## 2. Scope

- Header tetap: brand mark, `Seblak Lokuak` + badge `UMKM`, subtitle
  `Akun & pengaturan`, notifikasi, dan avatar.
- Kartu profil: avatar tanpa badge kamera, nama, nomor HP dan email dalam dua
  baris, tombol edit yang membuka `/profile/edit`, banner dukungan UMKM.
- Data identitas dibaca dari `profileProvider`; hasil simpan Edit Profil
  langsung terlihat tanpa restart.
- Kartu `Menu Favorit Saya (5)` dengan ringkasan nama menu.
- Section `Preferensi`: Alamat Tersimpan (badge `Utama`), Riwayat Transaksi &
  E-Nota, dan Notifikasi Pesanan & Promo dengan toggle.
- Section `Lainnya`: Chat Admin, Ketentuan, Beri Nilai, dan baris versi dengan
  label `Terbaru`.
- Tombol `Keluar dari Akun` dan footer ID pengguna.
- Feedback prototype lewat SnackBar; toggle notifikasi mengubah state lokal.
- Bottom navigation dari shell.

---

## 3. Di luar scope

- Ganti foto, pemilih alamat, riwayat transaksi, chat admin, ketentuan, rating,
  dan logout sungguhan.
- Wallet, koin loyalitas, voucher, preferensi selera bawaan, dan metode
  pembayaran: dihapus dari desain dan tidak boleh dikembalikan tanpa keputusan
  produk baru.
- Autentikasi, database, backend, API, repository, dan schema.
- Dark mode.
- E2E dan verifikasi visual perangkat; dikerjakan pengguna.

---

## 4. Inventory (Gate 3)

| Screen | Section | Komponen desain | Token | Gambar | State | Interaksi |
| --- | --- | --- | --- | --- | --- | --- |
| `/profile` | Header | `ProfileHeader`, `AppUmkmBadge`, `AppNetworkImage` | `surface`, `primary`, `on-primary`, `on-surface-variant`, `outline-variant`, `elevation.header` | icon + avatar remote | default; image loading/error; large text | Notifikasi memunculkan SnackBar |
| `/profile` | Kartu profil | `ProfileSummaryCard`, `AppNetworkImage` | `surface-container`, `surface-container-low`, `outline-variant`, `secondary` | avatar remote | default; image loading/error; pressed edit; large text | Edit membuka `/profile/edit` |
| `/profile` | Favorit | `_FavoritesCard`, ikon `favorite` | `surface-container-lowest`, `surface-container`, `surface-container-low`, `primary` | icon | default; pressed; large text | Seluruh kartu memunculkan SnackBar |
| `/profile` | Preferensi | `ProfileSectionCard`, `PreferenceTile` | `surface-container-lowest`, `outline-variant`, `secondary-fixed`, `on-secondary-fixed`, `primary` | icon | default; pressed; toggle on/off; large text | Alamat/Riwayat SnackBar; toggle mengubah state |
| `/profile` | Lainnya | `ProfileSectionCard`, `PreferenceTile` | `surface-container-lowest`, `surface-container-low`, `outline`, `secondary-container` | icon | default; pressed; baris versi non-interaktif; large text | Chat/Ketentuan/Nilai SnackBar |
| `/profile` | Keluar | `_LogoutButton` | `surface-container-high`, `primary` | icon | default; pressed | SnackBar prototype |
| `/profile` | Footer | Teks ID pengguna | `body-sm`, `on-surface-variant` | none | default; large text | None |
| `/profile` | Bottom nav | `AppBottomNav` (shell) | `surface`, `primary`, `on-surface-variant` | icon | active; inactive; badge | Pindah branch Beranda/Pesanan/Profil |

Catatan: semua baris daftar hanya memuat ikon, judul, dan trailing opsional.
Deskripsi baris sengaja dihapus dari desain.

---

## 5. Component map (Gate 4)

| Komponen desain | Widget existing | Aksi | Path | Alasan |
| --- | --- | --- | --- | --- |
| Header profil | — | `create` | `lib/features/profile/presentation/widgets/profile_header.dart` | Struktur header berbeda dari `HomeHeader`; tidak ada alamat |
| Kartu profil | — | `create` | `lib/features/profile/presentation/widgets/profile_summary_card.dart` | Komposit khusus profil |
| Kartu section | — | `create` | `lib/features/profile/presentation/widgets/profile_section_card.dart` | Judul + kartu putih + divider inset |
| Baris pengaturan | `PreferenceTile` | `create` | `lib/features/profile/presentation/widgets/preference_tile.dart` | Nama sudah dicadangkan registry; tanpa subtitle |
| Favorit | `_FavoritesCard` | `create` | `profile_page.dart` | Private, dipakai sekali |
| Toggle notifikasi | `_OrderNotificationSwitch` | `create` | `profile_page.dart` | Visual 48×24; semantik toggle |
| Tombol keluar | `_LogoutButton` | `create` | `profile_page.dart` | Warna `surface-container-high` + teks primary, tidak ada varian `AppButton` yang setara |
| Badge `Utama` | `_PillBadge` | `create` | `profile_page.dart` | Private, dipakai sekali |
| Titik status admin | `_LiveDot` | `create` | `profile_page.dart` | Dekoratif, dikecualikan dari semantics |
| Avatar | `AppNetworkImage` | `reuse` | `lib/core/ui/app_network_image.dart` | Loading/error + semantic label |
| Badge UMKM | `AppUmkmBadge` | `reuse` | `lib/core/ui/app_umkm_badge.dart` | Sudah terpusat |
| Bottom nav | `AppBottomNav` | `reuse` | `lib/core/layout/app_bottom_nav.dart` | Shell branch 2 |
| Feedback | `ScaffoldMessenger` + `SnackBar` | `reuse` | — | Pola yang sama dengan Beranda/Detail |

Tidak ada komponen `shared/` atau `core/` baru. Header memakai brand mark
primary + ikon api seperti Beranda, bukan foto logo Stitch, sesuai kebijakan
gambar di `docs/rules/flutter.md`.

---

## 6. State & interaksi

| State | Trigger | Perilaku | Widget |
| --- | --- | --- | --- |
| Default | Buka `/profile` | Toggle notifikasi ON; seluruh section tampil | `ProfilePage` |
| Pressed | Tap baris/kartu/tombol | Ink feedback; tombol keluar scale 0.98 | `InkWell`, `_LogoutButton` |
| Toggle on/off | Tap switch atau baris notifikasi | State lokal berubah; tanpa persistensi | `_OrderNotificationSwitch` |
| Notifikasi | Tap bell | SnackBar `Belum ada notifikasi baru.` | `ProfileHeader` |
| Edit profil | Tap tombol edit | Navigasi ke `/profile/edit`; hasil simpan memperbarui kartu | `ProfileSummaryCard`, router |
| Aksi lain | Tap favorit/alamat/riwayat/chat/ketentuan/nilai/keluar | SnackBar sesuai copy di §8 | `ProfilePage` |
| Baris versi | — | Tidak dapat ditekan; hanya label `Terbaru` | `PreferenceTile` |
| Image loading | Avatar dimuat | Placeholder progres dari `AppNetworkImage` | `AppNetworkImage` |
| Image error | Avatar gagal | Fallback inisial `SR` | `AppNetworkImage` |
| Large text | Text scale > 1.5 | Label kanan section turun ke bawah judul; baris tumbuh; judul maks. 3 baris | `ProfileSectionCard`, `PreferenceTile` |

Tidak ada state screen-level loading/empty/error karena data masih mock statis.
Data identitas memakai `profileProvider` (UI-only, in-memory); toggle notifikasi
tetap state lokal.

---

## 7. Data & mock

- `profile_mock.dart` (`// MOCK ONLY — hapus saat backend tersedia.`):
  - `name`, `username`, `phone`, `email`.
  - `addressLabel`, `address`, `avatarSeed`.
  - `supportCount = 38`, `favoriteCount = 5`, `favoriteSummary`.
  - `userId = SLK-ID-9824-JKT`, `memberSince = Maret 2023`.
- `profile_provider.dart` (`// MOCK ONLY — state profil sementara.`):
  `ProfileNotifier` menyimpan `ProfileData` di memori; `saveProfile`
  memperbarui nama, username, telepon, dan email tanpa persistence.
- State toggle notifikasi: `_orderNotifications`, default `true`.
- Gambar: `RemoteImages.avatar('siti-rahmawati')` di header dan kartu profil;
  fallback inisial `SR` lewat `errorWidget`.
- Batas backend: tidak ada database, API, repository, auth, atau persistence.
- Tidak ada `Image.asset` atau URL Stitch di kode.

---

## 8. Copy

| Lokasi | Copy |
| --- | --- |
| Header | `Seblak Lokuak`, `UMKM`, `Akun & pengaturan`, tooltip `Notifikasi` |
| Kartu profil | `Siti Rahmawati`, `0812-3456-7890`, `siti.rahma@gmail.com`, tooltip `Ubah profil` |
| Banner dukungan | `Telah mendukung 38 pesanan warung seblak & rawit lokal` |
| Favorit | `Menu Favorit Saya (5)`, `Mie Rawit Hijau, Seblak Prasmanan, Mie Jontor` |
| Section Preferensi | `Preferensi`, `Transaksi Aman`, `Alamat Tersimpan`, `Utama`, `Riwayat Transaksi & E-Nota`, `Notifikasi Pesanan & Promo` |
| Section Lainnya | `Lainnya`, `Chat Admin Warung 24 Jam`, `Ketentuan Pemesanan & Mitra UMKM`, `Beri Nilai Aplikasi Seblak Lokuak`, `Seblak Lokuak`, `Terbaru` |
| Aksi | `Keluar dari Akun` |
| Footer | `ID Pengguna: SLK-ID-9824-JKT • Terdaftar sejak Maret 2023` |
| SnackBar | `Belum ada notifikasi baru.`, `Menu favorit belum tersedia di prototype.`, `Ubah alamat belum tersedia di prototype.`, `Riwayat transaksi belum tersedia di prototype.`, `Chat admin belum tersedia di prototype.`, `Ketentuan pemesanan belum tersedia di prototype.`, `Beri nilai aplikasi belum tersedia di prototype.`, `Keluar dari akun belum tersedia di prototype.` |

---

## 9. A11y & responsive

- `ProfileSectionCard` memberi `Semantics(header: true)` pada judul section.
- Bell memakai tooltip `Notifikasi`; tombol edit memakai tooltip `Ubah profil`.
- Switch memakai `Semantics(label: 'Notifikasi Pesanan & Promo', toggled: ...)`.
  Baris notifikasi juga dapat ditekan untuk toggle.
- `PreferenceTile` memakai `Semantics(button: true)` saat ada aksi; chevron,
  ikon leading, dan titik status dikecualikan dari semantics.
- Avatar memakai `semanticLabel`; fallback `SR` tetap terbaca.
- Hit target: bell 48, edit 48, baris minimal 56, tombol keluar minimal 48.
- Judul baris maksimal 3 baris; banner dukungan membungkus tanpa ellipsis.
- Label kanan section turun ke bawah judul saat text scale > 1.5.
- Layout memakai `ListView` dan `Expanded`; aman di 320–430 dp.
- Kontras memakai token theme; tidak ada putih di `secondary-container`.
- **Belum dicatat:** text scale 2.0, landscape, TalkBack/VoiceOver, dan focus
  order di perangkat.

---

## 10. Acceptance

- [x] Header, kartu profil, favorit, `Preferensi`, `Lainnya`, keluar, dan footer
      tampil.
- [x] Foto profil tanpa ikon kamera; telepon dan email dua baris.
- [x] Badge level pedas, wallet/koin/voucher, preferensi selera, dan metode
      pembayaran tidak ada.
- [x] Judul section `Preferensi` dan `Lainnya`; ikon baris tanpa background.
- [x] Baris daftar tidak menampilkan deskripsi.
- [x] Toggle notifikasi berfungsi dan default ON.
- [x] Semua aksi prototype memberi SnackBar; tidak ada tombol mati.
- [x] Tombol edit membuka `/profile/edit`; hasil simpan terlihat di kartu.
- [x] Data identitas dibaca dari `profileProvider` UI-only.
- [x] Mock ditandai `// MOCK ONLY`; tidak ada backend/API/auth.
- [x] Avatar memakai `AppNetworkImage` + fallback inisial.
- [x] E2E dan visual di HP fisik (diverifikasi pengguna).
- [ ] Alur buka Edit Profil → simpan → kembali (e2e pengguna).
- [ ] 320/360/412/430 dp, text scale 2.0, landscape, dan screen reader.

---

## 11. Verifikasi

| Pemeriksaan | Hasil |
| --- | --- |
| `dart format lib/features/profile lib/app/router/app_router.dart` | Bersih, 0 file berubah |
| `flutter analyze` | `No issues found!` |
| `flutter test` | Tidak dijalankan sesuai instruksi pengguna |
| E2E / `flutter run` | Lulus oleh pengguna di HP fisik sebelum navigasi edit; alur edit belum di-e2e |
| `flutter analyze` (2026-11-24, setelah edit) | `No issues found!` |
| Visual Stitch | Screen `a72f939...` diperbarui dan screenshot 390×1080 diperiksa |
| Layout 320 / text scale 2.0 | Belum dicatat |
| Gambar remote / fallback | Avatar tampil saat e2e; fallback error belum diuji terpisah |

---

## 12. Catatan & follow-up

1. **Revisi Stitch 2026-11-22** — kamera, badge level pedas, section preferensi
   selera, wallet/koin/voucher, metode pembayaran, dan seluruh deskripsi baris
   dihapus; `Pengaturan & Akun` → `Preferensi`; `Bantuan & Komunitas UMKM` →
   `Lainnya`; ikon baris tanpa background. Screenshot Stitch 390×1080 sudah
   diperiksa.
2. **Judul screen Stitch** masih `Profil Pengguna & Pengaturan Akun`; judul itu
   adalah label canvas, bukan copy di dalam halaman.
3. **Brand mark header** memakai tile primary + ikon api seperti Beranda, bukan
   foto logo di Stitch, mengikuti kebijakan logo di `docs/rules/flutter.md`.
4. **Toggle dan logout bukan fitur final.** Keduanya hanya state lokal/SnackBar.
5. **Belum ada test widget Profil.** Sesuai instruksi, pengujian otomatis tidak
   dijalankan; e2e manual sudah lulus.
6. **Edit Profil** tersedia di `/profile/edit` dengan provider UI-only dan
   validasi form; detail ada di [`edit-profil.md`](edit-profil.md). Avatar dan
   header Profil masih memakai seed/foto statis setelah nama diubah.
