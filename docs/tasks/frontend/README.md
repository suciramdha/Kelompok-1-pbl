# Tasks Frontend — Seblak Lokuak

> Lembar kerja per halaman untuk prototype frontend.
> Dokumen ini bukan design system dan bukan aturan global.

**Scope:** frontend-only. Tidak ada database, backend, API, auth, atau schema.
**Platform:** Android/iOS handphone saja.

---

## Dokumen acuan

| Dokumen | Isi |
| --- | --- |
| [`AGENTS.md`](../../../AGENTS.md) | Kontrak kerja, aturan non-negosiabel, DoD |
| [`docs/rules/design-to-code.md`](../../rules/design-to-code.md) | Gate 1–7 dan verifikasi |
| [`docs/rules/flutter.md`](../../rules/flutter.md) | Aturan implementasi Flutter |
| [`docs/rules/reuse.md`](../../rules/reuse.md) | Reuse/compose/extend/create |
| [`docs/design/DESIGN.md`](../../design/DESIGN.md) | Token dan spesifikasi visual canonical |
| [`docs/design/components.md`](../../design/components.md) | Registry komponen + screen inventory |
| [`docs/design/stitch-theme-audit.md`](../../design/stitch-theme-audit.md) | Audit theme Stitch dan drift |

Screen ID dan status desain Stitch ada di `docs/design/components.md` §1.
Jangan menduplikasi daftar itu di sini.

---

## Isi folder

| File | Isi |
| --- | --- |
| [`_template.md`](_template.md) | Template kerja untuk satu halaman |
| [`beranda.md`](beranda.md) | Beranda (`/home`) |
| [`detail-menu.md`](detail-menu.md) | Detail Menu (`/menu/:id`) |
| [`kustomisasi-menu.md`](kustomisasi-menu.md) | Kustomisasi Menu (`/menu/:id/customize`) |
| [`keranjang.md`](keranjang.md) | Keranjang & Checkout (`/cart`) |
| [`profil.md`](profil.md) | Profil (`/profile`) |
| [`edit-profil.md`](edit-profil.md) | Edit Profil (`/profile/edit`) |

Halaman lain dibuat saat halaman tersebut mulai dikerjakan, bukan sebagai file
kosong.

---

## Daftar halaman

| Halaman | Route | Status | Dokumen |
| --- | --- | --- | --- |
| Beranda | `/home` | `done` | [`beranda.md`](beranda.md) |
| Detail Menu | `/menu/:id` | `done` | [`detail-menu.md`](detail-menu.md) |
| Kustomisasi Menu | `/menu/:id/customize` | `done` | [`kustomisasi-menu.md`](kustomisasi-menu.md) |
| Keranjang & Checkout | `/cart` | `done` | [`keranjang.md`](keranjang.md) |
| Status Pesanan | `/orders/:id/tracking` | `todo` | `pelacakan-pesanan.md` (belum dibuat) |
| Pesanan | `/orders` | `todo` | `pesanan.md` (belum dibuat) |
| Profil | `/profile` | `done` | [`profil.md`](profil.md) |
| Edit Profil | `/profile/edit` | `in-progress` | [`edit-profil.md`](edit-profil.md) |

Nama file di atas adalah rencana. File baru dibuat saat halaman mulai
dikerjakan, bukan sebagai dokumen kosong.

Screen hidden legacy **tidak** masuk daftar kerja.

### Arti status

| Status | Arti |
| --- | --- |
| `todo` | Belum dikerjakan; masih placeholder atau belum ada |
| `in-progress` | Sedang diimplementasikan atau direvisi |
| `blocked` | Menunggu keputusan, desain, atau dependency |
| `done` | Implementasi dan verifikasi utama lulus; follow-up dicatat |

---

## Kapan dokumen halaman dibuat

1. Selesaikan Gate 1–2 untuk halaman tersebut.
2. Isi inventory Gate 3 dan component map Gate 4 dari Stitch + kode aktual.
3. Salin `_template.md` menjadi `{nama-halaman}.md`.
4. Implementasikan halaman (Gate 5).
5. Perbarui status, acceptance, dan verifikasi di perubahan yang sama.

Untuk halaman yang sudah selesai seperti Beranda, isi dokumen dari kode aktual,
bukan dari ingatan atau asumsi.

---

## Aturan isi

- Satu halaman satu file; nama file kebab-case Indonesia.
- Taut ke `DESIGN.md` dan `components.md`; **jangan menyalin** nilai token.
- Taut ke `AGENTS.md` dan `docs/rules/*`; **jangan menyalin** aturan.
- Jangan mengarang section, state, copy, atau gambar. Tulis `TBD` dan tanyakan.
- Mock wajib ditandai `// MOCK ONLY` di kode dan dicatat di dokumen.
- Tidak ada layer `data/`/`domain/`, repository, atau schema.
- Dokumen ini tidak menggantikan laporan Gate 7.
- Jika `TASKS.md` dibuat, isi hanya index global; detail per halaman tetap di
  folder ini.

---

## Urutan pengerjaan yang disarankan

1. Beranda — selesai.
2. Detail Menu — selesai.
3. Kustomisasi Menu.
4. Keranjang & Checkout.
5. Status Pesanan.
6. Pesanan.
7. Profil.

Urutan 3–5 mengikuti alur pemesanan. Pesanan dan Profil boleh ditukar jika
prioritas produk berubah.

---

## Verifikasi minimum per halaman

```bash
dart format .
flutter analyze
flutter test
flutter run -d <device-id>
```

`flutter run` dijalankan di HP fisik pengguna via USB debugging. **JANGAN**
menyalakan emulator Android tanpa izin eksplisit pengguna. Jangan memakai
`flutter build apk` untuk verifikasi rutin.

Matriks layout dan checklist lengkap ada di
[`docs/rules/design-to-code.md`](../../rules/design-to-code.md) Gate 6.
Layout 320–430 dan text scale 2.0 dicek lewat widget test; visual akhir di HP
fisik. Pastikan gambar remote dan fallback tampil.

---

## Perubahan

Changelog tunggal proyek. Hanya mencatat milestone; revisi konten diperbarui di
tempat.

| Tanggal | Perubahan |
| --- | --- |
| 2026-11-21 | Setup awal: struktur docs, template halaman, komponen inti, dan Beranda |
| 2026-11-21 | Baseline Material 3 sementara |
| 2026-11-21 | Frontend-only + kebijakan remote image + `AppNetworkImage` |
| 2026-11-21 | Dokumen dipindah ke `docs/design` dan dipangkas |
| 2026-11-21 | Theme Seblak Lokuak dari audit Stitch + screen inventory |
| 2026-11-21 | Fondasi UI + Beranda (hero, grid Cemilan, kartu tap-only) |
| 2026-11-21 | Detail Menu Mie Rawit (hero, spice, topping, note, bottom bar) + verifikasi |
| 2026-11-22 | Semua menu (kecuali Seblak Prasmanan) membuka Detail Menu |
| 2026-11-22 | Kustomisasi Seblak Prasmanan diimplementasikan: kuah, pedas, topping, catatan, bottom bar, route guard |
| 2026-11-22 | Counter qty tanpa background + hit target 32 (Flutter) + harga/tombol + satu parent di Kustomisasi; label Total Racikan diperbesar |
| 2026-11-22 | Validasi racikan wajib tanpa default selection (kuah/pedas/suhu) + minimal 1 topping di Kustomisasi |
| 2026-11-22 | Profil diimplementasikan (kartu akun ringkas, favorit, Preferensi, Lainnya, toggle notifikasi) + revisi Stitch |
| 2026-11-22 | Keranjang & Checkout diimplementasikan (line item, alamat, catatan driver, pembayaran, ringkasan, sticky checkout) + revisi Stitch |
| 2026-11-22 | Keranjang: tombol `−` pada qty 1 membuka dialog konfirmasi hapus item |
| 2026-11-22 | Keranjang: catatan item dapat diedit lewat drawer textarea borderless (Flutter) |
| 2026-11-24 | Edit Profil diimplementasikan: route `/profile/edit`, form identitas + validasi, kartu alamat, `AppTextField`/`AppBadge`, state profil in-memory |
| 2026-11-24 | Keranjang dimulai kosong: seed item dihapus; Home sticky bar mengikuti state kosong |
