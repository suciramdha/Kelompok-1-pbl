# Reuse & Componentization

> Dipakai saat membuat, memecah, memindahkan, atau menghapus widget.
> Tujuannya: reuse sebelum create, tanpa membuat abstraksi prematur.

**Dokumen terkait:**

- `docs/design/components.md` — registry komponen
- `docs/rules/flutter.md` — aturan implementasi
- `docs/rules/design-to-code.md` — workflow desain

---

## 1. Prinsip

- **Reuse > compose > extend > create.**
- Cek registry dan kode existing sebelum membuat widget baru.
- Jangan membuat widget reusable untuk satu pemakaian.
- Jangan membuat "design system" spekulatif untuk screen yang belum ada.
- Jangan menduplikasi komponen yang sudah ada.

---

## 2. Layer & lokasi

| Layer | Contoh | Lokasi | Kapan dibuat |
| --- | --- | --- | --- |
| Design token | color, type, spacing, radius, elevation, motion | `lib/app/theme/` | Selalu, sebelum screen |
| Primitive | `AppButton`, `AppTextField`, `AppBadge`, `AppNetworkImage` | `lib/core/ui/` | Komponen dasar design system atau dipakai ≥2 kali |
| Composite | `ProductCard`, `SectionHeader`, `EmptyState` | `lib/shared/widgets/` atau feature | Gabungan ≥2 primitive, reusable, atau >80 baris |
| Feature widget | `CartItemTile`, `CheckoutSummary` | `features/<fitur>/presentation/widgets/` | Khusus satu fitur |
| Screen/page | `HomePage`, `CheckoutPage` | `features/<fitur>/presentation/pages/` | Satu route; hanya komposisi |
| Template | `AppScaffold`, `ResponsivePage` | `lib/core/layout/` | ≥2 screen berbagi struktur |

`ResponsivePage` hanya untuk handphone: max width dan padding, bukan layout
tablet/desktop.

---

## 3. Kapan mengekstrak widget

**Ekstrak** jika salah satu benar:

- Dipakai di ≥2 tempat, atau jelas akan dipakai ulang.
- Lebih dari ±80 baris.
- Punya controller, animation, gesture, atau state sendiri.
- Perlu test/preview terpisah.
- Merupakan komponen bernama di design system.

**Biarkan private `_Widget`** jika:

- Hanya dipakai di satu screen.
- Kurang dari ±80 baris.
- Tidak punya state/logic sendiri.
- Hanya perekat layout.

Aturan tambahan:

- Jangan mengekstrak hanya untuk mengurangi jumlah baris.
- Jangan membuat god widget yang menangani seluruh screen.
- Jangan membuat `CommonWidgets`/`UtilsWidget` sebagai tempat sampah.
- Jika satu screen mulai >200 baris, pecah berdasarkan section yang punya
  tanggung jawab jelas, bukan berdasarkan jumlah baris semata.

---

## 4. API widget reusable

- `const` constructor dan `super.key`.
- Data wajib = `required`; style/callback = optional.
- Varian memakai `enum` atau sealed class, bukan banyak boolean.
- Gunakan slot (`child`, `leading`, `trailing`, `footer`) untuk konten fleksibel.
- Jangan menyimpan `BuildContext`.
- Jangan menaruh API/business call, logic, atau navigasi di widget shared.
- Jangan membaca provider global dari primitive; terima data.
- Dokumentasikan parameter non-obvious dengan `///`.
- Widget shared wajib punya test/preview.

---

## 5. Promosi feature widget

Feature widget dipromosikan ke `shared/` hanya setelah dipakai ≥2 fitur.

Langkah:

1. Pastikan benar-benar dipakai di fitur kedua.
2. Pindahkan file ke lokasi shared yang sesuai.
3. Update semua import.
4. Update `docs/design/components.md`.
5. Pastikan test/preview tetap ada.
6. Jangan meninggalkan salinan lama.

---

## 6. Anti-pattern

- Widget reusable yang hanya dipakai sekali.
- Boolean soup: `isPrimary`, `isSecondary`, `isSmall`, `isLarge`.
- Hardcode style di widget yang seharusnya menerima theme.
- Duplikasi komponen yang sudah ada di registry.
- Menaruh business logic atau navigasi di widget shared.
- Membuat layer `data/`/`domain/` atau repository untuk widget.

---

## 7. Update registry

Setiap widget reusable baru/berubah wajib dicatat di
`docs/design/components.md`:

- Nama komponen desain.
- Sumber (Figma/Stitch/TBD).
- Widget Flutter.
- Path.
- Varian.
- Status: `ada`, `rencana`, atau `tidak dipakai`.
- Catatan singkat.

Jika komponen dihapus, ubah status menjadi `tidak dipakai` dan jelaskan.
