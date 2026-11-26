# {Nama Halaman}

> Salin file ini menjadi `{nama-halaman}.md` di folder yang sama.
> Hapus komentar dan baris placeholder yang tidak dipakai.
> Jangan menyalin nilai token dari `DESIGN.md`; tautkan saja.

| Field | Nilai |
| --- | --- |
| Halaman | `{Nama Halaman}` |
| Route | `{/route}` |
| File utama | `{lib/features/...}` |
| Screen ID Stitch | `{screen-id}` |
| Status | `todo` |
| Mock | `{path mock}` atau `—` |
| Terakhir diperbarui | `{YYYY-MM-DD}` |
| Referensi | [`DESIGN.md`](../../design/DESIGN.md), [`components.md`](../../design/components.md) |

---

## 1. Tujuan

{Tujuan halaman dalam 1–3 kalimat.}

---

## 2. Scope

- {Section/fitur yang termasuk.}
- {Perilaku yang harus berfungsi.}

---

## 3. Di luar scope

- {Fitur yang sengaja belum dikerjakan.}
- {Batasan frontend-only: tidak ada backend/API/auth.}

---

## 4. Inventory (Gate 3)

| Screen | Section | Komponen desain | Token | Gambar | State | Interaksi |
| --- | --- | --- | --- | --- | --- | --- |
| `{/route}` | {Header} | {Komponen} | {role token} | {remote/icon/none} | {default/pressed/...} | {tap/scroll/...} |
| `{/route}` | {Section} | {Komponen} | {role token} | {remote/icon/none} | {state} | {interaksi} |

Aturan: isi hanya dari desain/kode aktual. Tandai `TBD` jika belum diketahui.

---

## 5. Component map (Gate 4)

| Komponen desain | Widget existing | Aksi | Path | Alasan |
| --- | --- | --- | --- | --- |
| {Komponen} | {Widget} | `reuse` | `{path}` | {alasan} |
| {Komponen} | — | `create` | `{path}` | {alasan} |

Nilai `Aksi`: `reuse`, `compose`, `extend`, `create`.

---

## 6. State & interaksi

| State | Trigger | Perilaku | Widget |
| --- | --- | --- | --- |
| Default | Halaman dibuka | {perilaku} | {widget} |
| Pressed | {trigger} | {feedback} | {widget} |
| Loading | {trigger} | {perilaku} | {widget} |
| Empty | {trigger} | {copy + CTA} | {widget} |
| Error | {trigger} | {pesan + retry} | {widget} |

Pertimbangkan juga: focused, disabled, success, dan text scale besar.
Tandai state yang tidak ada di desain sebagai **perlu keputusan**.

---

## 7. Data & mock

- Sumber mock: `{path}` (`// MOCK ONLY`).
- Field/data: {ringkas}.
- UI state Riverpod: {provider}.
- Batas backend: tidak ada database/API/repository.
- Gambar: {remote URL map / `AppNetworkImage`}.

---

## 8. Copy

| Lokasi | Copy |
| --- | --- |
| {Header/CTA/empty state} | `{copy aktual}` |
| {Section} | `{copy aktual}` |

---

## 9. A11y & responsive

- [ ] Semantics: label tombol, `selected`, `button`, label gambar.
- [ ] Touch target minimal 48×48.
- [ ] Text scale 1.0–2.0 tanpa clipping.
- [ ] Lebar 320–430 dp aman.
- [ ] Landscape phone tidak overflow.
- [ ] Kontras teks aman; tidak ada putih di `secondary-container`.
- [ ] `SafeArea`, keyboard, dan sticky bar tidak menutup konten.
- [ ] Gambar remote punya loading/error/fallback.

---

## 10. Acceptance

- [ ] {Section/fitur utama tampil.}
- [ ] {Filter/navigasi berfungsi.}
- [ ] {State empty/loading/error sesuai keputusan.}
- [ ] {Copy sesuai desain.}
- [ ] {Tidak ada overflow di 320 dan text scale 2.0.}
- [ ] {Tidak ada database/backend/API/auth.}

---

## 11. Verifikasi

- [ ] `dart format .`
- [ ] `flutter analyze`
- [ ] `flutter test`
- [ ] `flutter run -d <device-id>` di HP fisik
- [ ] Layout 320×568 via widget test
- [ ] Layout 390×844 via widget test
- [ ] Text scale 1.3 dan 2.0 via widget test
- [ ] Landscape phone via widget test
- [ ] Visual akhir di HP fisik
- [ ] Gambar remote dan fallback

Matriks lengkap: [`docs/rules/design-to-code.md`](../../rules/design-to-code.md) Gate 6.

---

## 12. Catatan & pertanyaan

- {Keputusan yang masih terbuka.}
- {Drift dokumen/desain yang ditemukan.}
- {Follow-up di luar scope.}
