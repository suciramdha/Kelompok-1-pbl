# Flutter Implementation Rules

> Aturan teknis untuk semua task UI/Flutter. Baca `AGENTS.md` lebih dulu.
> Proyek ini frontend-only; tidak ada database/backend/API.

**Dokumen terkait:**

- `docs/design/DESIGN.md` — token dan aturan visual
- `docs/design/components.md` — registry komponen
- `docs/rules/reuse.md` — keputusan reusable/komponen
- `docs/rules/design-to-code.md` — workflow desain/MCP

---

## 1. Struktur folder

```text
lib/
  main.dart
  app/
    app.dart
    router/
      app_router.dart
      app_routes.dart
    theme/
      app_theme.dart
      app_colors.dart
      app_typography.dart
      app_spacing.dart
      app_radius.dart
      app_elevation.dart
      app_motion.dart
  core/
    ui/
    layout/
    constants/
      remote_images.dart
    utils/
  features/
    <fitur>/
      presentation/
        pages/
        widgets/
        providers/
        mock/
  shared/
    widgets/
    mock/
```

Struktur ini hanya organisasi UI, bukan arsitektur final. **DILARANG** membuat
`data/` atau `domain/` sampai backend/database ditentukan.

---

## 2. Material 3 & theme — Seblak Lokuak

- Gunakan `ThemeData(useMaterial3: true)`.
- Theme saat ini **light-only**. Jangan mengarang dark palette.
- Token utama: `ColorScheme`, `TextTheme`, dan `ThemeExtension` untuk spacing,
  radius, elevation, dan motion.
- Widget fitur mengakses token lewat `Theme.of(context)` atau extension.
- **DILARANG** `Color(0xFF...)`, `EdgeInsets.all(16)`,
  `BorderRadius.circular(12)`, atau `TextStyle(fontSize: 14)` di widget fitur.
- Gunakan `withValues(alpha: ...)`, bukan `withOpacity` yang deprecated.
- Perubahan token wajib sinkron antara `docs/design/DESIGN.md` dan theme.

### 2.1 ColorScheme

| Role | Nilai |
| --- | --- |
| `primary` | `#AF101A` |
| `onPrimary` | `#FFFFFF` |
| `primaryContainer` | `#D32F2F` |
| `onPrimaryContainer` | `#FFF2F0` |
| `secondary` | `#9F4200` |
| `onSecondary` | `#FFFFFF` |
| `secondaryContainer` | `#FD6C00` |
| `onSecondaryContainer` | `#562000` |
| `tertiary` | `#7D4C00` |
| `onTertiary` | `#FFFFFF` |
| `tertiaryContainer` | `#9F6200` |
| `onTertiaryContainer` | `#FFF3E9` |
| `background` / `surface` | `#FFF8F5` |
| `onBackground` / `onSurface` | `#231A11` |
| `surfaceContainerLowest` | `#FFFFFF` |
| `surfaceContainerLow` | `#FFF1E8` |
| `surfaceContainer` | `#FEEADC` |
| `surfaceContainerHigh` | `#F8E5D6` |
| `surfaceContainerHighest` | `#F2DFD1` |
| `onSurfaceVariant` | `#5B403D` |
| `outline` | `#8F6F6C` |
| `outlineVariant` | `#E4BEBA` |
| `error` | `#BA1A1A` |
| `onError` | `#FFFFFF` |
| `errorContainer` | `#FFDAD6` |
| `onErrorContainer` | `#93000A` |
| `surfaceVariant` | `#F2DFD1` |
| `inverseSurface` | `#392E25` |
| `onInverseSurface` | `#FFEEE1` |
| `inversePrimary` | `#FFB3AC` |
| `surfaceTint` | `#BA1A20` |

- `#D32F2F` adalah `primaryContainer`, bukan CTA default.
- Jangan memakai putih di `secondaryContainer #FD6C00`; gunakan
  `onSecondaryContainer #562000`.
- `outline` hanya untuk border/icon, bukan body text.

### 2.2 Radius & spacing

- `AppRadius`: `sm 4`, `base 8`, `md 12`, `lg 16`, `xl 24`, `full 9999`.
- `AppSpacing`: `xs 4`, `sm 8`, `md 12`, `lg 16`, `xl 24`.
- `margin 16`, `marginMd 24`, `marginLg 32`, `gutter 16`, `gutterSm 12`.
- Gunakan token ini di `ThemeExtension`; jangan hardcode di widget.
- Tombol teks bersifat **content-sized**: padding horizontal/vertikal, tanpa
  `height`/`width` tetap. Full width hanya lewat `expand: true`.
- Hit target tombol tetap 48 lewat `MaterialTapTargetSize.padded`.
- Icon tombol default di kiri; gunakan `iconPosition: trailing` jika desain
  menaruh arrow di kanan (mis. CTA hero).
- Grid Cemilan hanya aktif di lebar ≥360 dan text scale ≤1.25; selain itu
  fallback ke list horizontal agar tidak overflow.
- Pada `AppDishCard`, harga berada di kolom teks. Jika text scale >1.5,
  pindahkan baris harga ke full-width di bawah gambar agar tidak bertabrakan.
- Halaman detail dengan CTA bawah memakai `Scaffold.bottomNavigationBar` agar
  konten tidak tertutup; jangan menaruh bar fixed manual di atas list.
- Feedback sukses detail memakai toast `motion.toast` (2,4 detik), bukan delay
  hardcoded.

---

## 3. Riverpod — UI-only

- Gunakan `flutter_riverpod` untuk state UI; bukan untuk backend.
- `Provider` hanya untuk dependency UI ringan atau state layar.
- **DILARANG** membuat provider repository/API/database.
- **DILARANG** memakai `FutureProvider`/`StreamProvider` untuk simulasi backend.
- `NotifierProvider`/`AsyncNotifierProvider` hanya untuk state layar.
- `ref.watch` di build; `ref.read` di callback.
- Provider screen-scoped memakai `autoDispose`; app-wide baru keep-alive.
- Jangan menaruh `BuildContext` atau navigasi di provider.
- Jangan membungkus semua state UI ke provider; state ephemeral boleh lokal.
- Test provider memakai `ProviderScope` override.

---

## 4. go_router

- Router di `lib/app/router/app_router.dart`.
- Path/name constants di `lib/app/router/app_routes.dart`.
- Gunakan `context.go`/`context.push`, bukan `Navigator.push` untuk route normal.
- `ShellRoute` atau `StatefulShellRoute.indexedStack` untuk bottom navigation.
- Parameter route harus terketik; jangan hardcode path string di widget.
- Belum ada auth; **DILARANG** membuat guard/redirect palsu.
- Dialog dan bottom sheet tetap boleh `showDialog`/`showModalBottomSheet`.
- Jangan membuat route yang belum dipakai.
- Jangan memakai web URL strategy atau fitur browser.

---

## 5. Layout & responsive handphone

- Target: Android/iOS handphone, portrait utama, landscape robustness.
- Posisi absolut Figma/Stitch bukan layout Flutter.
- Gunakan `Row`, `Column`, `Wrap`, `Stack`, `Flexible`, `Expanded`,
  `LayoutBuilder`, `AspectRatio`, dan `ConstrainedBox`.
- `Positioned` hanya untuk overlay yang memang perlu.
- List panjang memakai `ListView.builder` atau slivers, bukan `Column` berisi
  banyak item.
- Gunakan `SafeArea` dan pastikan keyboard tidak menutup field penting.
- Frame acuan: 390 dp; range 320–430 dp.
- Jika berjalan di layar >600 dp (tablet/foldable), bungkus konten dengan max
  width dan center; jangan membuat layout tablet khusus.
- Bottom nav 3 item (Beranda, Pesanan, Profil); sticky order bar di atas nav.
- Sticky bar/sheet minimal 16 px di atas system navigation.
- **DILARANG** `NavigationRail` atau shell desktop.
- **DILARANG** membuat hover state, mouse cursor, right-click, atau shortcut
  desktop.
- Gunakan `MediaQuery.sizeOf`, `paddingOf`, `textScalerOf`; hindari
  `MediaQuery.of(context)` yang luas.
- Uji 320, 360, 390, 412, 430, landscape phone, dan text scale 2.0.

---

## 6. Typography — Plus Jakarta Sans

- Font brand: **Plus Jakarta Sans**. Bundle weight 400, 600, 700, 800.
- Jangan memakai Roboto/SF Pro sebagai font utama. `google_fonts` hanya dengan
  persetujuan; utamakan font yang dibundel.
- Map ke `TextTheme` (handphone memakai varian mobile):

| TextTheme | Size/Height | Weight | Letter spacing |
| --- | --- | --- | --- |
| `displayLarge` | 30/36 | 800 | -0.02em |
| `headlineLarge` | 22/28 | 700 | -0.01em |
| `headlineMedium` | 20/26 | 700 | 0 |
| `titleLarge` | 18/24 | 700 | 0 |
| `titleMedium` | 16/22 | 600 | 0 |
| `bodyLarge` | 16/24 | 400 | 0 |
| `bodyMedium` | 14/20 | 400 | 0 |
| `bodySmall` | 12/16 | 400 | 0 |
| `labelLarge` | 14/18 | 700 | 0.01em |
| `labelMedium` | 12/16 | 700 | 0.02em |
| `labelSmall` | 11/14 | 600 | 0.03em |
| `priceDisplay` (custom) | 18/22 | 800 | -0.01em |

- `priceDisplay` bukan `TextTheme` standar; taruh di `ThemeExtension` atau
  `AppTextStyles`.
- Konversi line-height: `height = lineHeightPx / fontSizePx`.
- Konversi letter-spacing em: `fontSize * em`.
- Jangan memakai `text-[...]` arbitrary dari HTML Stitch; map ke style terdekat.

---

## 7. Remote image & icon

- **DILARANG** menyimpan gambar desain di `assets/`.
- **DILARANG** `Image.asset` untuk gambar desain; gunakan `AppNetworkImage`.
- Jangan mendeklarasikan gambar desain di `pubspec.yaml`.
- **DILARANG** download image fill Figma/Stitch atau memakai URL temporary dari
  HTML Stitch.
- Semua gambar desain memakai HTTPS remote URL yang stabil.
- Jangan memakai `source.unsplash.com`; gunakan direct URL yang stabil.
- **DILARANG** memakai `lh3.googleusercontent.com/aida-public/...` dari Stitch.
- Logo memakai wordmark “Seblak Lokuak” + icon, bukan foto acak.
- Profile memakai Pravatar/inisial; food photo memakai curated Unsplash,
  fallback Picsum.
- URL terpusat di `lib/core/constants/remote_images.dart`.
- Gunakan `AppNetworkImage` di `lib/core/ui/app_network_image.dart`; jangan sebar
  `Image.network` di widget fitur.
- Setiap gambar wajib punya `fit`, `loadingBuilder`, `errorBuilder`, dan
  `semanticLabel`.
- URL harus deterministik per item (seed dari ID/slug).
- Konten gambar tidak perlu sama persis; pertahankan aspect ratio, crop, dan
  peran visualnya.
- Sumber: curated Unsplash (fallback Picsum) untuk foto, Pravatar untuk avatar,
  Placehold.co untuk placeholder netral/ilustrasi.
- Avatar wajib punya fallback inisial jika gambar gagal.
- Logo/brand memakai Material Icon atau teks/inisial, bukan foto acak.
- Stitch memakai Material Symbols Outlined; di Flutter pakai Material Icons
  terdekat atau package `material_symbols_icons` dengan persetujuan.
- Jangan mengganti icon dengan gambar remote.
- `cached_network_image` hanya jika disetujui; `Image.network` cukup untuk
  prototype.
- Android release: pastikan izin `INTERNET`. iOS: gunakan HTTPS.
- Jangan menaruh base64 di kode.
- Asset platform (launcher icon/splash) tetap boleh; itu bukan gambar desain.
- Screenshot desain di `docs/design/refs/` hanya referensi QA, bukan asset
  aplikasi.

---

## 8. State, form, dan interaksi

- Implementasikan semua state yang terlihat di desain dan state sistem
  (loading/error/empty).
- Form: validasi, `keyboardType`, `textInputAction`, `autofillHints`,
  `obscureText`, error text, focus order, dan dispose controller.
- Jangan menambahkan delay palsu atau TODO di kode produksi.
- Jangan mengarang perilaku yang tidak diminta; jika desain tidak jelas, tanya.
- Pastikan semua tombol/navigasi yang terlihat benar-benar berfungsi.

---

## 9. Accessibility

- Target sentuh minimal 48×48; naikkan 44 px dari HTML Stitch.
- Kontras minimal 4.5:1 untuk teks normal.
- Jangan memakai putih di `secondaryContainer #FD6C00` (2.87:1); gunakan
  `onSecondaryContainer #562000` (4.57:1).
- `outline #8F6F6C` hanya border/icon, bukan body text.
- Gunakan `Semantics` untuk icon-only button dan gambar.
- Gunakan `ExcludeSemantics` untuk elemen dekoratif.
- Hormati text scaling dan `disableAnimations`.
- Jangan mengandalkan warna saja untuk menyampaikan status.
- Uji dengan TalkBack/VoiceOver jika memungkinkan.

---

## 10. Performance

- Gunakan `const` jika memungkinkan.
- Gunakan builder untuk list/grid.
- Dispose controller, animation, dan listener.
- Jangan melakukan pekerjaan berat di `build`.
- Jangan meninggalkan `debugPrint` atau log sensitif.
- `RepaintBoundary` hanya jika ada masalah repaint nyata.

---

## 11. Testing

- `dart format .` dan `flutter analyze` wajib bersih.
- `flutter test` wajib pass.
- Verifikasi visual di HP fisik pengguna via USB debugging
  (`flutter run -d <device-id>`) + screenshot. **JANGAN** menyalakan emulator
  Android tanpa izin eksplisit pengguna.
- `flutter run` sudah build + install + launch; **JANGAN** `flutter build apk`
  untuk iterasi rutin.
- Iterasi UI memakai hot reload `r` / hot restart `R`.
- Widget test untuk shared widget, state penting, dan layout 320–430.
- Test `AppNetworkImage` tanpa network (loading/error/fallback).
- Jangan menambah package mock network tanpa persetujuan.
- Gunakan viewport handphone, misalnya 390×844, di widget test.
- Golden test hanya jika repo sudah memakainya.
- Jangan melemahkan lint atau mengabaikan warning untuk membuat kode "lulus".

---

## 12. Mock data & batas backend

- Mock data disimpan di `features/<fitur>/presentation/mock/` atau `shared/mock/`.
- File mock wajib diawali `// MOCK ONLY — hapus saat backend tersedia.`
- Mock hanya list/map in-memory; tidak ada persistence.
- **DILARANG** membuat `fromJson`/`toJson`, schema, migration, SQL, atau API
  contract.
- Jika UI butuh data, pakai mock langsung; jangan membuat repository palsu.
- Jangan memakai `Future.delayed` untuk simulasi loading.
- Jangan menambahkan package database/backend tanpa persetujuan.

---

## 13. Scope & safety

- Jangan mengedit `build/`, `android/`, atau `ios/` kecuali task memang
  membutuhkannya.
- Jangan melakukan refactor atau rename file yang tidak terkait.
- Jangan melakukan mass formatting.
- Jangan menulis secret, API key, atau token ke kode/log.
- Tanya sebelum menjalankan perintah destruktif atau upgrade dependency.
- Jangan commit kecuali diminta.
