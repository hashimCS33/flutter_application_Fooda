// send to backend

class CartModel {
  final int productid;
  final double spicy;
  final int quantity;
  final List<int> toppings;
  final List<int> sideOptions;

  CartModel({
    required this.productid,
    required this.spicy,
    required this.quantity,
    required this.toppings,
    required this.sideOptions,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productid,
      'spicy': spicy,
      'quantity': quantity,
      'toppings': toppings,
      'side_options': sideOptions,
    };
  }
}

class CartRequestModel {
  List<CartModel> items;

  CartRequestModel({required this.items});

  Map<String, dynamic> toJson() {
    return {'items': items.map((item) => item.toJson()).toList()};
  }
}

// get from backend

class GetCartResponse {
  final int code;
  final String message;
  final CartData cartData;

  GetCartResponse({
    required this.code,
    required this.message,
    required this.cartData,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      code: json['code'],
      message: json['message'],
      cartData: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final int id;
  final String total_price;
  final List<CartitemModel> items;

  CartData({required this.id, required this.total_price, required this.items});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      total_price: json['total_price'].toString() ?? '0',
      items:
          (json['items'] as List)
              .map((e) => CartitemModel.fromJson(e))
              .toList(),
    );
  }
}

class CartitemModel {
  final int item_id;
  final String name;
  final int productid;
  final double spicy;
  final int quantity;
  final List<Topping> toppings;
  final List<Options> options;
  final String price;
  final String image;

  CartitemModel({
    required this.item_id,

    required this.name,
    required this.productid,
    required this.spicy,
    required this.quantity,
    required this.toppings,
    required this.options,
    required this.price,
    required this.image,
  });

  factory CartitemModel.fromJson(Map<String, dynamic> json) {
    return CartitemModel(
      item_id: json['item_id'],
      image: json['image'],
      name: json['name'],
      productid: json['product_id'],
      spicy: json['spicy'] == null ? 0 : double.parse(json['spicy'].toString()),
      quantity: json['quantity'],
      toppings:
          (json['toppings'] as List).map((e) => Topping.fromJson(e)).toList(),
      options:
          (json['side_options'] as List)
              .map((e) => Options.fromJson(e))
              .toList(),
      price: json['price'].toString(),
    );
  }
}

class Topping {
  final int id;
  final String name;
  final String price;
  final String image;

  Topping({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      id: json['id'],
      name: json['name'],
      price: json['price'].toString(),
      image: json['image'],
    );
  }
}

class Options {
  final int id;
  final String name;
  final String price;
  final String image;

  Options({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      id: json['id'],
      name: json['name'],
      price: json['price'].toString(),
      image: json['image'],
    );
  }
}
