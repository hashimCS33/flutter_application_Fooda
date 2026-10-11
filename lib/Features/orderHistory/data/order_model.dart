class OrderHistoryResponse {
  final String message;
  final List<OrderModel> orders;

  OrderHistoryResponse({required this.message, required this.orders});

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResponse(
      message: json['message']?.toString() ?? '',
      orders:
          (json['data'] as List? ?? [])
              .map((e) => OrderModel.fromJson(e))
              .toList(),
    );
  }
}

class OrderModel {
  final int id;
  final String status;
  final String total;
  final String? createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status']?.toString() ?? '',
      total: json['total'].toString(),
      createdAt: json['created_at']?.toString(),
      items:
          (json['items'] as List? ?? [])
              .map((e) => OrderItemModel.fromJson(e))
              .toList(),
    );
  }
}

class OrderItemModel {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final String price;

  OrderItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['image']?.toString() ?? '';
    return OrderItemModel(
      itemId: json['item_id'],
      productId: json['product_id'],
      name: json['name']?.toString() ?? '',
      // Android emulator can't reach the host via 127.0.0.1/localhost; use 10.0.2.2 like the API base URL.
      image: rawImage.replaceFirst(
        RegExp(r'^https?://(127\.0\.0\.1|localhost)'),
        'http://10.0.2.2',
      ),
      quantity: json['quantity'],
      price: json['price'].toString(),
    );
  }
}
