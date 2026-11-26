// MOCK ONLY — state profil sementara.
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/profile_mock.dart';
import '../models/profile_data.dart';

class ProfileNotifier extends Notifier<ProfileData> {
  @override
  ProfileData build() => const ProfileData(
    name: ProfileMock.name,
    username: ProfileMock.username,
    phone: ProfileMock.phone,
    email: ProfileMock.email,
    addressLabel: ProfileMock.addressLabel,
    address: ProfileMock.address,
    userId: ProfileMock.userId,
    memberSince: ProfileMock.memberSince,
    supportCount: ProfileMock.supportCount,
    favoriteCount: ProfileMock.favoriteCount,
    favoriteSummary: ProfileMock.favoriteSummary,
    avatarSeed: ProfileMock.avatarSeed,
  );

  void saveProfile({
    required String name,
    required String username,
    required String phone,
    required String email,
  }) {
    state = state.copyWith(
      name: name.trim(),
      username: username.trim(),
      phone: phone.trim(),
      email: email.trim(),
    );
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, ProfileData>(
  ProfileNotifier.new,
);
