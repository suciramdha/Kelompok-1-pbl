import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/theme_context.dart';
import '../../../../core/ui/app_button.dart';
import '../providers/profile_provider.dart';
import '../widgets/edit_profile_address_card.dart';
import '../widgets/edit_profile_avatar_section.dart';
import '../widgets/edit_profile_data_card.dart';

/// Lebar maksimum konten agar tetap nyaman di handphone lebar/foldable.
const _maxContentWidth = 600.0;

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  /// ID pengguna hanya ditampilkan, tidak bisa diubah.
  late final TextEditingController _userIdController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _nameController = TextEditingController(text: profile.name);
    _usernameController = TextEditingController(text: profile.username);
    _phoneController = TextEditingController(text: profile.phone);
    _emailController = TextEditingController(text: profile.email);
    _userIdController = TextEditingController(text: profile.userId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final profileNotifier = ref.read(profileProvider.notifier);
    profileNotifier.saveProfile(
      name: _nameController.text.trim(),
      username: _usernameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
    );
    _showMessage('Perubahan profil berhasil disimpan.');
    _back();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    final scheme = Theme.of(context).colorScheme;
    final spacing = context.spacing;
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: largeText ? 72 : 64,
        titleSpacing: 0,
        shape: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        leading: IconButton(
          onPressed: _back,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'Edit Profil',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: spacing.lg),
            child: Center(
              child: AppButton(
                label: 'Simpan',
                onPressed: _save,
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.md,
                  vertical: spacing.sm,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  spacing.margin,
                  spacing.lg,
                  spacing.margin,
                  spacing.xl,
                ),
                children: [
                  EditProfileAvatarSection(
                    name: profile.name,
                    avatarSeed: profile.avatarSeed,
                    onChangePhoto: () => _showMessage(
                      'Ubah foto profil belum tersedia di prototype.',
                    ),
                  ),
                  SizedBox(height: spacing.lg),
                  EditProfileDataCard(
                    nameController: _nameController,
                    usernameController: _usernameController,
                    phoneController: _phoneController,
                    emailController: _emailController,
                    userIdController: _userIdController,
                    memberSince: profile.memberSince,
                  ),
                  SizedBox(height: spacing.lg),
                  EditProfileAddressCard(
                    addressLabel: profile.addressLabel,
                    address: profile.address,
                    onManageAddresses: () => _showMessage(
                      'Ubah alamat belum tersedia di prototype.',
                    ),
                  ),
                  SizedBox(height: spacing.lg),
                  _ActionSection(onSave: _save, onCancel: _back),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection({required this.onSave, required this.onCancel});

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          label: 'Simpan Perubahan',
          icon: Icons.check_circle_rounded,
          labelMaxLines: 2,
          expand: true,
          onPressed: onSave,
        ),
        SizedBox(height: spacing.md),
        AppButton(
          label: 'Batal',
          variant: AppButtonVariant.neutral,
          labelMaxLines: 2,
          expand: true,
          onPressed: onCancel,
        ),
      ],
    );
  }
}
