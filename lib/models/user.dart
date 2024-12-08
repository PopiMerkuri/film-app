class User {
  final String name;
  final String email;
  final String? phone; // Tambahkan atribut tambahan jika ada
  final String? profilePicture; // Contoh atribut tambahan

  User({
    required this.name,
    required this.email,
    this.phone,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      phone: json['phone'],
      profilePicture: json['profilePicture'],
    );
  }
}
