---
name: Seblak Lokuak
colors:
  primary: '#af101a'
  on-primary: '#ffffff'
  primary-container: '#d32f2f'
  on-primary-container: '#fff2f0'
  primary-fixed: '#ffdad6'
  primary-fixed-dim: '#ffb3ac'
  on-primary-fixed: '#410003'
  on-primary-fixed-variant: '#930010'
  secondary: '#9f4200'
  on-secondary: '#ffffff'
  secondary-container: '#fd6c00'
  on-secondary-container: '#562000'
  secondary-fixed: '#ffdbcb'
  secondary-fixed-dim: '#ffb692'
  on-secondary-fixed: '#341100'
  on-secondary-fixed-variant: '#7a3000'
  tertiary: '#7d4c00'
  on-tertiary: '#ffffff'
  tertiary-container: '#9f6200'
  on-tertiary-container: '#fff3e9'
  tertiary-fixed: '#ffddba'
  tertiary-fixed-dim: '#ffb865'
  on-tertiary-fixed: '#2b1700'
  on-tertiary-fixed-variant: '#663d00'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  background: '#fff8f5'
  on-background: '#231a11'
  surface: '#fff8f5'
  on-surface: '#231a11'
  surface-dim: '#e9d7c8'
  surface-bright: '#fff8f5'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#fff1e8'
  surface-container: '#feeadc'
  surface-container-high: '#f8e5d6'
  surface-container-highest: '#f2dfd1'
  surface-variant: '#f2dfd1'
  on-surface-variant: '#5b403d'
  outline: '#8f6f6c'
  outline-variant: '#e4beba'
  inverse-surface: '#392e25'
  inverse-on-surface: '#ffeee1'
  inverse-primary: '#ffb3ac'
  surface-tint: '#ba1a20'
  neutral: '#2b2118'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 40px
    fontWeight: '800'
    lineHeight: 48px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 30px
    fontWeight: '800'
    lineHeight: 36px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 28px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 26px
  title-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '700'
    lineHeight: 24px
  title-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '700'
    lineHeight: 18px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '600'
    lineHeight: 14px
    letterSpacing: 0.03em
  price-display:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '800'
    lineHeight: 22px
    letterSpacing: -0.01em
rounded:
  sm: 4px
  DEFAULT: 8px
  md: 12px
  lg: 16px
  xl: 24px
  full: 9999px
spacing:
  space-xs: 4px
  space-sm: 8px
  space-md: 12px
  space-lg: 16px
  space-xl: 24px
  margin: 16px
  margin-md: 24px
  margin-lg: 32px
  gutter: 16px
  gutter-sm: 12px
---

# Design System: Seblak Lokuak

> **Status: ACTIVE — sumber Stitch.**
> Canonical untuk warna, typography, spacing, radius, dan komponen visual.
> Audit drift ada di `docs/design/stitch-theme-audit.md`.
> Aturan coding ada di `docs/rules/flutter.md`; registry komponen ada di
> `docs/design/components.md`.

**Project:** `projects/17496044663583378114`  
**Design system:** `assets/70cd384c0c9e4ec7916963fa66aeca50`, version 2  
**Target device:** handphone Android/iOS  
**Orientasi utama:** portrait  
**Frame desain:** 390 dp; range 320–430 dp  
**Platform di luar scope:** web, desktop, tablet/iPad-specific, TV, watch  
**Tema:** light-only  
**Tahap proyek:** frontend-only prototype  
**Backend/database:** belum ada  
**Gambar:** remote placeholder; bukan asset lokal

---

## 1. Brand & Atmosphere

**Seblak Lokuak** adalah aplikasi delivery UMKM untuk pencinta kuliner pedas,
mahasiswa, dan pekerja kantor. Nuansa brand menggabungkan **Modern Mobile
Commerce** dengan **Warm Tactile Vitality**:

- **Appetizing & Sensory:** merah cabai, oranye wok, amber kerupuk, dan cream
  hangat.
- **Accessible & Utilitarian:** browsing cepat, kustomisasi pedas/topping, dan
  checkout tanpa friksi.
- **Friendly Street Cred:** bentuk membulat, badge level pedas, harga jelas, dan
  pelacakan delivery yang ramah.

`Warung Pedas Express` adalah nama legacy di `designMd`/screen title; jangan
dipakai sebagai brand baru.

---

## 2. Colors & Roles

> Token di bawah adalah canonical. Narasi `designMd` yang memakai `#D32F2F`,
> `#FF6D00`, atau `#FFA000` harus dipetakan ke container role yang sesuai.

### Primary & Brand

| Token | Hex | Peran |
| --- | --- | --- |
| `primary` | `#AF101A` | CTA, active nav, aksi utama |
| `on-primary` | `#FFFFFF` | Teks/icon di atas primary |
| `primary-container` | `#D32F2F` | Surface brand/hero merah terang |
| `on-primary-container` | `#FFF2F0` | Teks di atas primary container |
| `primary-fixed` | `#FFDAD6` | Surface merah muda |
| `primary-fixed-dim` | `#FFB3AC` | Aksen merah muda |
| `on-primary-fixed` | `#410003` | Teks di atas primary fixed |
| `on-primary-fixed-variant` | `#930010` | Deep crimson |

### Secondary & Tertiary

| Token | Hex | Peran |
| --- | --- | --- |
| `secondary` | `#9F4200` | Aksen sekunder, teks oranye gelap |
| `on-secondary` | `#FFFFFF` | Teks di atas secondary |
| `secondary-container` | `#FD6C00` | Badge, filter aktif, spice meter |
| `on-secondary-container` | `#562000` | Teks di atas orange container |
| `secondary-fixed` | `#FFDBCB` | Badge UMKM lembut |
| `secondary-fixed-dim` | `#FFB692` | Aksen peach |
| `on-secondary-fixed` | `#341100` | Teks di atas secondary fixed |
| `on-secondary-fixed-variant` | `#7A3000` | Teks sekunder peach |
| `tertiary` | `#7D4C00` | Amber gelap |
| `on-tertiary` | `#FFFFFF` | Teks di atas tertiary |
| `tertiary-container` | `#9F6200` | Surface amber |
| `on-tertiary-container` | `#FFF3E9` | Teks di atas tertiary container |
| `tertiary-fixed` | `#FFDDBA` | Amber lembut |
| `tertiary-fixed-dim` | `#FFB865` | Gold/kerupuk |
| `on-tertiary-fixed` | `#2B1700` | Teks di atas amber |
| `on-tertiary-fixed-variant` | `#663D00` | Amber gelap |

### Surface & Text

| Token | Hex | Peran |
| --- | --- | --- |
| `background` | `#FFF8F5` | Kanvas warm cream |
| `on-background` | `#231A11` | Teks utama |
| `surface` | `#FFF8F5` | Surface utama |
| `on-surface` | `#231A11` | Teks di atas surface |
| `surface-dim` | `#E9D7C8` | Surface redup |
| `surface-bright` | `#FFF8F5` | Surface terang |
| `surface-container-lowest` | `#FFFFFF` | Card paling terang |
| `surface-container-low` | `#FFF1E8` | Surface lembut |
| `surface-container` | `#FEEADC` | Surface peach |
| `surface-container-high` | `#F8E5D6` | Surface lebih gelap |
| `surface-container-highest` | `#F2DFD1` | Surface tertinggi |
| `surface-variant` | `#F2DFD1` | Surface alternatif |
| `on-surface-variant` | `#5B403D` | Teks sekunder |
| `outline` | `#8F6F6C` | Border kuat; bukan body text |
| `outline-variant` | `#E4BEBA` | Divider/border lembut |
| `inverse-surface` | `#392E25` | Surface inverse |
| `inverse-on-surface` | `#FFEEE1` | Teks inverse |
| `surface-tint` | `#BA1A20` | Tint surface |
| `neutral` | `#2B2118` | Shadow/netral gelap |

### Functional

| Token | Hex | Peran |
| --- | --- | --- |
| `error` | `#BA1A1A` | Error, destructive |
| `on-error` | `#FFFFFF` | Teks di atas error |
| `error-container` | `#FFDAD6` | Background error |
| `on-error-container` | `#93000A` | Teks di atas error container |

**Dark mode:** tidak tersedia di Stitch. Jangan mengarang dark palette; jika
diminta, definisikan terpisah dan catat sebagai keputusan baru.

---

## 3. Typography

Semua style memakai **Plus Jakarta Sans**.

| Style | Size | Weight | Line height | Letter spacing | Pemakaian |
| --- | --- | --- | --- | --- | --- |
| `display-lg` | 40 | 800 | 48 | -0.02em | Hero wide/large (opsional) |
| `display-lg-mobile` | 30 | 800 | 36 | -0.02em | Hero handphone |
| `headline-lg` | 28 | 700 | 36 | -0.01em | Judul halaman wide (opsional) |
| `headline-lg-mobile` | 22 | 700 | 28 | -0.01em | Judul halaman handphone |
| `headline-md` | 20 | 700 | 26 | 0 | Judul section |
| `title-lg` | 18 | 700 | 24 | 0 | Judul card/dialog |
| `title-md` | 16 | 600 | 22 | 0 | Subjudul |
| `body-lg` | 16 | 400 | 24 | 0 | Body utama |
| `body-md` | 14 | 400 | 20 | 0 | Body sekunder |
| `body-sm` | 12 | 400 | 16 | 0 | Metadata |
| `label-lg` | 14 | 700 | 18 | 0.01em | Tombol/label |
| `label-md` | 12 | 700 | 16 | 0.02em | Label kecil |
| `label-sm` | 11 | 600 | 14 | 0.03em | Badge/microcopy |
| `price-display` | 18 | 800 | 22 | -0.01em | Harga |

Aturan:

- Handphone memakai varian mobile untuk display/headline.
- Semua teks memakai `TextTheme`; `price-display` menjadi custom style.
- Line-height Figma: `height = lineHeightPx / fontSizePx`.
- Letter-spacing persen: `fontSize * percent / 100`.
- Jangan memakai ukuran `text-[...]` arbitrary dari HTML Stitch.

---

## 4. Spacing, Shape & Elevation

### Spacing

| Token | Nilai | Pemakaian |
| --- | --- | --- |
| `space-xs` | 4 | Gap mikro, icon-label |
| `space-sm` | 8 | Gap dalam komponen |
| `space-md` | 12 | Gap antar elemen rapat |
| `space-lg` | 16 | Padding default |
| `space-xl` | 24 | Gap section |
| `margin` | 16 | Margin halaman |
| `margin-md` | 24 | Margin section |
| `margin-lg` | 32 | Margin section besar |
| `gutter` | 16 | Gap grid utama |
| `gutter-sm` | 12 | Gap grid rapat |

### Radius

| Token | Nilai | Pemakaian |
| --- | --- | --- |
| `sm` | 4 | Checkbox, chip kecil |
| `DEFAULT` | 8 | Button, input, listing tile |
| `md` | 12 | Card kecil, thumbnail |
| `lg` | 16 | Card, warung showcase |
| `xl` | 24 | Bottom sheet/drawer |
| `full` | 9999 | Pill, search bar, stepper |

### Elevation

- **Level 1 — card:** `0 2 8 rgba(43,33,24,0.06)` + border
  `1px rgba(43,33,24,0.04)`.
- **Level 2 — floating chip/cart bar:** `0 8 20 rgba(211,47,47,0.12)`.
- **Level 3 — modal/sheet:** `0 16 36 rgba(43,33,24,0.16)` + backdrop blur 6
  + scrim `rgba(43,33,24,0.48)`.
- App bar/filter bar: surface translusen + `BackdropFilter`; jangan memakai
  shadow hitam pekat.

Catatan: HTML Stitch kadang memakai shadow `0 1 8 rgba(0,0,0,0.04)` atau
`0 -4 20 rgba(43,33,24,0.08)`. Itu varian implementasi, bukan token baru.

---

## 5. Components

### Buttons

- **Primary:** fill `primary #AF101A`, teks putih, radius 8, pressed scale 0.98.
  Tinggi visual mengikuti teks + padding (default 16 horizontal / 10 vertical);
  hit target 48; lebar mengikuti isi. Full width hanya jika `expand: true`.
  `#D32F2F` adalah container/hero, bukan CTA default.
- **Secondary:** surface lembut (`surface-container-low`), teks `secondary`,
  borderless. designMd menyebut `#FFF3E0`/`#FF6D00`; gunakan token dan pastikan
  kontras. Hindari teks putih di atas `secondary-container`.
- **Quantity stepper:** tanpa background pill; tombol minus/plus visual 32
  dengan ikon 16. Hit target Flutter 32 (pengecualian disetujui untuk stepper
  qty; komponen lain tetap 48). Kustomisasi memakai tombol tambah primary;
  Detail Menu memakai dua tombol surface. Pada Kustomisasi, harga dan counter
  berada dalam satu `Row`; qty 0 hanya menampilkan tombol tambah, counter
  muncul setelah qty bertambah. Di lebar sempit/teks besar, keduanya menumpuk
  dalam satu `Column`.
- **Hero CTA:** arrow mengikuti teks di kanan (`iconPosition: trailing`).
- **CTA panjang:** boleh dua baris lewat `labelMaxLines: 2` + `expand: true`;
  jangan memotong label dengan ellipsis saat text scale besar.
- **Hero image:** foto bulat di kanan bawah, dipotong tepi card; teks di kiri
  dengan lebar ±62–64% agar tidak bertabrakan.

### Badges & Chips

- **Spice level 0–5:** gradasi cream → amber → orange → merah → crimson.
  Gunakan `tertiary-fixed`, `tertiary-fixed-dim`, `secondary-container`,
  `primary-container`, dan `on-primary-fixed-variant`.
- **Category filter:** pill; selected memakai `secondary-container` +
  `on-secondary-container`; unselected memakai `surface-container-low` +
  border `outline-variant`.
- **UMKM badge:** `secondary-fixed` + `on-secondary-fixed`; designMd menyebut
  amber `#FFA000`, tetapi layar aktual memakai peach.

### Cards

- **Dish card:** horizontal, thumbnail 96×96 radius 8, judul + spice tag.
  Harga `price-display` berada di kolom teks. Seluruh kartu adalah tap target ke
  Detail Menu; tidak ada tombol `+`. Jika text scale >1.5, harga turun
  full-width agar aman.
- **Snack grid:** 2 kolom untuk Cemilan pada lebar ≥360; gambar atas ratio 1.5,
  body padding 10, harga di bawah deskripsi. Item ganjil terakhir menjadi card
  horizontal full-width. Fallback ke list di 320 atau text scale >1.25.
- **Warung card:** vertikal, hero 16:9 radius 16, badge delivery time, rating,
  jarak, minimum order.

### Detail Menu

- **App bar:** fixed 64; back, `Detail Menu`, share, favorite. Text scale >1.5
  memakai tinggi 72 dan judul ellipsis.
- **Hero:** gambar 4:3, maksimal 320 tinggi; gradient gelap di bawah; badge
  `Terlaris #2` (`primary`/`on-primary`) di kanan atas bila tersedia.
- **Info:** judul `headline-lg-mobile`, waktu masak (ikon jam `secondary`, teks
  `body-sm`) bila tersedia, harga coret bila ada, harga aktif `price-display`
  primary, deskripsi `body-md`. Text scale >1.5 menurunkan harga ke bawah judul.
- **Spice selector:** kartu radio; hanya untuk menu ber-level (Mie Rawit, Mie
  Jontor, Mie Narako); tanpa pilihan awal; selected `primary-fixed` 20%; tag
  `Gurih` netral, `Favorit`/`Ekstrem` `secondary-fixed`; label `Termasuk`.
- **Topping:** baris checkbox 24; untuk semua Makanan; selected
  `secondary-container` dengan check `on-secondary-container`; harga tambahan
  `secondary`.
- **Topping prasmanan:** thumbnail 80×80 radius 8; judul + deskripsi; harga
  `price-display` dan stepper qty dalam satu parent.
- **Suhu penyajian:** dua kartu radio `Dingin`/`Panas`; hanya Jus Jeruk; tanpa
  pilihan awal; selected `primary-fixed` 20%; border `outline-variant`.
- **Validasi CTA:** level pedas dan suhu penyajian wajib dipilih; jika belum,
  SnackBar `Pilih tingkat kepedasan dulu ya.` / `Pilih suhu penyajian dulu ya.`
  dan item tidak masuk keranjang.
- **Section visibility:** tampilkan hanya section yang punya data; divider hanya
  di antara section yang tampil.
- **Note field:** textarea 3 baris, maksimal 120 karakter, counter di bawah;
  focus border `secondary-container`.
- **Bottom bar:** quantity stepper tombol 32 tanpa background (hit 32 Flutter),
  total `price-display`, CTA
  primary full-width. Text scale >1.5 menumpuk total dan CTA.
- **Toast:** pill `inverse-surface`, ikon api, durasi 2,4 detik.

### Forms

- **Topping tile:** checkbox 24×24 radius 8; selected `secondary-container`
  + check `on-secondary-container`; seluruh row adalah tap target.
- **Spice option:** kartu radio 20; selected `primary-fixed` 20%; tag
  `Gurih`/`Favorit`/`Ekstrem`; label `Termasuk`.
- **Note field:** textarea 3 baris, maksimal 120 karakter; fill
  `surface-container-lowest`, focus border `secondary-container`, placeholder
  `outline-variant`.

### Keranjang & Checkout

- **App bar:** back, `Keranjang & Checkout`, bantuan; tinggi 64/72 dengan border
  bawah.
- **Section card:** `surface-container-lowest`, border `outline-variant`, radius
  `lg`, padding 16; jarak antar section 12.
- **Alamat:** ikon lokasi `primary`; nama alamat `title-md`; badge `Alamat Utama`
  memakai `secondary-fixed`; kotak catatan `surface-container-low`; aksi `Ubah`
  pill dengan hit area seukuran pill (pengecualian 48).
- **Item:** thumbnail 80×80 radius `md`; badge level pedas `primary`; judul,
  ringkasan racikan `body-sm`, harga `price-display`, stepper qty, dan kotak
  catatan item. Tidak ada icon hapus. Harga dan stepper menumpuk pada lebar
  <360 atau text scale >1.5.
- **Konfirmasi hapus:** tombol `−` pada qty 1 membuka `AlertDialog`; judul
  `Hapus item?`, isi `{nama item} akan dihapus dari keranjang.`, aksi `Batal`
  dan `Hapus` (warna `error`). Tap di luar dialog sama dengan Batal.
- **Catatan item:** baris catatan di kartu item adalah tombol edit; tap membuka
  bottom sheet setinggi ±90%, judul `Tambah Catatan untuk Pembelian`, textarea
  borderless yang mengisi sheet, placeholder `tulis permintaan khusus di sini
  ya`, dan CTA `Simpan` full width. `Simpan` memperbarui catatan item yang sama.
- **Catatan driver:** quick tag horizontal multi-select; selected `primary` +
  `on-primary`; input satu baris maksimal 120 tanpa counter.
- **Pembayaran:** dua kartu radio; QRIS default; selected `surface-container-low`
  dengan radio `primary`; status dibawa oleh semantics, bukan warna saja.
- **Rincian:** baris subtotal, ongkir + jarak, biaya layanan; divider; `Total
  Akhir` `title-lg` + nominal `headline-lg-mobile` primary. Tidak ada baris
  diskon/kupon.
- **Sticky checkout:** bottom bar via scaffold, surface + border atas; label
  `Total Pembayaran` `title-md`, nominal `headline-lg-mobile`, CTA primary full
  width `Pesan Sekarang`; tanpa chevron dan tanpa jaminan makanan.
- **Empty state:** `AppEmptyState` dengan ikon, judul, pesan, dan CTA kembali ke
  Beranda.

### Navigation & sticky bar

- **Bottom nav:** 3 item (Beranda, Pesanan, Profil), tinggi 72, hit target 48,
  active `primary`.
- **Sticky order bar:** bottom-fixed di atas nav, surface translusen + blur,
  total item, harga, CTA `Lihat Pesanan` memakai `primary`.
- **App bar:** home 112 tinggi (logo + status buka/ETA), detail 64; surface
  translusen + blur.

### Profil

- **Header:** brand mark 38 (tile primary + ikon api), `Seblak Lokuak` + badge
  UMKM, subtitle `Akun & pengaturan`; bell hit target 48; avatar 32.
- **Kartu profil:** surface `surface-container`, avatar 72 tanpa badge kamera;
  nama `headline-md`; nomor HP dan email dua baris `body-sm`; tombol edit visual
  32 dengan hit target 48; banner dukungan `surface-container-low` dengan ikon
  verified dan angka `secondary`.
- **Baris daftar:** ikon 24 tanpa background container, judul `title-md`, tanpa
  deskripsi; tinggi minimum 56; chevron 20; divider inset sejajar awal judul.
- **Section:** `Preferensi` dan `Lainnya` memakai kartu putih
  `surface-container-lowest` dengan border `outline-variant`.
- **Aksi keluar:** full-width `surface-container-high` + teks primary, radius
  `lg`, tinggi minimum 48.
- Wallet, koin, voucher, preferensi selera, dan metode pembayaran tidak termasuk
  desain Profil saat ini.

### Edit Profil

- **Header:** back hit 48, judul `Edit Profil` `title-lg`, aksi `Simpan` primary
  ringkas; tinggi 64/72; border bawah `outline-variant`.
- **Avatar:** 96 bulat dengan shadow; badge kamera visual 36 (hit 48) memakai
  `secondary-container` + `on-secondary-container`; aksi `Ubah Foto Profil`
  primary; caption `Format JPG, PNG maks. 5MB` `body-sm`.
- **Kartu data diri:** `surface-container-lowest`, border `outline-variant`,
  radius `lg`, padding 16; header ikon `primary` + `title-md`.
- **Field:** label `label-md` `on-surface-variant`; fill
  `surface-container-low`, radius `DEFAULT`; ikon leading 20; focus
  `secondary-container`; error `error`. Badge status: `Tersedia`
  (surface container + tertiary), `Terverifikasi` (`secondary-fixed` +
  `on-secondary-fixed-variant`), `Utama` (`primary-fixed` +
  `on-primary-fixed-variant`). ID Pengguna read-only dengan teks
  `on-surface-variant` dan catatan `Terdaftar sejak`.
- **Alamat utama:** kartu yang sama; kotak alamat `surface-container-low` radius
  `md`; aksi `Kelola Daftar Alamat` full-width `surface-container`, hit 48,
  chevron kanan.
- **Aksi:** `Simpan Perubahan` primary full-width dengan label `label-lg` dan
  ikon check 18, sama dengan CTA lain; `Batal` varian neutral full-width.
- **State:** error validasi per field, sukses lewat SnackBar, loading/error
  avatar lewat `AppNetworkImage`. Aksi foto dan kelola alamat hanya feedback
  prototype karena belum ada image picker/route alamat.

---

## 6. Layout & Responsive

- Mobile-first, one-handed, vertical scrolling.
- Grid mobile: 4 kolom; margin 16; gutter 12.
- Frame acuan 390 dp; range 320–430 dp.
- Tidak ada tablet/desktop layout khusus. Jika lebar >600, gunakan max width
  dan center; jangan membuat navigation rail/grid desktop.
- `SafeArea` wajib; sticky bar dan bottom sheet minimal 16 px di atas system
  navigation.
- Form panjang scroll; list panjang virtualized.
- Setiap slot gambar memakai `AspectRatio` atau ukuran eksplisit.
- Target sentuh minimal 48×48.

---

## 7. States & Interactions

| State | Wajib | Catatan |
| --- | --- | --- |
| Default | Ya | Tampilan normal |
| Pressed | Ya | Feedback sentuh; scale 0.98 pada CTA |
| Focused | Sesuai kebutuhan | Untuk a11y/keyboard eksternal |
| Disabled | Ya | Tetap terbaca |
| Loading | Untuk aksi async | Mencegah double submit |
| Empty | Untuk list/screen | Copy + CTA |
| Error | Untuk async/form | Pesan + retry |
| Success | Untuk form/aksi | Feedback jelas |

- **DILARANG** hover state, mouse cursor, right-click, atau shortcut desktop.
- Abaikan class `hover:` dari HTML Stitch.
- Animasi memakai token/duration theme dan menghormati `disableAnimations`.

---

## 8. Accessibility

- Kontras teks minimal 4.5:1 (normal), 3:1 (teks besar).
- **Jangan** memakai putih di `secondary-container #FD6C00` (2.87:1).
  Gunakan `on-secondary-container #562000` (4.57:1).
- `outline #8F6F6C` hanya untuk border/icon, bukan body text.
- Target sentuh minimal 48×48; HTML Stitch 44 px harus dinaikkan.
- Icon-only button wajib punya `Semantics` label.
- Gambar informatif wajib punya `semanticLabel`; dekorasi `ExcludeSemantics`.
- Dukung text scale 1.0–2.0 tanpa clipping.
- Uji TalkBack/VoiceOver dan fokus order.

---

## 9. Remote Imagery & Icons

- Tidak ada gambar desain di `assets/`.
- **DILARANG** memakai URL `lh3.googleusercontent.com/aida-public/...` dari
  Stitch di produksi.
- Sumber remote:
  - Foto makanan/hero: curated Unsplash direct URL yang stabil; fallback
    Picsum seed.
  - Avatar/profile: Pravatar seed; fallback inisial.
  - Placeholder netral: Placehold.co.
- URL terpusat di `lib/core/constants/remote_images.dart`.
- `Image.network` hanya di `AppNetworkImage`; wajib `fit`, loading, error,
  `semanticLabel`.
- Logo: wordmark teks “Seblak Lokuak” + icon cabai/Material, bukan foto acak.
- Icon: Stitch memakai Material Symbols Outlined. Flutter memakai Material
  Icons terdekat, atau package `material_symbols_icons` dengan persetujuan.
- Jangan memakai base64 atau `source.unsplash.com`.
- Android release butuh izin `INTERNET`; iOS HTTPS.

---

## 10. Motion

| Token | Durasi | Pemakaian |
| --- | --- | --- |
| `fast` | 150 ms | Feedback kecil |
| `normal` | 250 ms | Transisi default |
| `slow` | 400 ms | Sheet/dialog |
| `toast` | 2400 ms | Toast sukses Detail Menu |

Easing default `Curves.easeInOut`; CTA pressed scale 0.98. Hormati reduce motion.
Motion belum didefinisikan eksplisit di designMd; ini baseline sampai ada
spesifikasi baru.

---

## 11. Sources & Screens

| Screen | Screen ID | Status |
| --- | --- | --- |
| Beranda | `54c4f90aaeed4c4bb07def3ad1d3b0c5` | active |
| Detail Menu - Mie Rawit Hijau | `4d0cd885dbc347b5ad311319c5315786` | active |
| Kustomisasi Seblak Prasmanan | `680464cfe0ee49968995424276b050be` | active |
| Keranjang & Checkout Delivery | `bf1c60ee794b45788adcd987f8f81168` | active |
| Status Pesanan & Pelacakan Live | `788bf895ca3b4ee6a023e64146d3e621` | active |
| Riwayat Pesanan | `c60bf40707b647c783bdaf626116aa1f` | active |
| Profil Pengguna & Pengaturan Akun | `a72f939cff8c40baa006a93c868fe84b` | active |
| Edit Profil Pengguna | `9da500fabcac4eac9947a449383b3616` | active |
| Warung Pedas Express Food Ordering | `a74e6a7b08804e1e933592c3e57e3e24` | hidden legacy |

**Source of truth:** `namedColors`, `typography`, `rounded`, dan `spacing` dari
Stitch design system. `designMd` adalah narasi brand; HTML adalah spesifikasi
implementasi. Jika berbeda, token menang.

---

## 12. Known Drift

- `designMd` masih memakai nama **Warung Pedas Express**.
- Judul screen Beranda masih legacy.
- `designMd` menyebut primary `#D32F2F`, secondary `#FF6D00`, tertiary
  `#FFA000`; token aktual memakai `#AF101A`, `#9F4200`, `#7D4C00` dan
  container roles.
- HTML Tailwind config membulatkan `DEFAULT/lg/xl` menjadi 4/8/12, bukan
  8/16/24.
- HTML memakai `hover:` dan arbitrary text sizes.
- `designTheme.components` kosong.

Detail dan bukti ada di `docs/design/stitch-theme-audit.md`.

