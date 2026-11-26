# Audit Theme Stitch — Seblak Lokuak

> Audit ini mencatat kondisi nyata theme Stitch per 2026-11-21.
> Sumber: Stitch MCP `get_project`, `list_screens`, `list_design_systems`,
> `download_file` (HTML screen).

**Status:** dokumen audit, bukan design system canonical.
Canonical ada di `docs/design/DESIGN.md`.

---

## 1. Metadata

| Item | Nilai |
| --- | --- |
| Project | `projects/17496044663583378114` |
| Judul | Aplikasi Delivery UMKM Seblak Lokuak |
| Tipe | `TEXT_TO_UI_PRO` |
| Device | `MOBILE` |
| Design system | **Seblak Lokuak** |
| Asset ID | `assets/70cd384c0c9e4ec7916963fa66aeca50` |
| Versi design system | 2 |
| Theme mode | `LIGHT` |
| Color variant | `FIDELITY` |
| Seed color | `#D32F2F` |
| Font | Plus Jakarta Sans |
| Roundness | `ROUND_EIGHT` |
| Canvas width | 390 dp |
| Screenshot width | 780 px (2x) |
| Terakhir update | 2026-11-21 06:38 UTC |

---

## 2. Screen inventory

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

**Jangan implementasikan** screen hidden legacy.

---

## 3. Token theme aktual

### Colors

- Primary: `#AF101A`
- Primary container: `#D32F2F`
- Secondary: `#9F4200`
- Secondary container: `#FD6C00`
- Tertiary: `#7D4C00`
- Tertiary container: `#9F6200`
- Background/surface: `#FFF8F5`
- On-surface: `#231A11`
- On-surface-variant: `#5B403D`
- Surface container low: `#FFF1E8`
- Surface container: `#FEEADC`
- Surface container high: `#F8E5D6`
- Surface container highest: `#F2DFD1`
- Surface container lowest: `#FFFFFF`
- Outline: `#8F6F6C`
- Outline variant: `#E4BEBA`
- Error: `#BA1A1A`
- Neutral/shadow: `#2B2118`

### Typography

- Semua Plus Jakarta Sans.
- `display-lg` 40/48 800; mobile 30/36 800.
- `headline-lg` 28/36 700; mobile 22/28 700.
- `headline-md` 20/26 700.
- `title-lg` 18/24 700; `title-md` 16/22 600.
- `body-lg` 16/24; `body-md` 14/20; `body-sm` 12/16.
- `label-lg` 14/18 700; `label-md` 12/16 700; `label-sm` 11/14 600.
- `price-display` 18/22 800.

### Radius & spacing

- Radius: `sm 4`, `DEFAULT 8`, `md 12`, `lg 16`, `xl 24`, `full 9999`.
- Spacing: `xs 4`, `sm 8`, `md 12`, `lg 16`, `xl 24`.
- Margin: `16`, `24`, `32`; gutter: `16`, `12`.

---

## 4. Drift yang ditemukan

### 4.1 Nama legacy

- Project dan design system: **Seblak Lokuak**.
- `designMd` masih `name: Warung Pedas Express`.
- Judul screen Beranda masih `Beranda Warung Pedas Express`.
- Ada screen hidden `Warung Pedas Express Food Ordering`.
- Konten UI sudah memakai **Seblak Lokuak**.

**Keputusan:** canonical `Seblak Lokuak`; nama lama legacy.

### 4.2 Warna designMd vs token

| Peran | designMd | Token aktual | Catatan |
| --- | --- | --- | --- |
| Primary | `#D32F2F` | `#AF101A` | HTML `bg-primary` = `#AF101A` |
| Primary container | — | `#D32F2F` | Container role |
| Secondary | `#FF6D00` | `#9F4200` | `#FD6C00` = secondary container |
| Tertiary | `#FFA000` | `#7D4C00` | `#9F6200` = tertiary container |
| Neutral text | `#2B2118` | `on-surface #231A11` | `#2B2118` = shadow/neutral |
| Canvas | `#FDFBF7` | `#FFF8F5` | Aktual lebih warm |
| Surface | `#FFFDF9` | `#FFF8F5` | Sama dengan background |

**Keputusan:** token `namedColors` adalah canonical; narasi designMd hanya
referensi brand.

### 4.3 Radius HTML

- Design token: `DEFAULT 8`, `md 12`, `lg 16`, `xl 24`.
- Tailwind config HTML: `DEFAULT 4`, `lg 8`, `xl 12`.
- `rounded-xl` di HTML = 12px, bukan 24px.
- `rounded-lg` di HTML = 8px, bukan 16px.

**Keputusan:** implementasi Flutter memakai token di `DESIGN.md`, bukan class
Tailwind HTML.

### 4.4 Typography & spacing docs

Docs sebelumnya masih baseline Roboto dan spacing 4/8/16/24/32/48. Theme aktual
memakai Plus Jakarta Sans dan spacing 4/8/12/16/24 + margin/gutter. Semua sudah
harus diganti.

### 4.5 Light-only

Stitch hanya `LIGHT`; tidak ada dark palette.
**Keputusan:** light-only dulu. Jangan mengarang dark mode.

### 4.6 HTML bukan kode final

- Ada `hover:` 2–16 kali per screen → abaikan untuk mobile.
- Ada `text-[10px]` sampai `text-[32px]` → map ke type token.
- Ada `min-h-[44px]`/`w-11 h-11` → naikkan hit target ke 48.
- Ada `rounded-lg`/`rounded-xl` yang tidak sesuai token → gunakan token.

### 4.7 Design system components kosong

`designTheme.components` null dan manifest `components` kosong. Registry
komponen harus dibangun manual dari `designMd` + HTML + screen.

---

## 5. Accessibility

| Pair | Contrast | Status |
| --- | --- | --- |
| `#FFFFFF` on `#AF101A` | 7.21:1 | lulus |
| `#FFFFFF` on `#D32F2F` | 4.98:1 | lulus |
| `#231A11` on `#FFF8F5` | 16.29:1 | lulus |
| `#5B403D` on `#FFF8F5` | 8.91:1 | lulus |
| `#562000` on `#FD6C00` | 4.57:1 | lulus |
| `#FFFFFF` on `#FD6C00` | 2.87:1 | **gagal** |
| `#8F6F6C` on `#FFF8F5` | 4.29:1 | border/icon only |

**Aturan:** jangan memakai putih di `#FD6C00`; gunakan `on-secondary-container
#562000` atau background yang lebih gelap. `outline` hanya untuk border/icon,
bukan body text.

---

## 6. Image & icon

- Beranda memuat 21 gambar `lh3.googleusercontent.com/aida-public/...`.
- Detail Menu memuat 1 gambar besar.
- Logo, profile, dan food photos memakai URL sementara Stitch.
- Material Symbols Outlined dipakai untuk icon.

**Keputusan:** ganti dengan remote placeholder `RemoteImages`; logo memakai
wordmark/icon, profile Pravatar/inisial, food curated Unsplash/Picsum fallback.

---

## 7. Follow-up Stitch

Dilakukan nanti, bukan pada update docs ini:

1. Rename `designMd` dari `Warung Pedas Express` menjadi `Seblak Lokuak`.
2. Selaraskan hex narasi designMd dengan token aktual.
3. Perbaiki Tailwind radius config agar sama dengan design token.
4. Hapus/abaikan screen hidden legacy.
5. Pertimbangkan mengganti badge putih-di-orange dengan `on-secondary-container`.
6. Isi `components` di design system jika ingin token komponen terstruktur.
