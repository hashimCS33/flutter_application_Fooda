class OptionModel {
  int id;
  String name;
  String image;

  OptionModel({required this.id, required this.name, required this.image});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['image_url'] ?? json['image'] ?? '';
    return OptionModel(
      id: json['id'],
      name: json['name'],
      // Android emulator can't reach the host via 127.0.0.1/localhost; use 10.0.2.2 like the API base URL.
      image: rawImage.toString().replaceFirst(
        RegExp(r'^https?://(127\.0\.0\.1|localhost)'),
        'http://10.0.2.2',
      ),
    );
  }
}
