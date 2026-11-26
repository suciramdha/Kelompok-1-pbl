import 'package:flutter/material.dart';

import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_badge.dart';
import '../../../../core/ui/app_text_field.dart';

/// Kartu putih "Data Diri Pengguna": lima field dengan satu baris label utuh
/// per field dan validasi masing-masing.
class EditProfileDataCard extends StatelessWidget {
  const EditProfileDataCard({
    super.key,
    required this.nameController,
    required this.usernameController,
    required this.phoneController,
    required this.emailController,
    required this.userIdController,
    required this.memberSince,
  });

  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  /// Field hanya-baca berisi ID pengguna.
  final TextEditingController userIdController;

  /// Tanggal bergabung, ditampilkan sebagai catatan di baris label ID.
  final String memberSince;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.spacing;

    return Container(
      padding: EdgeInsets.all(spacing.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: context.radius.lgRadius,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExcludeSemantics(
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 22,
                      color: scheme.primary,
                    ),
                  ),
                  SizedBox(width: spacing.sm),
                  Expanded(
                    child: Text(
                      'Data Diri Pengguna',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing.lg),
            AppTextField(
              controller: nameController,
              label: 'Nama Lengkap',
              hintText: 'Masukkan nama lengkap',
              leadingIcon: Icons.person_outline_rounded,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              textCapitalization: TextCapitalization.words,
              validator: _validateName,
            ),
            SizedBox(height: spacing.lg),
            AppTextField(
              controller: usernameController,
              label: 'Username',
              labelTrailing: const AppBadge(
                label: 'Tersedia',
                icon: Icons.check_circle_rounded,
                tone: AppBadgeTone.success,
              ),
              leadingIcon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.username],
              validator: _validateUsername,
            ),
            SizedBox(height: spacing.lg),
            AppTextField(
              controller: phoneController,
              label: 'Nomor Handphone / WhatsApp',
              labelTrailing: const AppBadge(
                label: 'Terverifikasi',
                icon: Icons.verified_rounded,
                tone: AppBadgeTone.secondary,
              ),
              leadingIcon: Icons.call_rounded,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.telephoneNumber],
              validator: _validatePhone,
            ),
            SizedBox(height: spacing.lg),
            AppTextField(
              controller: emailController,
              label: 'Alamat Email',
              leadingIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.email],
              validator: _validateEmail,
            ),
            SizedBox(height: spacing.lg),
            AppTextField(
              controller: userIdController,
              label: 'ID Pengguna',
              labelTrailing: Text(
                'Terdaftar sejak $memberSince',
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              leadingIcon: Icons.badge_outlined,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}

final _usernamePattern = RegExp(r'^@[a-zA-Z0-9._]{3,20}$');
final _phoneCharacters = RegExp(r'^[0-9+\-\s]+$');
final _emailPattern = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

String? _validateName(String? value) {
  final name = value?.trim() ?? '';
  if (name.isEmpty) return 'Nama lengkap wajib diisi.';
  if (name.length < 3) return 'Nama minimal 3 karakter.';
  return null;
}

String? _validateUsername(String? value) {
  final username = value?.trim() ?? '';
  if (!_usernamePattern.hasMatch(username)) {
    return 'Username diawali @ dan 3–20 karakter.';
  }
  return null;
}

String? _validatePhone(String? value) {
  final phone = value?.trim() ?? '';
  final digits = phone.replaceAll(RegExp(r'\D'), '');
  final validCharacters = _phoneCharacters.hasMatch(phone);
  if (!validCharacters || digits.length < 10 || digits.length > 15) {
    return 'Nomor handphone tidak valid.';
  }
  return null;
}

String? _validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (!_emailPattern.hasMatch(email)) return 'Format email tidak valid.';
  return null;
}
