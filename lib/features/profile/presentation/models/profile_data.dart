/// View model UI profil pengguna. Hanya untuk tampilan, tanpa persistence.
class ProfileData {
  const ProfileData({
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.addressLabel,
    required this.address,
    required this.userId,
    required this.memberSince,
    required this.favoriteSummary,
    required this.avatarSeed,
    required this.supportCount,
    required this.favoriteCount,
  });

  final String name;
  final String username;
  final String phone;
  final String email;
  final String addressLabel;
  final String address;
  final String userId;
  final String memberSince;
  final String favoriteSummary;
  final String avatarSeed;
  final int supportCount;
  final int favoriteCount;

  ProfileData copyWith({
    String? name,
    String? username,
    String? phone,
    String? email,
    String? addressLabel,
    String? address,
    String? userId,
    String? memberSince,
    String? favoriteSummary,
    String? avatarSeed,
    int? supportCount,
    int? favoriteCount,
  }) {
    return ProfileData(
      name: name ?? this.name,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      addressLabel: addressLabel ?? this.addressLabel,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      memberSince: memberSince ?? this.memberSince,
      favoriteSummary: favoriteSummary ?? this.favoriteSummary,
      avatarSeed: avatarSeed ?? this.avatarSeed,
      supportCount: supportCount ?? this.supportCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
    );
  }
}
