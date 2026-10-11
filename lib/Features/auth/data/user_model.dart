class UserModel {
  final String name;
  final String Email;
  final String? image;
  final String? token;
  final String? visa;
  final String? address;
  final String? imageUrl;

  UserModel({
    required this.name,
    required this.Email,
    this.image,
    this.token,
    this.visa,
    this.address,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      Email: json['email'] ?? '',
      image: json['image'],
      token: json['token'],
      visa: json['visa'],
      address: json['address'],
      // Android emulator can't reach the host via 127.0.0.1/localhost; use 10.0.2.2 like the API base URL.
      imageUrl: json['image_url']?.toString().replaceFirst(
        RegExp(r'^https?://(127\.0\.0\.1|localhost)'),
        'http://10.0.2.2',
      ),
    );
  }
}
