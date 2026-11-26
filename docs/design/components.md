# Registry Komponen Flutter — Seblak Lokuak

> Baca file ini sebelum membuat widget baru. Aturan reuse ada di
> `docs/rules/reuse.md`; aturan implementasi ada di `docs/rules/flutter.md`.
> Theme canonical ada di `docs/design/DESIGN.md`.

**Platform:** Android/iOS handphone only. Tidak ada web, desktop, atau layout
tablet khusus. Tidak ada komponen hover/mouse/desktop navigation.

**Gambar:** remote URL (curated Unsplash/Picsum fallback, Pravatar, Placehold);
tidak ada asset lokal untuk gambar desain. Jangan memakai URL
`lh3.googleusercontent.com/aida-public/...`.

**Status:** `ada` = sudah dibuat, `rencana` = belum dibuat, `tidak dipakai` =
sengaja tidak digunakan.

---

## 1. Screen inventory

| Screen | Screen ID | Route usulan | Status |
| --- | --- | --- | --- |
| Beranda | `54c4f90aaeed4c4bb07def3ad1d3b0c5` | `/home` | active |
| Detail Menu - Mie Rawit Hijau | `4d0cd885dbc347b5ad311319c5315786` | `/menu/:id` | active |
| Kustomisasi Seblak Prasmanan | `680464cfe0ee49968995424276b050be` | `/menu/:id/customize` | active |
| Keranjang & Checkout Delivery | `bf1c60ee794b45788adcd987f8f81168` | `/cart` | active |
| Status Pesanan & Pelacakan Live | `788bf895ca3b4ee6a023e64146d3e621` | `/orders/:id/tracking` | active |
| Riwayat Pesanan | `c60bf40707b647c783bdaf626116aa1f` | `/orders` | active |
| Profil Pengguna & Pengaturan Akun | `a72f939cff8c40baa006a93c868fe84b` | `/profile` | active |
| Edit Profil Pengguna | `9da500fabcac4eac9947a449383b3616` | `/profile/edit` | active |
| Warung Pedas Express Food Ordering | `a74e6a7b08804e1e933592c3e57e3e24` | — | hidden legacy |

**Jangan implementasikan** screen hidden legacy.

---

## 2. Komponen inti

| Komponen desain | Sumber | Widget Flutter | Path | Varian | Status | Catatan |
| --- | --- | --- | --- | --- | --- | --- |
| Button / Primary | Stitch | `AppButton` | `lib/core/ui/app_button.dart` | primary, secondary, neutral, onBrand, ghost, danger | ada | content-sized + padding; hit target 48; icon leading/trailing; `labelMaxLines` untuk CTA 2 baris |
| Text field | Stitch | `AppTextField` | `lib/core/ui/app_text_field.dart` | default, error, read-only, disabled | ada | Label + trailing slot, leading icon, validator, helper, focus/error; counter tersembunyi saat `maxLength` |
| Card/container | Stitch | `AppCard` | `lib/core/ui/app_card.dart` | elevated, outlined, filled | rencana | Radius/elevation theme |
| Badge/chip | Stitch | `AppBadge` | `lib/core/ui/app_badge.dart` | neutral, brand, success, secondary, danger | ada | Pill; `label-small`; ikon opsional 14; tanpa putih di `secondary-container` |
| App scaffold | Stitch | `AppScaffold` | `lib/core/layout/app_scaffold.dart` | default, with-bottom-nav | rencana | SafeArea, app bar, bottom nav |
| Empty state | Stitch | `AppEmptyState` | `lib/shared/widgets/app_empty_state.dart` | default | ada | Icon, judul, pesan, CTA; dipakai Keranjang |
| Error state | Stitch | `AppErrorState` | `lib/shared/widgets/app_error_state.dart` | inline, full-screen | rencana | Pesan + retry |
| Loading state | Stitch | `AppLoadingState` | `lib/shared/widgets/app_loading_state.dart` | spinner, skeleton | rencana | Tanpa delay palsu |
| Bottom navigation | Stitch | `AppBottomNav` | `lib/core/layout/app_bottom_nav.dart` | Beranda/Pesanan/Profil | ada | 3 item; hit target 48 |
| Add button | Stitch | `AppAddButton` | `lib/core/ui/app_add_button.dart` | circle 48 | ada | Default visual/hit 48; di Kustomisasi dipakai 32/32 untuk tombol + collapsed |
| Remote image | RemoteImages | `AppNetworkImage` | `lib/core/ui/app_network_image.dart` | thumbnail, hero, avatar | ada | loading/error/fallback + semanticLabel |
| Section header | Stitch | `AppSectionHeader` | `lib/core/ui/app_section_header.dart` | required, optional | ada | Aksen bar 8×20, judul, pill, deskripsi; badge turun di text scale >1.5 |
| Option card | Stitch | `AppOptionCard` | `lib/core/ui/app_option_card.dart` | selected, unselected | ada | Radio ring + dot; tag; trailing label; dipakai Kuah |

---

## 3. Komponen khas Seblak Lokuak

| Komponen desain | Widget Flutter | Path | Status | Catatan |
| --- | --- | --- | --- | --- |
| Sticky order bar | `AppStickyOrderBar` | `lib/core/layout/app_sticky_order_bar.dart` | ada | Total, harga, CTA `Lihat Pesanan`; translusen + blur |
| Dish card | `AppDishCard` | `lib/shared/widgets/app_dish_card.dart` | ada | Thumbnail 96×96; tap seluruh kartu ke Detail Menu; tanpa `+`; fallback full-width saat text scale >1.5 |
| Dish grid card | `AppDishGridCard` | `lib/shared/widgets/app_dish_grid_card.dart` | ada | Grid 2 kolom; gambar atas; tap seluruh kartu ke Detail Menu; tanpa `+` |
| Warung card | `AppWarungCard` | `lib/shared/widgets/app_warung_card.dart` | rencana | Hero 16:9; rating, jarak, minimum order |
| Spice level badge | `AppSpiceLevelBadge` | `lib/core/ui/app_spice_level_badge.dart` | ada | Level 0–5; gradient token |
| Category chip | `AppCategoryChip` | `lib/core/ui/app_category_chip.dart` | ada | Pill; selected `secondary-container` |
| UMKM badge | `AppUmkmBadge` | `lib/core/ui/app_umkm_badge.dart` | ada | `secondary-fixed`; catatan drift |
| Quantity stepper | `AppQuantityStepper` | `lib/core/ui/app_quantity_stepper.dart` | ada | Tanpa background; tombol 32/ikon 16; hit target 32 (Flutter, disetujui); `min`/`max`; `collapseAtMin`; `emphasizeIncrease`; `onDecrementAtMin` + label a11y; dipakai konfirmasi hapus Keranjang |
| Topping tile | `AppToppingTile` | `lib/core/ui/app_topping_tile.dart` | ada | Checkbox 24 + harga; check `on-secondary-container`; row >48 |
| Spice selector | `AppSpiceSelector` | `lib/core/ui/app_spice_selector.dart` | ada | Kartu radio 3 level; tag; tanpa default |
| Temperature selector | `AppTemperatureSelector` | `lib/core/ui/app_temperature_selector.dart` | ada | Radio card Dingin/Panas; tanpa default; hanya Jus Jeruk |
| Note field | `AppNoteField` | `lib/core/ui/app_note_field.dart` | ada | Textarea 120 + counter; focus `secondary-container`; opsi `minLines`/`maxLines`/`showCounter` untuk catatan driver satu baris |
| Order status timeline | `AppOrderStatusTimeline` | `lib/shared/widgets/app_order_status_timeline.dart` | rencana | Tracking; langkah + state |
| Order history card | `AppOrderHistoryCard` | `lib/shared/widgets/app_order_history_card.dart` | rencana | Active/previous; state |

Catatan: tabel ini adalah **rencana**, bukan instruksi membuat semua file
sekarang. Buat komponen saat screen pertama membutuhkannya.

---

## 4. Komponen per fitur

| Fitur | Widget | Path | Status |
| --- | --- | --- | --- |
| home | `HomePage` | `lib/features/home/presentation/pages/home_page.dart` | ada |
| home | `HomeHeader` | `lib/features/home/presentation/widgets/home_header.dart` | ada |
| home | `HeroBanner` | `lib/features/home/presentation/widgets/hero_banner.dart` | ada |
| home | `CategoryFilterBar` | `lib/features/home/presentation/widgets/category_filter_bar.dart` | ada |
| home | `MenuSection` | `lib/features/home/presentation/widgets/menu_section.dart` | ada; `snackGrid` untuk Cemilan |
| home | `FeaturedCard` | `lib/features/home/presentation/widgets/featured_card.dart` | ada |
| menu | `MenuHero` | `lib/features/menu/presentation/widgets/menu_hero.dart` | ada; 4:3 + badge Terlaris kanan atas |
| menu | `MenuInfoSection` | `lib/features/menu/presentation/widgets/menu_info_section.dart` | ada; waktu masak, harga, deskripsi |
| menu | `DetailBottomBar` | `lib/features/menu/presentation/widgets/detail_bottom_bar.dart` | ada; quantity, total, CTA |
| menu | `MenuDetailPage` | `lib/features/menu/presentation/pages/menu_detail_page.dart` | ada; semua menu; item customizable dialihkan router ke Kustomisasi |
| menu | `MenuCustomizePage` | `lib/features/menu/presentation/pages/menu_customize_page.dart` | ada; Seblak Prasmanan |
| menu | `CustomizeInfoSection` | `lib/features/menu/presentation/widgets/customize_info_section.dart` | ada; info tanpa harga |
| menu | `CustomizeSpiceGrid` | `lib/features/menu/presentation/widgets/customize_spice_grid.dart` | ada; 6 level, grid 2 kolom, badge Rekomendasi |
| menu | `CustomizeToppingRow` | `lib/features/menu/presentation/widgets/customize_topping_row.dart` | ada; thumbnail 80×80, harga + stepper dalam satu parent; stacked <300 dp / text scale >1.5 |
| menu | `CustomizeBottomBar` | `lib/features/menu/presentation/widgets/customize_bottom_bar.dart` | ada; ringkasan racikan + total + CTA |
| menu | `CustomizeToast` | `lib/features/menu/presentation/widgets/customize_toast.dart` | ada; feedback tambah racikan |
| cart | `CartPage` | `lib/features/cart/presentation/pages/cart_page.dart` | ada; `/cart`, app bar + 5 section + sticky checkout + empty state |
| cart | `CartCardSurface` | `lib/features/cart/presentation/widgets/cart_section_card.dart` | ada; permukaan kartu putih + border + radius |
| cart | `CartSectionCard` | `lib/features/cart/presentation/widgets/cart_section_card.dart` | ada; header ikon + judul + isi berjarak |
| cart | `CartAddressCard` | `lib/features/cart/presentation/widgets/cart_address_card.dart` | ada; alamat, catatan, badge mitra, `Ubah` |
| cart | `CartItemTile` | `lib/features/cart/presentation/widgets/cart_item_tile.dart` | ada; thumbnail 80, racikan, harga, qty, catatan; tanpa icon hapus; `−` qty 1 memicu dialog konfirmasi; baris catatan membuka drawer |
| cart | `CartItemNoteSheet` | `lib/features/cart/presentation/widgets/cart_item_note_sheet.dart` | ada; bottom sheet edit catatan item, textarea borderless + `Simpan` |
| cart | `DriverNoteCard` | `lib/features/cart/presentation/widgets/driver_note_card.dart` | ada; quick tag multi-select + input driver 120 |
| cart | `PaymentMethodCard` | `lib/features/cart/presentation/widgets/payment_method_card.dart` | ada; QRIS/COD single-select |
| cart | `OrderSummary` | `lib/features/cart/presentation/widgets/order_summary.dart` | ada; subtotal, ongkir, layanan, total |
| cart | `CartCheckoutBar` | `lib/features/cart/presentation/widgets/cart_checkout_bar.dart` | ada; label total besar + CTA `Pesan Sekarang` |
| tracking | `CourierCard` | `lib/features/orders/presentation/widgets/courier_card.dart` | rencana |
| profile | `ProfilePage` | `lib/features/profile/presentation/pages/profile_page.dart` | ada; shell branch 2; membaca `profileProvider` |
| profile | `ProfileHeader` | `lib/features/profile/presentation/widgets/profile_header.dart` | ada; brand mark + bell 48 + avatar 32 |
| profile | `ProfileSummaryCard` | `lib/features/profile/presentation/widgets/profile_summary_card.dart` | ada; kontak 2 baris + banner dukungan |
| profile | `ProfileSectionCard` | `lib/features/profile/presentation/widgets/profile_section_card.dart` | ada; judul + kartu putih + divider inset |
| profile | `PreferenceTile` | `lib/features/profile/presentation/widgets/preference_tile.dart` | ada; ikon 24 tanpa background; tanpa subtitle |
| profile | `EditProfilePage` | `lib/features/profile/presentation/pages/edit_profile_page.dart` | ada; `/profile/edit`, top-level tanpa bottom nav |
| profile | `EditProfileAvatarSection` | `lib/features/profile/presentation/widgets/edit_profile_avatar_section.dart` | ada; avatar 96 + kamera 36/hit 48 + fallback inisial |
| profile | `EditProfileDataCard` | `lib/features/profile/presentation/widgets/edit_profile_data_card.dart` | ada; 5 field, badge status, validasi, ID read-only |
| profile | `EditProfileAddressCard` | `lib/features/profile/presentation/widgets/edit_profile_address_card.dart` | ada; alamat utama + aksi kelola |

---

## 5. Cara update registry

1. Cek tabel dan cari komponen setara.
2. Tentukan layer: primitive, composite shared, feature widget, atau private.
3. Buat file + test/preview jika komponen baru.
4. Update baris: widget, path, varian, status, catatan.
5. Jika API berubah: update semua call site dan test.
6. Jika promosi ke shared: pindahkan file, update import, update tabel.
7. Jika dihapus: ubah status menjadi `tidak dipakai` dan jelaskan.

---

## 6. Aturan gambar

- URL map: `lib/core/constants/remote_images.dart`.
- Foto makanan/hero: curated Unsplash direct URL; fallback Picsum seed.
- Avatar: Pravatar; placeholder: Placehold.co.
- `Image.network` hanya di `AppNetworkImage`.
- Wajib `fit`, `loadingBuilder`, `errorBuilder`, `semanticLabel`.
- URL deterministik; avatar punya fallback inisial.
- Jangan memakai URL Figma/Stitch, `source.unsplash.com`, atau `Image.asset`
  untuk gambar desain.
- Asset platform (launcher/splash) dikecualikan.

---

## 7. Dokumen terkait

- `docs/rules/reuse.md`
- `docs/rules/flutter.md`
- `docs/design/DESIGN.md`
- `docs/design/stitch-theme-audit.md`
- `docs/rules/design-to-code.md`

