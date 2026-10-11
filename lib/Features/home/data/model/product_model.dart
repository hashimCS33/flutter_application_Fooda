class ProductModel {
  int id;
  String name;
  String image;
  String desc;
  String price;
  String rate;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.desc,
    required this.price,
    required this.rate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['image_url'] ?? json['image'] ?? '';
    return ProductModel(
      id: json['id'],
      name: json['name'],
      // Android emulator can't reach the host via 127.0.0.1/localhost; use 10.0.2.2 like the API base URL.
      image: rawImage.toString().replaceFirst(
        RegExp(r'^https?://(127\.0\.0\.1|localhost)'),
        'http://10.0.2.2',
      ),
      desc: json['description'],
      price: json['price'].toString(),
      rate: json['rating'].toString(),
    );
  }
}
