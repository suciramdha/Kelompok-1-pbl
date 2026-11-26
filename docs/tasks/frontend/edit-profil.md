# Edit Profil

> Dokumen kerja untuk halaman Edit Profil. Bukan design system dan bukan aturan
> global. Token ada di [`DESIGN.md`](../../design/DESIGN.md); registry komponen
> ada di [`components.md`](../../design/components.md).

| Field | Nilai |
| --- | --- |
| Halaman | Edit Profil |
| Route | `/profile/edit` |
| File utama | `lib/features/profile/presentation/pages/edit_profile_page.dart` |
| Shell | Top-level route di atas `StatefulShellRoute` (tanpa bottom nav) |
| Screen ID Stitch | `9da500fabcac4eac9947a449383b3616` |
| Status | `in-progress` |
| Mock | `lib/features/profile/presentation/mock/profile_mock.dart`, `lib/features/profile/presentation/providers/profile_provider.dart` |
| Terakhir diperbarui | 2026-11-24 |
| Referensi | [`DESIGN.md`](../../design/DESIGN.md), [`components.md`](../../design/components.md), [`design-to-code.md`](../../rules/design-to-code.md) |

Status `in-progress`: implementasi selesai dan `flutter analyze` bersih; e2e,
visual, dan matriks layout di HP fisik belum dijalankan karena diserahkan ke
pengguna.

---

## 1. Tujuan

Memungkinkan pengguna memperbarui identitas akun (nama, username, nomor
WhatsApp, email) dari halaman Profil. Perubahan disimpan di state UI sementara
dan langsung tercermin di ringkasan Profil selama sesi berjalan. Tidak ada
autentikasi, backend, atau persistence.

---

## 2. Scope

- Header tetap: back, judul `Edit Profil`, aksi `Simpan`.
- Avatar 96 dengan badge kamera, aksi `Ubah Foto Profil`, dan caption format.
- Kartu `Data Diri Pengguna`: Nama, Username + badge `Tersedia`, Nomor
  Handphone/WhatsApp + badge `Terverifikasi`, Email, ID Pengguna read-only +
  catatan `Terdaftar sejak`.
- Kartu `Alamat Pengiriman Utama` dengan badge `Utama`, alamat tersimpan, dan
  aksi `Kelola Daftar Alamat`.
- Validasi field, CTA `Simpan Perubahan`, dan `Batal`.
- Perubahan tersimpan ke provider UI-only dan terlihat di `/profile` setelah
  kembali.

---

## 3. Di luar scope

- Pemilih foto/galeri/kamera dan unggah berkas; belum ada dependency atau
  endpoint.
- Pengelolaan daftar alamat; route alamat belum ada.
- Persistence, database, backend, API, repository, auth, dan schema.
- Autentikasi dan guard route palsu.
- Dark mode.
- E2E, widget test, screenshot, dan verifikasi visual perangkat; dikerjakan
  pengguna.

---

## 4. Inventory (Gate 3)

| Screen | Section | Komponen desain | Token | Gambar | State | Interaksi |
| --- | --- | --- | --- | --- | --- | --- |
| `/profile/edit` | Header | `AppBar`, `AppButton` `Simpan`, back 48 | `surface`, `outline-variant`, `primary`, `on-primary` | icon | default; pressed; large text | Back; Simpan memvalidasi lalu menyimpan |
| `/profile/edit` | Avatar | `EditProfileAvatarSection`, `AppNetworkImage`, badge kamera | `surface-container-low`, `secondary-container`, `on-secondary-container`, `primary`, `on-surface-variant`, `elevation.card` | avatar remote | default; image loading/error; pressed; large text | Kamera/`Ubah Foto Profil` memberi SnackBar prototype |
| `/profile/edit` | Data diri | `EditProfileDataCard`, `AppTextField`, `AppBadge` | `surface-container-lowest`, `outline-variant`, `surface-container-low`, `secondary-container`, `primary-fixed`, `secondary-fixed`, `tertiary`, `error` | icon | default; focused; error validasi; read-only; large text | Input teks; validasi saat interaksi dan Simpan |
| `/profile/edit` | Alamat | `EditProfileAddressCard`, `AppBadge` | `surface-container-lowest`, `surface-container-low`, `surface-container`, `outline-variant`, `primary-fixed`, `secondary`, `on-surface` | icon | default; pressed; large text | `Kelola Daftar Alamat` memberi SnackBar prototype |
| `/profile/edit` | Aksi | `AppButton` primary + neutral | `primary`, `on-primary`, `surface-container-low`, `on-surface`, `outline-variant` | icon | default; pressed; large text | Simpan; Batal kembali ke Profil |

---

## 5. Component map (Gate 4)

| Komponen desain | Widget existing | Aksi | Path | Alasan |
| --- | --- | --- | --- | --- |
| Text field berlabel | `AppTextField` | `create` | `lib/core/ui/app_text_field.dart` | Primitive baru: label + trailing slot, validator, leading icon, read-only |
| Badge status | `AppBadge` | `create` | `lib/core/ui/app_badge.dart` | Primitive baru untuk `Tersedia`, `Terverifikasi`, `Utama` |
| Tombol | `AppButton` | `extend` | `lib/core/ui/app_button.dart` | Tambah varian `neutral` untuk `Batal` |
| Halaman | — | `create` | `lib/features/profile/presentation/pages/edit_profile_page.dart` | Form + controller + aksi simpan/batal |
| Avatar | — | `create` | `lib/features/profile/presentation/widgets/edit_profile_avatar_section.dart` | Komposit khusus dengan badge kamera dan fallback inisial |
| Kartu data diri | — | `create` | `lib/features/profile/presentation/widgets/edit_profile_data_card.dart` | Lima field + validasi khusus |
| Kartu alamat | — | `create` | `lib/features/profile/presentation/widgets/edit_profile_address_card.dart` | Alamat + aksi pengelolaan |
| Gambar avatar | `AppNetworkImage` | `reuse` | `lib/core/ui/app_network_image.dart` | Loading/error + semantic label |
| State profil | `ProfileNotifier` | `create` | `lib/features/profile/presentation/providers/profile_provider.dart` | UI-only, in-memory, tanpa repository |
| Feedback | `ScaffoldMessenger` + `SnackBar` | `reuse` | — | Pola yang sama dengan halaman lain |

---

## 6. State & interaksi

| State | Trigger | Perilaku | Widget |
| --- | --- | --- | --- |
| Default | Buka `/profile/edit` | Field terisi dari provider; ID read-only | `EditProfilePage` |
| Pressed | Tap tombol/aksi | Ink feedback; CTA utama scale 0.98 dari `AppButton` | `AppButton`, `InkWell` |
| Focused | Fokus field | Border `secondary-container`; keyboard muncul | `AppTextField` |
| Error | Input tidak valid | Pesan per field; Simpan tidak menyimpan | `AppTextField`, `Form` |
| Read-only | Field ID | Teks `on-surface-variant`; tidak dapat diubah | `AppTextField` |
| Success | Simpan valid | SnackBar `Perubahan profil berhasil disimpan.`; provider diperbarui; kembali ke Profil | `EditProfilePage`, `ProfileNotifier` |
| Image loading | Avatar dimuat | Placeholder progres `AppNetworkImage` | `AppNetworkImage` |
| Image error | Avatar gagal | Fallback inisial nama | `EditProfileAvatarSection` |
| Large text | Text scale > 1.5 | Label/badge turun; header 72; CTA maks. 2 baris | `AppTextField`, `EditProfileDataCard`, `EditProfileAddressCard` |
| Foto | Tap kamera/`Ubah Foto Profil` | SnackBar `Ubah foto profil belum tersedia di prototype.` | `EditProfileAvatarSection` |
| Alamat | Tap `Kelola Daftar Alamat` | SnackBar `Ubah alamat belum tersedia di prototype.` | `EditProfileAddressCard` |

Tidak ada loading/success async palsu; tidak ada delay buatan. Badge `Tersedia`
bersifat statis sesuai desain, bukan pengecekan ketersediaan nyata.

---

## 7. Data & mock

- `profile_mock.dart` (`// MOCK ONLY — hapus saat backend tersedia.`):
  `name`, `username`, `phone`, `email`, `addressLabel`, `address`, `userId`,
  `memberSince`, `supportCount`, `favoriteCount`, `favoriteSummary`,
  `avatarSeed`.
- `profile_provider.dart` (`// MOCK ONLY — state profil sementara.`):
  `ProfileNotifier extends Notifier<ProfileData>`; `saveProfile` hanya
  memperbarui nama, username, telepon, dan email di memori.
- `ProfileData` adalah view model UI; tanpa `fromJson`/`toJson`.
- `/profile` memakai `profileProvider`, sehingga hasil simpan langsung terlihat.
- Batas backend: tidak ada database, API, repository, auth, atau persistence.
- Gambar: `RemoteImages.avatar(avatarSeed)` via `AppNetworkImage`; fallback
  inisial.

---

## 8. Copy

| Lokasi | Copy |
| --- | --- |
| Header | `Edit Profil`, `Simpan`, tooltip `Kembali` |
| Avatar | `Ubah Foto Profil`, `Format JPG, PNG maks. 5MB`, tooltip `Ubah foto profil` |
| Kartu data diri | `Data Diri Pengguna`, `Nama Lengkap`, `Username`, `Nomor Handphone / WhatsApp`, `Alamat Email`, `ID Pengguna`, `Tersedia`, `Terverifikasi`, `Terdaftar sejak {memberSince}` |
| Hint | `Masukkan nama lengkap` |
| Validasi | `Nama lengkap wajib diisi.`, `Nama minimal 3 karakter.`, `Username diawali @ dan 3–20 karakter.`, `Nomor handphone tidak valid.`, `Format email tidak valid.` |
| Alamat | `Alamat Pengiriman Utama`, `Utama`, `Alamat Tersimpan (Utama)`, `Kelola Daftar Alamat` |
| Aksi | `Simpan Perubahan`, `Batal` |
| SnackBar | `Perubahan profil berhasil disimpan.`, `Ubah foto profil belum tersedia di prototype.`, `Ubah alamat belum tersedia di prototype.` |

---

## 9. A11y & responsive

- [x] `Semantics(header: true)` pada judul kartu data diri dan alamat.
- [x] Badge kamera memakai `Semantics(button: true, label: 'Ubah foto profil')`,
      hit target 48, visual 36.
- [x] Tombol back tooltip `Kembali`; CTA memakai Semantics dari `AppButton`.
- [x] Avatar memakai `semanticLabel`; fallback inisial tetap terbaca.
- [x] Touch target field dan tombol minimal 48.
- [x] Tidak ada putih di `secondary-container`; badge memakai
      `on-secondary-container`.
- [x] Text scale > 1.5: label/badge turun, header 72, judul ellipsis, CTA dua
      baris.
- [x] Keyboard: `ListView` scroll, `SafeArea(top: false)`, `Scaffold` resize.
- [x] Lebar > 600 dibatasi `ConstrainedBox(maxWidth: 600)` lalu di-center.
- [ ] 320/360/412/430 dp, landscape, dan TalkBack/VoiceOver belum diuji di
      perangkat.

---

## 10. Acceptance

- [x] Header, avatar, kartu data diri, kartu alamat, dan aksi tampil.
- [x] Semua field memakai `AppTextField`; ID read-only.
- [x] Badge `Tersedia`, `Terverifikasi`, dan `Utama` memakai `AppBadge`.
- [x] Validasi nama/username/telepon/email berfungsi.
- [x] `Simpan` header dan `Simpan Perubahan` memakai handler yang sama.
- [x] Simpan valid memperbarui provider dan kembali ke Profil.
- [x] `Batal` dan back kembali ke Profil.
- [x] Aksi foto dan alamat memberi SnackBar prototype; tidak ada tombol mati.
- [x] Mock ditandai `// MOCK ONLY`; tidak ada backend/API/auth.
- [x] Avatar memakai `AppNetworkImage` + fallback inisial.
- [x] `flutter analyze` bersih.
- [ ] E2E dan visual di HP fisik (diserahkan ke pengguna).
- [ ] 320–430 dp, text scale 2.0, landscape, dan screen reader.

---

## 11. Verifikasi

| Pemeriksaan | Hasil |
| --- | --- |
| `dart format` file terkait | Bersih, 0 file berubah |
| `flutter analyze` | `No issues found!` |
| `flutter test` | Tidak dijalankan sesuai instruksi pengguna |
| E2E / `flutter run` | Belum dijalankan; pengguna akan melakukan e2e |
| Visual Stitch | Belum dibandingkan di perangkat; referensi screen `9da500f...` |
| Layout 320 / text scale 2.0 | Belum diuji |
| Gambar remote / fallback | Implementasi ada; belum diuji runtime |

---

## 12. Catatan & follow-up

1. **Foto profil belum bisa diganti** karena tidak ada `image_picker`; aksi
   hanya feedback prototype. Menambah dependency perlu persetujuan.
2. **Kelola alamat belum punya route**; aksi memakai SnackBar yang sama dengan
   halaman Profil.
3. **Badge `Tersedia` statis** sesuai desain, bukan validasi ketersediaan
   username.
4. **Provider tidak persisten**; restart aplikasi mengembalikan data mock.
5. **Profil belum menampilkan username/alamat**; field tersebut baru dipakai di
   halaman edit dan state, menunggu keputusan desain Profil.
